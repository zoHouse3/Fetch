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
        List(viewModel.filteredDesserts) { dessert in
            VStack {
                NavigationLink("\(dessert.name)") {
                    DessertDetailsView(dessertID: dessert.id)
                }
            }
        }
        .navigationTitle("Desserts 🍰")
        .searchable(text: $viewModel.searchText, prompt: "search for your favorite desssert")
        .onFirstAppear {
            viewModel.getAllDesserts()
        }
    }
    
}

#Preview {
    DessertListView()
}
