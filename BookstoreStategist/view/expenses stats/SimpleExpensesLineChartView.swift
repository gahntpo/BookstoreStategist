//
//  SimpleExpensesLineChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 18.07.23.
//

import SwiftUI
import Charts

struct SimpleExpensesLineChartView: View {
    
    @ObservedObject var expensesViewModel: ExpenseViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Your total expenses for the last year are ") +
            Text("$\(String(format: "%.2f", expensesViewModel.totalExpenses)).")
                .bold()
                .foregroundColor(Color.pink)
            
            Chart {
                Plot {
                    ForEach(expensesViewModel.monthlyExpensesData) { expenseData in
                        AreaMark(x: .value("Date", expenseData.month),
                                 y: .value("Expense", expenseData.totalExpenses))
                    }
                }
                .interpolationMethod(.linear)
                .foregroundStyle(.pink)
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .chartLegend(.hidden)
            .chartXScale(domain: 1...12)
            
            .frame(height: 70)
        }
    }
    
    let formatter = DateFormatter()
    
    func month(for number: Int) -> String {
        // to short - charts cannot uniquely identify
        // formatter.veryShortMonthSymbols[number - 1]
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
    
}


#Preview {
    SimpleExpensesLineChartView(expensesViewModel: .preview)
        .padding(.horizontal)
}
