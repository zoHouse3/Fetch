//
//  DessertsResponse.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/9/24.
//

import Foundation

struct DessertsResponse: Decodable {
    let desserts: [Dessert]
    
    enum CodingKeys: String, CodingKey {
        case desserts = "meals"
    }
}

struct Dessert: Decodable, Identifiable {
    let id: String
    let name: String
    let thumbnailUrlString: String
    
    enum CodingKeys: String, CodingKey  {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailUrlString = "strMealThumb"
    }
}
