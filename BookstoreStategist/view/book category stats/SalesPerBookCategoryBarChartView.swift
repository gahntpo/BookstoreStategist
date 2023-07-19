//
//  SalesPerBookCategoryBarChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 17.07.23.
//

import SwiftUI
import Charts

struct SalesPerBookCategoryBarChartView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        Chart(salesViewModel.totalSalesPerCategory, id: \.category) { data in
            BarMark(x: .value("sales", data.sales),
                    y: .value("Category", data.category.displayName))
            
            .annotation(position: .trailing, alignment: .leading, content: {
                Text(String(data.sales))
                    .opacity(data.category == salesViewModel.bestSellingCategory?.category ? 1 : 0.3)
            })
            
            .foregroundStyle(by: .value("Name", data.category.displayName))
            .opacity(data.category == salesViewModel.bestSellingCategory?.category ? 1 : 0.3)
        }
        .chartLegend(.hidden)
        .frame(maxHeight: 400)
    }
}

#Preview {
    SalesPerBookCategoryBarChartView(salesViewModel: .preview)
    //    .frame(width: 300, height: 300)
        .padding()
}
