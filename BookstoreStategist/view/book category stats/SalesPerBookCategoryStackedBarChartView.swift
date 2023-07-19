//
//  SalesPerBookCategoryStackedBarChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 18.07.23.
//

import SwiftUI
import Charts

struct CategorySalesData: Identifiable {
    let category: BookCategory
    let sales: Int
    let startSales: Int
    let endSales: Int
    
    let id = UUID()
}

struct SalesPerBookCategoryStackedBarChartView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    
    var salesData: [CategorySalesData] {
        var result = [CategorySalesData]()
        var initialSales = 0
        
        for salesData in salesViewModel.totalSalesPerCategory {
            result.append(CategorySalesData(category: salesData.category,
                                            sales: salesData.sales,
                                            startSales: initialSales,
                                            endSales: salesData.sales + initialSales))
            initialSales += salesData.sales
        }
        
        return result
    }
    
    var body: some View {
        
        Chart(salesData) { data in
            
            BarMark(xStart: .value("begin", data.startSales),
                    xEnd: .value("end", data.endSales),
                    y:  .value("Category", 0), height: 70)
            
            .foregroundStyle(by: .value("Category", data.category.displayName))
            .opacity(data.category == salesViewModel.bestSellingCategory?.category ? 1 : 0.3)
            .annotation(position: .overlay) {
                if data.category == salesViewModel.bestSellingCategory?.category {
                    Text(data.category.displayName)
                    // Text("\(data.sales) sales")
                        .foregroundStyle(Color.white)
                        .bold()
                }
            }
            
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartLegend(.hidden)
        
        .fixedSize(horizontal: false, vertical: true)
        /*
         ForEach(salesData) { datum in
         HStack {
         Text(datum.category.displayName)
         Text("\(datum.sales)")
         Spacer()
         Text("\(datum.startSales)")
         Text("\(datum.endSales)")
         }
         }
         */
        
    }
    
}

#Preview {
    SalesPerBookCategoryStackedBarChartView(salesViewModel: .preview)
        .padding()
}
