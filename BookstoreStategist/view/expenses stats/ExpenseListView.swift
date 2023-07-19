//
//  ExpenseListView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 18.07.23.
//

import SwiftUI

struct ExpenseListView: View {
    
    @StateObject var expensesViewModel = ExpenseViewModel.preview
    
    var body: some View {
        List {
            DisclosureGroup(
                content: {
                    ForEach(expensesViewModel.expenses) { expense in
                        ExpenseRow(expense: expense)
                    }
                }, label: {
                    Text("All Expenses")
                }
            )
          
            DisclosureGroup {
                ForEach(expensesViewModel.fixedExpensesData, id: \.date) { expense in
                    HStack {
                       
                        Text("\(expense.date, style: .date) expense \(String(format: "%.1f", expense.amount))")
                    }
                }
            } label: {
                Text("Fixed Expenses")
            }

            DisclosureGroup {
                ForEach(expensesViewModel.monthlyFixedExpensesData, id: \.month) { expenseData in
                    HStack {
                       
                        Text("month: \(expenseData.month)")
                        Text("expense \(String(format: "%.1f", expenseData.amount))")
                    }
                }
            } label: {
                Text("Fixed Expenses per month")
            }

           
        }
    }
}

struct ExpenseRow: View {
    let expense: Expense
    var body: some View {
        VStack {
            HStack {
                Text(expense.expenseDate, style: .date)
                Spacer()
                Text( String(format: "%.0f", expense.amount))
                    .bold()
            }
            HStack {
                Text(expense.title)
                 
                Spacer()
                Text(expense.category.displayName)
                    .bold()
                    .foregroundStyle(expense.category == .fixed ? Color.indigo : Color.cyan)
            }
            .font(.caption)
        }
    }
}


#Preview {
    ExpenseListView()
}
