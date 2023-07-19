//
//  ChartAxisExampleView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 19.07.23.
//

import SwiftUI
import Charts

struct ChartAxisExampleView: View {
    @ObservedObject var expensesViewModel: ExpenseViewModel
    var body: some View {
        
        Chart {
                ForEach(expensesViewModel.monthlyFixedExpensesData, id: \.month) { expenseData in
                    BarMark(x: .value("Month", expenseData.month),
                            y: .value("Expense", expenseData.amount),
                            width: .inset(5))
                    
                }
        }
        .chartYScale(domain: 0...19000)
        .chartYAxis {
            
            AxisMarks(position: .leading, values: [0, 5000, 10000, 15000]) {
                AxisGridLine().foregroundStyle(.green)
                AxisValueLabel()
            }
            
            AxisMarks(position: .trailing, values: [7500, 12500]) {
                AxisGridLine().foregroundStyle(.gray)
                
                if let amount = $0.as(Int.self) {
                   AxisValueLabel("\(amount / 1000) K ")
                 }
            }
            /*
             AxisMarks(values: .automatic(minimumStride: 2,
                                          desiredCount: 6,
                                          roundLowerBound: true,
                                          roundUpperBound: true))
             */
        }
        
        .chartXScale(domain: 0...13)
        
        .chartXAxis {
            AxisMarks(values: [1, 4, 7, 10]) { value in
                AxisGridLine()
                AxisTick()
                
                if let monthNumber = value.as(Int.self), monthNumber > 0, monthNumber < 13 {
                
                    AxisValueLabel(month(for: monthNumber), centered: false, anchor: .top)
                       // .foregroundStyle(colors[value.index])
                    
                }
            }
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
    ChartAxisExampleView(expensesViewModel: .preview)

}
