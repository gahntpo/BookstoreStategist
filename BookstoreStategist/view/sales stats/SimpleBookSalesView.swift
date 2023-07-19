//
//  SimpleSalesListView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 17.07.23.
//

import SwiftUI
import Charts

struct SimpleBookSalesView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    var body: some View {
        VStack(alignment: .leading) {
            
            /*
             Text("You sold ") +
             Text("\(salesViewModel.totalSales) books").bold().foregroundStyle(Color.accentColor) +
             Text(" in the last 90 days.")
             */
            
            
            if let changedBookSales = changedBookSales() {
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: isPositiveChange ? "arrow.up.right" : "arrow.down.right").bold()
                        .foregroundColor( isPositiveChange ? .green : .red)
                    
                    Text("You book sales ") +
                    Text(changedBookSales)
                        .bold() +
                    Text(" in the last 90 days.")
                }
            }
            
            
            Chart(salesViewModel.salesByWeek, id: \.day) {
                BarMark(
                    x: .value("Week", $0.day, unit: .weekOfYear),
                    y: .value("Sales", $0.sales)
                )
            }
            .frame(height: 70)
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
        }
    }
    
    func changedBookSales() -> String? {
        let percentage = percentage
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        let changedDescription = percentage < 0 ? "decreased by " : "increased by "
        
        return changedDescription + formattedPercentage
    }
    
    var percentage: Double {
        Double(salesViewModel.totalSales) / Double(salesViewModel.lastTotalSales) - 1
    }
    
    var isPositiveChange: Bool {
        percentage > 0
    }
    
    //
}

#Preview {
    
    let increasedVM = SalesViewModel.preview
    let decreasedVM = SalesViewModel.preview
    decreasedVM.lastTotalSales = 24500
    
    return VStack(spacing: 60) {
        SimpleBookSalesView(salesViewModel: increasedVM)
          
        
        SimpleBookSalesView(salesViewModel: decreasedVM)
    }
    .padding()
}
