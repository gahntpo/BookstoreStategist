//
//  SimpleSalesPerBookPieChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 17.07.23.
//

import SwiftUI
import Charts

struct SimpleSalesPerBookCategoryPieChartView: View {
    @ObservedObject var salesViewModel: SalesViewModel
  
    var body: some View {
        
        HStack {
            
            if let bestSellingCategory = salesViewModel.bestSellingCategory {
                Text("Your best selling category is ") + Text("\(bestSellingCategory.category.displayName)").bold().foregroundStyle(.blue) +
                Text(" with ") +
                Text("\(bestSellingCategory.sales) sales ").bold() +
                Text("in the last 90 days.")
                   
            }
            
            Chart(salesViewModel.totalSalesPerCategory, id: \.category) { data in
                SectorMark(
                    angle: .value("Sales", data.sales),
                    innerRadius: .ratio(0.618),
                    angularInset: 1.5
                )
                .cornerRadius(5.0)
                .opacity(data.category == salesViewModel.bestSellingCategory?.category ? 1 : 0.3)
            }
            .chartLegend(alignment: .center, spacing: 18)
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 75)
        }
    }
}

#Preview {
    SimpleSalesPerBookCategoryPieChartView(salesViewModel: .preview)
        .padding()
}
