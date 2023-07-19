//
//  DetailExpensesView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 18.07.23.
//

import SwiftUI

struct DetailExpensesView: View {
    
    @ObservedObject var expensesViewModel: ExpenseViewModel
    
    var body: some View {
        List {
            Group {
                Section {
                    ExpensesLineChartView(expensesViewModel: expensesViewModel)
                        .padding(.bottom)
                }
                
                Section {
                    Text("Detailed Breakdown of Your Expenses per Month")
                        .bold()
                        .padding(.top)
                    ExpensesDetailGridView(expensesViewModel: expensesViewModel)
                }
            }
            .listRowSeparator(.hidden)
            .listSectionSeparator(.visible)
            .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
        }
        .listStyle(.plain)
      
    }
}

#Preview {
    DetailExpensesView(expensesViewModel: .preview)
}
