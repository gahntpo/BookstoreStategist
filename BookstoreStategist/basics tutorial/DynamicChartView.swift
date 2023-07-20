//
//  DynamicChartView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 20.07.23.
//

import SwiftUI
import Charts

struct ChartData: Identifiable, Equatable {
    let type: String
    let count: Int
    
    var id: String { return type }
}

struct DynamicChartView: View {
    
    let data = [ChartData(type: "bird", count: 1),
                ChartData(type: "dog", count: 2),
                ChartData(type: "cat", count: 3)]
    
    var maxChartData: ChartData? {
        data.max { $0.count < $1.count }
    }
    
    var body: some View {
        Chart {
            ForEach(data) { dataPoint in
                
                BarMark(x: .value("Type", dataPoint.type),
                        y: .value("Population", dataPoint.count))
                .opacity(maxChartData == dataPoint ? 1 : 0.5)
                .foregroundStyle(maxChartData == dataPoint ? Color.accentColor : Color.gray)
            }
            
            RuleMark(y: .value("Average", 1.5))
                .foregroundStyle(.gray)
                .annotation(position: .bottom,
                            alignment: .bottomLeading) {
                    Text("average 1.5")
                }
            
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
  
    }
}

#Preview {
    DynamicChartView()
}
