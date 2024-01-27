//
//  ParameterEncoder.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import Foundation

// MARK: - ParameterEncoder Protocol

/// Protocol defining the requirements for encoding parameters into a URLRequest.
protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

// MARK: - ParameterEncoding Enum

/// Enumeration for different types of parameter encoding: URL encoding and JSON encoding.
enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    
    /// Encodes URLRequest parameters based on the specified encoding type.
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be modified.
    ///   - parameters: The parameters to be encoded.
    /// - Throws: An error if encoding fails.
    public func encode(urlRequest: inout URLRequest, parameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = parameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
            case .jsonEncoding:
                guard let bodyParameters = parameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
}

// MARK: - JSONParameterEncoder Struct

/// Struct for encoding JSON parameters.
struct JSONParameterEncoder: ParameterEncoder {
    
    /// Encodes request body JSON parameters.
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be modified.
    ///   - parameters: The JSON parameters to be encoded.
    /// - Throws: An error if encoding fails.
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}

// MARK: - URLParameterEncoder Struct

/// Struct  for encoding URL query parameters.
struct URLParameterEncoder: ParameterEncoder {
    
    /// Encodes request URL query parameters.
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be modified.
    ///   - parameters: The URL query parameters to be encoded.
    /// - Throws: An error if encoding fails.
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.noUrl }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
    }
}
