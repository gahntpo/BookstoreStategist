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

struct HeatData: Identifiable {
    let locationX: Int
    let locationY: Int
    let temperatur: Double
    let id = UUID()
    
    static var exampleData: [HeatData] {
        [HeatData(locationX: 50, locationY: 50, temperatur: 23.0),
         HeatData(locationX: 50, locationY: 100, temperatur: 15.0),
         HeatData(locationX: 50, locationY: 150, temperatur: 25.0),
         HeatData(locationX: 50, locationY: 200, temperatur: 22.5),
         
         HeatData(locationX: 100, locationY: 50, temperatur: 20.0),
         HeatData(locationX: 100, locationY: 100, temperatur: 26.5),
         HeatData(locationX: 100, locationY: 150, temperatur: 29.4),
         HeatData(locationX: 100, locationY: 200, temperatur: 17.0),
         
         HeatData(locationX: 150, locationY: 50, temperatur: 24.0),
         HeatData(locationX: 150, locationY: 100, temperatur: 23.5),
         HeatData(locationX: 150, locationY: 150, temperatur: 21.5),
         HeatData(locationX: 150, locationY: 200, temperatur: 15.0),
         
         HeatData(locationX: 200, locationY: 50, temperatur: 10.0),
         HeatData(locationX: 200, locationY: 100, temperatur: 26.5),
         HeatData(locationX: 200, locationY: 150, temperatur: 27.0),
         HeatData(locationX: 200, locationY: 200, temperatur: 17.0)
        ]
    }
}

struct HeatMapExampleView: View {
    let heatData: [HeatData] = HeatData.exampleData
  
    var body: some View {
        Chart(heatData) {
            RectangleMark(xStart: .value("start location x", $0.locationX - 25),
                          xEnd: .value("end location x", $0.locationX + 25),
                          yStart: .value("start location y", $0.locationY - 25),
                          yEnd: .value("end location y", $0.locationY + 25))
            .foregroundStyle(by: .value("Number", $0.temperatur))
        }
        .chartXScale(domain: 25...225)
        .chartYScale(domain: 25...225)
        .aspectRatio(1, contentMode: .fit)
     
        .padding()
    }
}

#Preview {
    RectangleChartExampleView()
}

#Preview("Heatmap") {
    HeatMapExampleView()
}
