//
//  SalesByWeekdayBarChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 17.07.23.
//

import SwiftUI
import Charts

struct SalesByWeekdayBarChartView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var medianSalesIsShown: Bool = true
    var body: some View {
        Chart {
           
            
            if medianSalesIsShown {
                let median = salesViewModel.medianSales
                RuleMark(
                    y: .value("Median", median)
                )
                .foregroundStyle(Color.blue)
                .lineStyle(StrokeStyle(lineWidth: 3))
                .annotation(position: .top, alignment: .trailing) {
                    Text("Median: \(String(format: "%.2f", median))")
                        .font(.body.bold())
                        .foregroundStyle(.blue)
                        //.background(Color(.systemBackground))
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    SalesByWeekdayBarChartView(salesViewModel: .preview)
}
