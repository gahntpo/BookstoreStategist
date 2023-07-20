//
//  BookstoreStategistApp.swift
//  BookstoreStategist
//
//  Created by Karin Prater on 16.07.23.
//

import SwiftUI

@main
struct BookstoreStategistApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            ContentView()
            #else
            MacContentView()
            #endif
        }
    }
}
