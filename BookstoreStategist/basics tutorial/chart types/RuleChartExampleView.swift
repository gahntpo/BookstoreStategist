//
//  RuleChartExampleView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 20.07.23.
//

import SwiftUI
import Charts

struct RuleChartExampleView: View {
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

                .foregroundStyle(Color.gray.opacity(0.5))
            }
            
            RuleMark(y: .value("Average", 1.5))
                .annotation(position: .bottom,
                            alignment: .bottomLeading) {
                    Text("average 1.5")
                        .foregroundColor(.accentColor)
                }
            
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
  
    }
}

#Preview {
    RuleChartExampleView()
}
