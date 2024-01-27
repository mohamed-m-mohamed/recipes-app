//
//  RecipesListRequest.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import Foundation

// Model for recipes list request using category
struct RecipesListRequest: Encodable {
    let category: String
    
    private enum CodingKeys: String, CodingKey {
        case category = "c"
    }
}
