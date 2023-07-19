//
//  ExpensesDetailGridView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 18.07.23.
//

import SwiftUI

struct ExpensesDetailGridView: View {
    
    @ObservedObject var expensesViewModel: ExpenseViewModel
    
    var body: some View {
        
        Grid(alignment: .trailing, horizontalSpacing: 15, verticalSpacing: 10) {
            GridRow {
                Color.clear
                    .gridCellUnsizedAxes([.vertical, .horizontal])
                Text("Fixed")
                    .gridCellAnchor(.center)
                Text("Variable")
                Text("All")
                    .bold()
                    .gridCellAnchor(.center)
            }
            
           Divider()
            .gridCellUnsizedAxes([.vertical, .horizontal])
            
            ForEach(expensesViewModel.monthlyExpensesData) { data in
                GridRow {
                    Text(month(for: data.month))
                    
                    Text(String(format: "%.2f", data.fixedExpenses))
                    Text(String(format: "%.2f", data.variableExpenses))
                    Text(String(format: "%.2f", data.totalExpenses))
                        .bold()
                }
                
            }
            
            Divider()
                .gridCellUnsizedAxes([.vertical, .horizontal])
            GridRow {
                Text("Total")
                    .bold()
                
                Color.clear
                    .gridCellUnsizedAxes([.vertical, .horizontal])
                   
                    .gridCellColumns(2) // Span two columns.
                
                Text("$" + String(format: "%.2f", expensesViewModel.totalExpenses))
                    .bold()
                    .foregroundStyle(.pink)
                    .fixedSize()
                  
            }
        }
    }
    
    let formatter = DateFormatter()
    
    func month(for number: Int) -> String {
        formatter.shortMonthSymbols[number - 1]
    }
}

#Preview {
    ExpensesDetailGridView(expensesViewModel: .preview)
        .padding()
}
