//
//  NetworkError.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import Foundation

// MARK: - NetworkError Enum

/// Enum representing different network-related errors.
public enum NetworkError: Error {
    case noInternet
    case badAPIRequest
    case unauthorized
    case notFound
    case unknown(message: String)
    case serverError
    case timeout
    case noUrl
    case encodingFailed
}

// MARK: - LocalizedError Extension

/// Extension for providing localized descriptions to the NetworkError enum.
extension NetworkError: LocalizedError {
    
    /// A localized description for each NetworkError case.
    public var errorDescription: String? {
        switch self {
        case .noInternet:           return "No Internet Connection"
        case .badAPIRequest:        return "Bad API Request"
        case .unauthorized:         return "Unauthorized"
        case .unknown(let message): return message
        case .serverError:          return "Internal Server Error"
        case .timeout:              return "Connection Timed Out"
        case .noUrl:                return "Not a valid URL"
        case .encodingFailed:       return "Encoding Failed"
        case .notFound:             return "URL not found"
        }
    }
}
