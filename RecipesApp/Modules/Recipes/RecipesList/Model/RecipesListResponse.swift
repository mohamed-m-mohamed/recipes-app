//
//  RecipesListResponse.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import Foundation

// Model for recipes list response
struct RecipesListResponse: Codable {
    let recipes: [Recipe]?
    
    private enum CodingKeys: String, CodingKey {
        case recipes = "meals"
    }
}

struct Recipe: Codable {
    let title: String
    let thumbnailUrl: String
    let id: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "strMeal"
        case thumbnailUrl = "strMealThumb"
        case id = "idMeal"
    }
}
