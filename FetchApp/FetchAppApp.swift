//
//  FetchAppApp.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/9/24.
//

import SwiftUI

@main
struct FetchAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                DessertListView()
            }
        }
    }
}
