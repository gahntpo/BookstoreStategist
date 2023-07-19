//
//  SalesByWeekdayLineChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 17.07.23.
//

import SwiftUI
import Charts

struct SalesByWeekdayLineChartView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        Chart {
            
            ForEach(salesViewModel.salesByWeekdayHistorgramData, id: \.number) { weekdayData in
                
               // if salesViewModel.highestSellingWeekday?.number == weekdayData.number {
                    Plot {
                        ForEach(weekdayData.histogram, id: \.bucket) { data in
                            LineMark(x: .value("bucket", data.bucket * 5),
                                     y: .value("count", data.count),
                                     series: .value("Weekday",  weekday(for: weekdayData.number)))
                        }
                    }
                    .foregroundStyle(by: .value("Name", weekday(for: weekdayData.number)))
                    
                    .interpolationMethod(.monotone)
              //  }
            }
            
        }
       .aspectRatio(1, contentMode: .fit)
       .padding()
    }
    
    
    let formatter = DateFormatter()
    
    func weekday(for number: Int) -> String {
        formatter.shortWeekdaySymbols[number - 1]
    }
}

#Preview {
    SalesByWeekdayLineChartView(salesViewModel: .preview)
}
