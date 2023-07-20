//
//  RectangleChartExampleView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 20.07.23.
//

import SwiftUI
import Charts

struct RectangleChartExampleView: View {
    let catData = PetData.catExample
  
    var body: some View {
        Chart {
            ForEach(catData) { dataPoint in
                RectangleMark(x: .value("Year", dataPoint.year),
                              y: .value("Population", dataPoint.population),
                              width: .fixed(30),
                              height: .fixed(2))
            }
        }
        .chartXScale(domain: 1998...2025)
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

#Preview {
    RectangleChartExampleView()
}
