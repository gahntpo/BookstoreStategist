//
//  SalesListView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 16.07.23.
//

import SwiftUI
import Charts

struct DetailBookSalesView: View {
    
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        var id: Self { self }
    }
    @ObservedObject var salesViewModel: SalesViewModel = .preview
    @State private var selectedTimeInterval = TimeInterval.day
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selectedTimeInterval.animation()) {
                ForEach(TimeInterval.allCases) { interval in
                    Text(interval.rawValue)
                }
            } label: {
                Text("Time interval")
            }
            .pickerStyle(.segmented)
            
            Group {
                Text("You sold ") +
                Text("\(salesViewModel.totalSales) books").bold().foregroundStyle(Color.accentColor) +
                Text(" in the last 90 days.")
            }.padding(.vertical)
            
            Group {
                switch selectedTimeInterval {
                    case .day:
                        DailySalesChartView(salesData: salesViewModel.salesData)
                    case .week:
                        WeeklySalesChartView(salesViewModel: salesViewModel)
                    case .month:
                        MonthlySalesChartView(salesViewModel: salesViewModel)
                }
            }
            .aspectRatio(0.8, contentMode: .fit)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DetailBookSalesView(salesViewModel: .preview)
}
