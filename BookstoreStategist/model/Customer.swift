//
//  Customer.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 16.07.23.
//

import Foundation

struct Customer: Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let favoriteGenre: String
    
    static var example = Customer(id: UUID(),
                                  name: "Customer 1",
                                  age: 30,
                                  favoriteGenre: "Fiction")
    static var examples = [
        Customer(id: UUID(), name: "Customer 1", age: 30, favoriteGenre: "Fiction"),
        Customer(id: UUID(), name: "Customer 2", age: 25, favoriteGenre: "Non-fiction"),
        Customer(id: UUID(), name: "Customer 3", age: 35, favoriteGenre: "Fiction"),
        Customer(id: UUID(), name: "Customer 4", age: 28, favoriteGenre: "Fiction"),
        Customer(id: UUID(), name: "Customer 5", age: 32, favoriteGenre: "Non-fiction"),
        Customer(id: UUID(), name: "Customer 6", age: 29, favoriteGenre: "Fiction"),
        Customer(id: UUID(), name: "Customer 7", age: 31, favoriteGenre: "Non-fiction"),
        Customer(id: UUID(), name: "Customer 8", age: 33, favoriteGenre: "Fiction"),
        Customer(id: UUID(), name: "Customer 9", age: 27, favoriteGenre: "Non-fiction"),
        Customer(id: UUID(), name: "Customer 10", age: 36, favoriteGenre: "Fiction")
    ]
}
