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
            
            Text("You sold ") +
            Text("\(salesViewModel.totalSales) books").bold().foregroundStyle(Color.accentColor) +
            Text(" in the last 90 days.")
              
            
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
}

#Preview {
    SimpleBookSalesView(salesViewModel: .preview)
        .padding()
}
