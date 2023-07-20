//
//  WeeklySalesChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 18.07.23.
//

import SwiftUI
import Charts

@available(macOS 14.0, iOS 17, *)
struct WeeklySalesChartView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var rawSelectedDate: Date? = nil
    
    @Environment(\.calendar) var calendar

    var selectedDateValue: (day: Date, sales: Int)? {
        if let rawSelectedDate {
            
            return salesViewModel.salesByWeek.first(where: {
                let startOfWeek = $0.day
                let endOfWeek = endOfWeek(for: startOfWeek) ?? Date()
                return (startOfWeek ... endOfWeek).contains(rawSelectedDate)
            })
        }
        
        return nil
    }
    
    
    var body: some View {
        Chart(salesViewModel.salesByWeek, id: \.day) {
            BarMark(
                x: .value("Week", $0.day, unit: .weekOfYear),
                y: .value("Sales", $0.sales)
            )
            .opacity(selectedDateValue == nil || $0.day == selectedDateValue?.day ? 1 : 0.5)
            
            
            if let rawSelectedDate {
                RuleMark(x: .value("Selected",
                                   rawSelectedDate,
                                   unit: .day))
                .foregroundStyle(Color.gray.opacity(0.3))
                .offset(yStart: -10)
                .zIndex(-1)
                .annotation(
                    position: .top,
                    spacing: 0,
                    overflowResolution: .init(
                        x: .fit(to: .chart),
                        y: .disabled
                    )
                ) {
                    selectionPopover
                }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
        
        //Mention: instead of annotion show details text below charts
        //Mention: hide header when annotation is shown
    }
    
    func endOfWeek(for startOfWeek: Date) -> Date? {
         calendar.date(byAdding: .day, value: 6, to: startOfWeek)
    }
    
    func beginingOfWeek(for date: Date) -> Date? {
        calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
    }
    
    @ViewBuilder
    var selectionPopover: some View {
        if let rawSelectedDate,
            let selectedDateValue {
            VStack {
               // Text(rawSelectedDate.formatted(.dateTime.month().day()))
                
                Text(selectedDateValue.day.formatted(.dateTime.month().day()))
                Text("\(selectedDateValue.sales) sales")
                    .bold()
                    .foregroundStyle(.blue)
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(color: .blue, radius: 2)
            }
        }
    }
}

@available(macOS 14.0, iOS 17, *)
#Preview {
    WeeklySalesChartView(salesViewModel: .preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
