//
//  RecipesService.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import Foundation

// MARK: - RecipesService Enum

/// Enum defining different endpoints for the recipes service.
enum RecipesService: Service {
    
    // MARK: - Endpoints
    case listRecipes(params: RecipesListRequest)
    case getRecipeDetails(params: RecipeDetailsRequest)
    
    // MARK: - Path
    
    /// Returns the path for each endpoint.
    var path: String {
        switch self {
        case .listRecipes:
            return "filter.php"
        case .getRecipeDetails:
            return "lookup.php"
        }
    }
    
    // MARK: - URL Parameters
    
    /// Returns the URL parameters for each endpoint.
    var urlParameters: Parameters? {
        switch self {
        case .listRecipes(let params):
            return params.dictionary
        case .getRecipeDetails(let params):
            return params.dictionary
        }
    }
    
    // MARK: - HTTP Method
    
    /// Returns the HTTP method for each endpoint.
    var method: NetworkConstants.HttpMethod {
        switch self {
        default: return .get
        }
    }
}
