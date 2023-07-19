//
//  BookCategory.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 16.07.23.
//

import Foundation


enum BookCategory: String, Identifiable, CaseIterable {
    case fiction
    case biography
    case children
    case computerScience
    case fantasy
    case business
  
    
    var id: Self { return self }
    
    var displayName: String {
        switch self {
            case .fiction:
                "Fiction"
            case .biography:
                "Biography"
            case .children:
                "Children Books"
            case .computerScience:
                "Computer Science"
            case .fantasy:
                "Fantasy"
            case .business:
                "Business"
        }
    }
}
