//
//  MonthlySalesChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 18.07.23.
//

import SwiftUI
import Charts

struct MonthlySalesChartView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        Chart(salesViewModel.salesByMonth, id: \.day) {
            BarMark(
                x: .value("Month", $0.day, unit: .month),
                y: .value("Sales", $0.sales)
            )
            .foregroundStyle(.blue.gradient)
        }
    }
}

#Preview {
    MonthlySalesChartView(salesViewModel: .preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
