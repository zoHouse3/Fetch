//
//  Router.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/9/24.
//

import Foundation
import Combine

// https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
enum Router {
    static let baseUrl = "https://themealdb.com/api/json/v1/1"
    
    case allDesserts
    case detailsForDessert(String)
    
    var pathDescription: String {
        switch self {
        case .allDesserts:
            return "/filter.php"
        case .detailsForDessert(_):
            return "/lookup.php"
        }
    }
    
    var queryParameters: [String:Any]? {
        switch self {
        case .allDesserts:
            return ["c":"Dessert"]
        case .detailsForDessert(let id):
            return ["i":"\(id)"]
        }
    }
    
    var httpBody: [String:Any]? {
        switch self {
        case .allDesserts, .detailsForDessert(_):
            return nil
        }
    }
    
    var responseType: Decodable.Type {
        switch self {
        case .allDesserts, .detailsForDessert:
            return [Dessert].self
        }
    }
    
}
