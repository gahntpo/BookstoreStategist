//
//  ExpensesBarChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 19.07.23.
//

import SwiftUI
import Charts

struct ExpensesBarChartView: View {
    
    @ObservedObject var expensesViewModel: ExpenseViewModel
    var body: some View {
        Chart {
            ForEach(expensesViewModel.monthlyFixedExpensesData, id: \.month) { expenseData in
                BarMark(x: .value("Month", month(for: expenseData.month)),
                        y: .value("Expense", expenseData.amount))
            }
            .foregroundStyle(by: .value("Expense", "fixed"))
            .symbol(by: .value("Expense", "fixed"))
            .position(by: .value("Expenses", "fixed"))
            
            ForEach(expensesViewModel.monthlyVariableExpensesData, id: \.month) { expenseData in
                BarMark(x: .value("Date", month(for: expenseData.month)),
                        y: .value("Expense", expenseData.amount))
            }
            .foregroundStyle(by: .value("Expense", "variable"))
            .symbol(by: .value("Expense", "variable"))
            .position(by: .value("Expenses", "variable"))
            
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
    
    let formatter = DateFormatter()
    
    func month(for number: Int) -> String {
        // to short - charts cannot uniquely identify
        // formatter.veryShortMonthSymbols[number - 1]
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
    
}

#Preview {
    ExpensesBarChartView(expensesViewModel: .preview)
}
