//
//  SalesByWeekdayView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 17.07.23.
//

import SwiftUI
import Charts

struct SalesByWeekdayView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let highestSellingWeekday = salesViewModel.highestSellingWeekday {
                Text("Your highest selling day of the week is \(longWeekday(for: highestSellingWeekday)).")
            }
            
            Chart {
                ForEach(salesViewModel.averageSalesByWeekday, id: \.number) {
                    BarMark(x: .value("Day", weekday(for: $0.number)),
                            y: .value("Sales", $0.sales))
                    .foregroundStyle(.gray.opacity(0.3))
                    
                    RectangleMark(x: .value("Day", weekday(for: $0.number)),
                                  y: .value("Sales", $0.sales),
                                  height: 2)
                    .foregroundStyle(.gray)
                }
                
                ForEach(salesViewModel.salesByWeekday, id: \.number) { weekdayData in
                    ForEach(weekdayData.sales) { saleData in
                        PointMark(x: .value("day", weekday(for:weekdayData.number)),
                                  y: .value("sales", saleData.quantity))
                        .foregroundStyle(.indigo.opacity(0.25))
                    }
                }
            }
            .aspectRatio(1, contentMode: .fit)
         
        }
        .padding()
    }
    
    let formatter = DateFormatter()
    
    func weekday(for number: Int) -> String {
        formatter.shortWeekdaySymbols[number - 1]
    }
    
    func longWeekday(for number: Int) -> String {
        formatter.weekdaySymbols[number - 1]
    }
}

#Preview {
    SalesByWeekdayView(salesViewModel: .preview)
}
