//
//  NetworkConstants.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import Foundation

// MARK: - NetworkConstants Enum

/// Enum containing constants related to network operations.
enum NetworkConstants {
    
    /// Base URLs
    static let baseURL = "https://themealdb.com/api/json/v1/1/"
        
    /// The keys for HTTP header fields
    enum HTTPHeaderFieldKey: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    /// The values for HTTP header fields
    enum HTTPHeaderFieldValue: String {
        case json = "application/json"
        case html = "text/html"
        case formEncode = "application/x-www-form-urlencoded"
        case accept = "*/*"
    }
    
    /// Standard HTTP Methods
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case put = "PUT"
    }
}
