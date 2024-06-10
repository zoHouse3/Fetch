//
//  NetworkManager.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/9/24.
//

import Foundation
import Combine

// Global Decoder Object
let GlobalJsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func fetchAllDesserts() -> some Publisher<DessertsResponse, Error> {
        guard let request = try? createNetworkRequest(route: .allDesserts, httpMethod: .get) else {
            return Fail(error: NetworkError.invalidUrlRequest).eraseToAnyPublisher()
        }
       
        return performNetworkRequest(request: request).eraseToAnyPublisher()
    }
    
    func fetchDessertDetails(using dessertID: String) -> some Publisher<DessertDetailsResponse, Error> {
        guard let request = try? createNetworkRequest(route: .detailsForDessert(dessertID), httpMethod: .get) else {
            return Fail(error: NetworkError.invalidUrlRequest).eraseToAnyPublisher()
        }
        
        return performNetworkRequest(request: request).eraseToAnyPublisher()
    }
    
    private func createNetworkRequest(route: Router,
                              httpMethod: HttpMethod) throws -> URLRequest {
        
        // Establish URL
        let urlString = Router.baseUrl + route.pathDescription
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidUrl
        }
        
        // init url request, using url
        var urlRequest = URLRequest(url: url)
        
        // add http method
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        // add query parameters (if applicable)
        if let queryParameters = route.queryParameters {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryParameters.map {
                return URLQueryItem(name: $0.key, value: "\($0.value)")
            }
            urlRequest.url = components?.url
        }
        
        // // add http body data (if applicable)
        if let httpBody = route.httpBody {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: httpBody)
        }
        
        return urlRequest
    }
    
    private func performNetworkRequest<T: Decodable>(request: URLRequest) -> some Publisher<T, Error> {
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: GlobalJsonDecoder)
    }
    
}
