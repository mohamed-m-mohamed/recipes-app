//
//  RecipeDetails.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import Foundation

// Data Model for Recipe Details
struct RecipeDetails {
    let title: String
    let imageUrl: String
    let instructions: String
    let ingredients: [Ingredient]
}

struct Ingredient {
    let name: String
    let imageUrl: String
    let measure: String
}
