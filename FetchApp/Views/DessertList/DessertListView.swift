//
//  ContentView.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/9/24.
//

import SwiftUI
import Combine

struct DessertListView: View {
    @StateObject var viewModel = DessertListViewModel()
    
    var body: some View {
        List(viewModel.allDesserts) { dessert in
            VStack {
                NavigationLink("\(dessert.name): \(dessert.id)") {
                    DessertDetailsView(dessertID: dessert.id)
                }
            }
        }
        .navigationTitle("Desserts 🍰")
        .onFirstAppear {
            viewModel.getAllDesserts()
        }
    }
    
}

#Preview {
    DessertListView()
}
