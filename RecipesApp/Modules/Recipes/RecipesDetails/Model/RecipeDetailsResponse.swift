//
//  RecipeDetailsResponse.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import Foundation

// Model for recipe details response
struct RecipeDetailsResponse: Codable {
    let recipes: [RecipeDetailsMeal]
    
    private enum CodingKeys: String, CodingKey {
        case recipes = "meals"
    }
}

struct RecipeDetailsMeal: Codable {
    let title: String
    let instructions: String
    let imageUrl: String
    
    // Ingredients
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    let ingredient8: String?
    let ingredient9: String?
    let ingredient10: String?
    let ingredient11: String?
    let ingredient12: String?
    let ingredient13: String?
    let ingredient14: String?
    let ingredient15: String?
    let ingredient16: String?
    let ingredient17: String?
    let ingredient18: String?
    let ingredient19: String?
    let ingredient20: String?
    
    // Measurements
    let measurement1: String?
    let measurement2: String?
    let measurement3: String?
    let measurement4: String?
    let measurement5: String?
    let measurement6: String?
    let measurement7: String?
    let measurement8: String?
    let measurement9: String?
    let measurement10: String?
    let measurement11: String?
    let measurement12: String?
    let measurement13: String?
    let measurement14: String?
    let measurement15: String?
    let measurement16: String?
    let measurement17: String?
    let measurement18: String?
    let measurement19: String?
    let measurement20: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "strMeal"
        case imageUrl = "strMealThumb"
        case instructions = "strInstructions"
        
        // Ingredients
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
        
        // Measurements
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

extension RecipeDetailsMeal {
    
    // Transform API response to RecipeDetail model for cleaner and easier use
    func transform() -> RecipeDetails {
        // Get non empty pairs of ingredients and their corresponding measurement
        let nonEmptyIngredientList = nonEmptyIngredientsAndMeasurements()
        
        // Create array of ingredient models for each pair
        let ingredients = nonEmptyIngredientList.compactMap { (ingredient, measure) in
            // Image url for each ingredient
            let imageUrl = "https://www.themealdb.com/images/ingredients/\(ingredient)-Small.png"
         
            return Ingredient(name: ingredient, imageUrl: imageUrl, measure: measure)
        }
        
        // Create final RecipeDeatils Data Model
        let details = RecipeDetails(title: title, imageUrl: imageUrl, instructions: instructions, ingredients: ingredients)
        
        return details
    }
    
    // Method to filter out empty ingredients and measurements
    private func nonEmptyIngredientsAndMeasurements() -> [(String, String)] {
        // Use reflection to inspect the properties of the struct
        let mirror = Mirror(reflecting: self)
        
        var ingredients: [String] = []
        var measurements: [String] = []
        
        // Iterate over the properties of the struct and append non empty values
        for child in mirror.children {
            if let label = child.label, label.hasPrefix("ingredient") {
                if let ingredient = child.value as? String, !ingredient.isEmpty {
                    ingredients.append(ingredient)
                }
            } else if let label = child.label, label.hasPrefix("measurement") {
                if let measurement = child.value as? String, !measurement.isEmpty {
                    measurements.append(measurement)
                }
            }
        }
        
        // Combine ingredients and measurements into pairs
        let pairs = zip(ingredients, measurements)
        
        return Array(pairs)
    }
}
