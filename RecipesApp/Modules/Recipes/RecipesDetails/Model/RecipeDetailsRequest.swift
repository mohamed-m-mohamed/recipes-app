//
//  RecipeDetailsRequest.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import Foundation

// Model for recipe details request using recipe id
struct RecipeDetailsRequest: Codable {
    let id: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "i"
    }
}
