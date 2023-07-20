//
//  ExpensesLineChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 18.07.23.
//

import SwiftUI
import Charts

struct ExpensesLineChartView: View {
    
    @ObservedObject var expensesViewModel: ExpenseViewModel
    let symbolSize: CGFloat = 100
    let lineWidth: CGFloat = 3
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your total expenses for the last year are ") +
            Text("$\(String(format: "%.2f", expensesViewModel.totalExpenses)).")
                .bold()
                .foregroundColor(.pink)
            
            Chart {
                Plot {
                    ForEach(expensesViewModel.monthlyFixedExpensesData, id: \.month) { expenseData in
                        LineMark(x: .value("Month", expenseData.month),
                                 y: .value("Expense", expenseData.amount))
                    }
                    .foregroundStyle(by: .value("Expense", "fixed"))
                    .symbol(by: .value("Expense", "fixed"))
                    
                    ForEach(expensesViewModel.monthlyVariableExpensesData, id: \.month) { expenseData in
                        LineMark(x: .value("Date", expenseData.month),
                                 y: .value("Expense", expenseData.amount))
                    }
                    .foregroundStyle(by: .value("Expense", "variable"))
                    .symbol(by: .value("Expense", "variable"))
                    
                }
                .interpolationMethod(.monotone)
                .lineStyle(StrokeStyle(lineWidth: lineWidth))
                
            }
            .chartForegroundStyleScale([
                "variable": .purple,
                "fixed": .cyan
            ])
            .chartSymbolScale([
                "variable": Circle().strokeBorder(lineWidth: lineWidth),
                "fixed": Square().strokeBorder(lineWidth: lineWidth)
            ])
            .aspectRatio(1, contentMode: .fit)
            
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
        }
    }
    
    let formatter = DateFormatter()
    
    func month(for number: Int) -> String {
        // to short - charts cannot uniquely identify
        // formatter.veryShortMonthSymbols[number - 1]
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
    
}

/// A square symbol for charts.
struct Square: ChartSymbolShape, InsettableShape {
    let inset: CGFloat

    init(inset: CGFloat = 0) {
        self.inset = inset
    }

    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 1
        let minDimension = min(rect.width, rect.height)
        return Path(
            roundedRect: .init(x: rect.midX - minDimension / 2, y: rect.midY - minDimension / 2, width: minDimension, height: minDimension),
            cornerRadius: cornerRadius
        )
    }

    func inset(by amount: CGFloat) -> Square {
        Square(inset: inset + amount)
    }

    var perceptualUnitRect: CGRect {
        // The width of the unit rectangle (square). Adjust this to
        // size the diamond symbol so it perceptually matches with
        // the circle.
        let scaleAdjustment: CGFloat = 0.75
        return CGRect(x: 0.5 - scaleAdjustment / 2, y: 0.5 - scaleAdjustment / 2, width: scaleAdjustment, height: scaleAdjustment)
    }
}

#Preview {
    ExpensesLineChartView(expensesViewModel: .preview)
        .padding()
}
