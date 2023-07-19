//
//  Sales.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 16.07.23.
//

import Foundation

struct Sale: Identifiable, Equatable {
    let id: UUID
    let book: Book
    let quantity: Int
    let saleDate: Date
    
    static var example = Sale(id: UUID(),
                                  book: Book.examples[0],
                                  quantity: 5,
                                  saleDate: Date(timeIntervalSinceNow: -7_200_000))
    
    static var examples = [
        Sale(id: UUID(), book: Book.examples[0], quantity: 5, saleDate: Date(timeIntervalSinceNow: -7_200_000)),
        Sale(id: UUID(), book: Book.examples[1], quantity: 3, saleDate: Date(timeIntervalSinceNow: -14_400_000)),
        Sale(id: UUID(), book: Book.examples[2], quantity: 6, saleDate: Date(timeIntervalSinceNow: -21_600_000)),
        Sale(id: UUID(), book: Book.examples[3], quantity: 4, saleDate: Date(timeIntervalSinceNow: -28_800_000)),
        Sale(id: UUID(), book: Book.examples[4], quantity: 2, saleDate: Date(timeIntervalSinceNow: -36_000_000)),
        Sale(id: UUID(), book: Book.examples[5], quantity: 3, saleDate: Date(timeIntervalSinceNow: -43_200_000)),
        Sale(id: UUID(), book: Book.examples[6], quantity: 5, saleDate: Date(timeIntervalSinceNow: -50_400_000)),
        Sale(id: UUID(), book: Book.examples[7], quantity: 6, saleDate: Date(timeIntervalSinceNow: -57_600_000)),
        Sale(id: UUID(), book: Book.examples[8], quantity: 3, saleDate: Date(timeIntervalSinceNow: -64_800_000)),
        Sale(id: UUID(), book: Book.examples[9], quantity: 4, saleDate: Date(timeIntervalSinceNow: -72_000_000))
    ]
    
    static func threeMonthsExamples() -> [Sale]  {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!

        let exampleSales: [Sale] = (1...300).map { _ in
            let randomBook = Book.examples.randomElement()!
            let randomQuantity = Int.random(in: 1...5)
            let randomDate = Date.random(in: threeMonthsAgo...Date())

            return Sale(id: UUID(), book: randomBook, quantity: randomQuantity, saleDate: randomDate)
        }
        
        return exampleSales.sorted { $0.saleDate < $1.saleDate }
    }
    
    static var higherWeekendThreeMonthsExamples: [Sale] = {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!

        let exampleSales: [Sale] = (1...300).map { _ in
            let randomBook = Book.examples.randomElement()!
            let randomDate = Date.random(in: threeMonthsAgo...Date())
            
            let weekday = Calendar.current.component(.weekday, from: randomDate)
         //   let randomQuantity = Int.random(in: 1...((weekday == 7 || weekday == 1) ? 100 : 50))
            // Apply Central Limit Theorem to approximate Gaussian distribution
            var average: Int = 35
            switch weekday {
                case 1: average = 29
                case 2: average = 21
                case 3: average = 38
                case 4: average = 25
                case 5: average = 30
                case 6: average = 50
                case 7: average = 60
                default:
                    average = 10
            }
            
            let randomQuantity = (1...20).reduce(0) { acc, _ in acc + Int.random(in: 1...(average * 2)) } / 12

            
            return Sale(id: UUID(), book: randomBook, quantity: randomQuantity, saleDate: randomDate)
        }

        return exampleSales.sorted { $0.saleDate < $1.saleDate }
    }()
    
}

extension Date {
    static func random(in range: ClosedRange<Date>) -> Date {
        let diff = range.upperBound.timeIntervalSinceReferenceDate - range.lowerBound.timeIntervalSinceReferenceDate
        let randomValue = diff * Double.random(in: 0...1) + range.lowerBound.timeIntervalSinceReferenceDate
        return Date(timeIntervalSinceReferenceDate: randomValue)
    }
}
