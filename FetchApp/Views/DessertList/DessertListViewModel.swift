//
//  DessertListViewModel.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/9/24.
//

import Foundation
import Combine

class DessertListViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    var cancellables: Set<AnyCancellable> = []
    
    var allDesserts: [Dessert] = []
    var filteredDesserts: [Dessert] {
        guard !searchText.isEmpty else { return allDesserts }
        return allDesserts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func getAllDesserts() {
        isLoading = true
        NetworkManager.shared.fetchAllDesserts()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("successful fetch")
                case .failure(let error):
                    print("error fetching: \(error)")
                }
                self?.isLoading = false
            } receiveValue: { [weak self] response in
                self?.allDesserts = response.desserts
            }
            .store(in: &cancellables)
    }
}

