//
//  SimpleSalesByWeekdayView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 17.07.23.
//

import SwiftUI
import Charts

struct SimpleSalesByWeekdayView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let highestSellingWeekday = salesViewModel.highestSellingWeekday {
                Text("Your highest selling day of the week is ") +
                Text("\(longWeekday(for: highestSellingWeekday.number))").bold().foregroundColor(.blue) +
                     Text(" with an average of ") +
                Text("\(Int(highestSellingWeekday.sales)) sales per day.").bold()
            }
            
            Chart(salesViewModel.averageSalesByWeekday, id: \.number) {
                    BarMark(x: .value("Day", weekday(for: $0.number)),
                            y: .value("Sales", $0.sales))
                
                    .opacity($0.number == salesViewModel.highestSellingWeekday?.number ? 1 : 0.3)
                
                
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(height: 50)
            
        }
       
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
    SimpleSalesByWeekdayView(salesViewModel: .preview)
        .padding()
}
