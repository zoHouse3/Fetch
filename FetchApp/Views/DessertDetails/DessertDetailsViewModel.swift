//
//  DessertDetailsViewModel.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/9/24.
//

import Foundation
import Combine

class DessertDetailsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    
    var dessertDetails: DessertDetails? 
    var cancellables = Set<AnyCancellable>()
    
    // Services
    var networkManager = NetworkManager.shared
    
    func getDessertDetails(using id: String) {
        isLoading = true
        
        networkManager.fetchDessertDetails(using: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: (print("finished fetching details"))
                case.failure(let error): (print("error fetching details: \(error.localizedDescription)"))
                }
                self?.isLoading = false
            } receiveValue: { [weak self] response in
                self?.dessertDetails = response.dessertDetails
            }
            .store(in: &cancellables)

    }
}
