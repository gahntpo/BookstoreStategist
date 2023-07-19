//
//  ExpenseViewModel.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 18.07.23.
//

import Foundation
import Combine

class ExpenseViewModel: ObservableObject {
    
    @Published var expenses: [Expense] = []
    @Published var fixedExpensesData: [(date: Date, amount: Double)] = []
    @Published var variableExpensesData: [(date: Date, amount: Double)] = []
    
    @Published var monthlyFixedExpensesData: [(month: Int, amount: Double)] = []
    @Published var monthlyVariableExpensesData: [(month: Int, amount: Double)] = []
    
    @Published var monthlyExpensesData: [ExpenseStates] = []
    
    @Published var totalExpenses: Double = 0
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $expenses.filter { !$0.isEmpty }.sink { [unowned self] expenses in
            self.fixedExpensesData = self.filteredExpenses(for: .fixed, expenses: expenses)
            self.variableExpensesData = self.filteredExpenses(for: .variable, expenses: expenses)

            self.monthlyFixedExpensesData = self.expensesByMonth(for: .fixed, expenses: expenses)
            self.monthlyVariableExpensesData = self.expensesByMonth(for: .variable, expenses: expenses)
            
            self.monthlyExpensesData = self.calculateTotalMonthlyExpenses(fixedExpenses: self.monthlyFixedExpensesData,
                                                                          variableExpense: self.monthlyVariableExpensesData)
            self.totalExpenses = self.calculateTotal(for: expenses)
        }
        .store(in: &subscriptions)
    }
    
    func filteredExpenses(for category: ExpenseCategory, expenses: [Expense]) ->  [(date: Date, amount: Double)] {
        let result = expenses.filter { $0.category == category }
        return result.sorted(by: { $0.expenseDate < $1.expenseDate })
            .map { (date: $0.expenseDate, amount: $0.amount) }
    }
    
    func expensesByMonth(for category: ExpenseCategory, expenses: [Expense]) -> [(month: Int, amount: Double)] {
        let calendar = Calendar.current
        var expensesByMonth: [Int: Double] = [:]

        for expense in expenses where expense.category == category {
            let month = calendar.component(.month, from: expense.expenseDate)
            expensesByMonth[month, default: 0] += expense.amount
        }
        
        let result = expensesByMonth.map { (month: $0.key, amount: $0.value) }

        return result.sorted { $0.month < $1.month }
    }
    
    func calculateTotalMonthlyExpenses(fixedExpenses: [(month: Int, amount: Double)], variableExpense: [(month: Int, amount: Double)]) -> [ExpenseStates] {
        var result = [ExpenseStates]()
        let count = min(fixedExpenses.count, variableExpense.count)
        
        for index in 0..<count {
            let month = fixedExpenses[index].month
            result.append(ExpenseStates(month: month,
                                        fixedExpenses: fixedExpenses[index].amount,
                                        variableExpenses: variableExpense[index].amount))
        }
        
        return result
    }
    
    func calculateTotal(for expenses: [Expense]) -> Double {
        let totalExpenses = expenses.reduce(0) { total, expense in
            total + expense.amount
        }
        return totalExpenses
    }
    
    //MARK: - Preview
    
    static var preview: ExpenseViewModel {
        let vm = ExpenseViewModel()
        vm.expenses = Expense.yearExamples
        return vm
    }
    
    
}


struct ExpenseStates: Identifiable {
    let month: Int
    let fixedExpenses: Double
    let variableExpenses: Double
    var totalExpenses: Double {
        fixedExpenses + variableExpenses
    }
    
    var id: Int { return month }
}
