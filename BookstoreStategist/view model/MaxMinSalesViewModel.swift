//
//  MaxMinSalesViewModel.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 17.07.23.
//

import Foundation

struct SalesByWeekDay: Identifiable {
    let dayNumber: Int
    let minSales: Int
    let maxSales: Int
    let averageSales: Double
    var id: Int { return dayNumber }
}

class MaxMinSalesViewModel: ObservableObject {
    
    @Published var salesData = [Sale]()
    
    var salesByWeekday: [(number: Int, sales: [Sale])] {
        let salesByWeekday = salesGroupedByWeekday(sales: salesData).map {
            (number: $0.key, sales: $0.value)
        }
        
        return salesByWeekday.sorted { $0.number < $1.number }
    }
    
    func salesGroupedByWeekday(sales: [Sale]) -> [Int: [Sale]] {
        var salesByWeekday: [Int: [Sale]] = [:]

        let calendar = Calendar.current
        for sale in sales {
            let weekday = calendar.component(.weekday, from: sale.saleDate)
            if salesByWeekday[weekday] != nil {
                salesByWeekday[weekday]!.append(sale)
            } else {
                salesByWeekday[weekday] = [sale]
            }
        }

        return salesByWeekday
    }
    
    static var preview: SalesViewModel {
        let vm = SalesViewModel()
       // vm.salesData = Sale.threeMonthsExamples
        vm.salesData = Sale.higherWeekendThreeMonthsExamples
        vm.books = Book.examples
        return vm
    }
}
