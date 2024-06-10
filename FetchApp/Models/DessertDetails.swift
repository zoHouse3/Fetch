//
//  DessertDetails.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/9/24.
//

import Foundation

struct DessertDetailsResponse: Decodable {
    let meals: [DessertDetails]
    
    var dessertDetails: DessertDetails {
        // the meals array should only contain one element which is the details for current dessert
        return meals.first!
    }
}
struct DessertDetails: Decodable, Identifiable {
    let id: String
    let name: String
    let thumbnailUrlString: String
    let instructions: String
    let ingredient1, ingredient2, ingredient3, ingredient4, ingredient5, ingredient6, ingredient7, ingredient8, ingredient9, ingredient10, ingredient11, ingredient12, ingredient13, ingredient14, ingredient15, ingredient16, ingredient17, ingredient18, ingredient19, ingredient20: String
    let measurement1, measurement2, measurement3, measurement4, measurement5, measurement6, measurement7, measurement8, measurement9, measurement10, measurement11, measurement12, measurement13, measurement14, measurement15, measurement16, measurement17, measurement18, measurement19, measurement20: String
}

// MARK: Computed Properties
extension DessertDetails {
    var thumbnailURL: URL? {
        return URL(string: thumbnailUrlString)
    }
    
    // map each ingredient to its measurement
    var measurementsForIngredient: [String:String] {
        let ingredients = [ingredient1, ingredient2, ingredient3, ingredient4, ingredient5, ingredient6, ingredient7, ingredient8, ingredient9, ingredient10, ingredient11, ingredient12, ingredient13, ingredient14, ingredient15, ingredient16, ingredient17, ingredient18, ingredient19, ingredient20]
            .filter { (!$0.trimmingCharacters(in: .whitespaces).isEmpty) }
            .uniqued()
        
        let measurements = [measurement1, measurement2, measurement3, measurement4, measurement5, measurement6, measurement7, measurement8, measurement9, measurement10, measurement11, measurement12, measurement13, measurement14, measurement15, measurement16, measurement17, measurement18, measurement19, measurement20]
            .filter { (!$0.trimmingCharacters(in: .whitespaces).isEmpty) }
        
        return Dictionary(uniqueKeysWithValues: zip(ingredients, measurements))
    }
}

// MARK: Coding Keys
extension DessertDetails {
    enum CodingKeys: String, CodingKey  {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailUrlString = "strMealThumb"
        case instructions = "strInstructions"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measurement1 = "strMeasure1"
        case measurement2 = "strMeasure2"
        case measurement3 = "strMeasure3"
        case measurement4 = "strMeasure4"
        case measurement5 = "strMeasure5"
        case measurement6 = "strMeasure6"
        case measurement7 = "strMeasure7"
        case measurement8 = "strMeasure8"
        case measurement9 = "strMeasure9"
        case measurement10 = "strMeasure10"
        case measurement11 = "strMeasure11"
        case measurement12 = "strMeasure12"
        case measurement13 = "strMeasure13"
        case measurement14 = "strMeasure14"
        case measurement15 = "strMeasure15"
        case measurement16 = "strMeasure16"
        case measurement17 = "strMeasure17"
        case measurement18 = "strMeasure18"
        case measurement19 = "strMeasure19"
        case measurement20 = "strMeasure20"
    }
}
