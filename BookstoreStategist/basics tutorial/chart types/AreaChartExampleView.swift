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
            .symbol(by: .value("Pet type", dataSeries.type))
        }
        .chartXScale(domain: 1998...2024)
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

#Preview {
    AreaChartExampleView()
}