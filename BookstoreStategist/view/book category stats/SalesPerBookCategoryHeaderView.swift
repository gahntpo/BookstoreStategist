//
//  SalesPerBookCategoryHeaderView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 19.07.23.
//

import SwiftUI

struct SalesPerBookCategoryHeaderView: View {
    
     let selectedChartStyle: SalesPerBookCategoryView.ChartStyle
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        switch selectedChartStyle {
            case .pie, .singleBar:
                if let bestSellingCategory = salesViewModel.bestSellingCategory,
                   let bestsellingCategoryPercentage  {
                    Text("Your best selling category is ") + Text("\(bestSellingCategory.category.displayName)").bold().foregroundColor(.blue) +
                    Text(" with ") +
                    Text("\(bestsellingCategoryPercentage)").bold() +
                    Text(" of all sales.")
                    
                }
                
            case .bar:
                if let bestSellingCategory = salesViewModel.bestSellingCategory {
                    Text("Your best selling category is ") + Text("\(bestSellingCategory.category.displayName)").bold().foregroundColor(.blue) +
                    Text(" with ") +
                    Text("\(bestSellingCategory.sales) sales ").bold() +
                    Text("in the last 90 days.")
                }
        }
    }
    
    var bestsellingCategoryPercentage: String? {
       guard let bestSellingCategory = salesViewModel.bestSellingCategory else { return nil }
       
        let percentage = Double(bestSellingCategory.sales) / Double(salesViewModel.totalSales)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        return formattedPercentage
    }
}

#Preview {
    let vm = SalesViewModel.preview
    return VStack {
        SalesPerBookCategoryHeaderView(selectedChartStyle: .bar, salesViewModel: vm)
        SalesPerBookCategoryHeaderView(selectedChartStyle: .singleBar, salesViewModel: vm)
    }
}
