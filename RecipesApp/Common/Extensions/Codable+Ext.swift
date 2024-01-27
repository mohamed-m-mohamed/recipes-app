//
//  Codable+Ext.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import Foundation

// MARK: - Encodable Extension

/// Extension on Encodable protocol to convert an encodable object into a dictionary.
extension Encodable {
    
    /// Converts the encodable object into a dictionary.
    var dictionary: [String: Any]? {
        // Attempt to encode the object into JSON data
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        // Attempt to deserialize JSON data into a dictionary
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }
    }
}

