//
//  AreaChartExampleView.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 20.07.23.
//

import SwiftUI
import Charts

struct AreaChartExampleView: View {
    let catData = PetData.catExample
    let dogData = PetData.dogExamples
    
    var data: [(type: String, petData: [PetData])] {
        [(type: "cat", petData: catData),
         (type: "dog", petData: dogData)]
    }
    
    var body: some View {
        Chart(data, id: \.type) { dataSeries in
            ForEach(dataSeries.petData) { data in
                AreaMark(x: .value("Year", data.year),
                         y: .value("Population", data.population))
            }
            .foregroundStyle(by: .value("Pet type", dataSeries.type))
        }
        .chartXScale(domain: 1998...2024)
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

struct GradientAreaChartExampleView: View {
    let catData = PetData.catExample
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.4), Color.accentColor.opacity(0)]),
                                        startPoint: .top,
                                        endPoint: .bottom)
    var body: some View {
        Chart {
            ForEach(catData) { data in
                LineMark(x: .value("Year", data.year),
                         y: .value("Population", data.population))
            }
            .interpolationMethod(.cardinal)
            .symbol(by: .value("Pet type", "cat"))
            
            ForEach(catData) { data in
                AreaMark(x: .value("Year", data.year),
                         y: .value("Population", data.population))
            }
            .interpolationMethod(.cardinal)
            .foregroundStyle(linearGradient)
        }
        .chartXScale(domain: 1998...2024)
        .chartLegend(.hidden)
        .chartXAxis {
            AxisMarks(values: [2000, 2010, 2015, 2022]) { value in
                AxisGridLine()
                AxisTick()
                if let year = value.as(Int.self) {
                    AxisValueLabel(formatte(number: year),
                                   centered: false,
                                   anchor: .top)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
    
    let numberFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    func formatte(number: Int) -> String {
        let result = NSNumber(value: number)
        return numberFormatter.string(from: result) ?? ""
    }
}

#Preview {
    AreaChartExampleView()
        .frame(maxHeight: .infinity, alignment: .top)
}

#Preview("gradient area") {
    GradientAreaChartExampleView()
        .frame(maxHeight: .infinity, alignment: .top)
}
