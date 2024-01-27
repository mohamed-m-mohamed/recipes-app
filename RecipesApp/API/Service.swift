//
//  Service.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import Foundation
import Alamofire

// MARK: - Type Alias

/// Alias for a dictionary representing parameters in network requests.
typealias Parameters = [String: Any]

// MARK: - Service Protocol

/// Protocol defining the requirements for a network service.
protocol Service: URLRequestConvertible {
    
    // MARK: - Properties
    
    /// HTTP method for the service (e.g., GET, POST).
    var method: NetworkConstants.HttpMethod { get }
    
    /// Base URL for the service.
    var baseURL: String { get }
    
    /// Path to be appended to the base URL.
    var path: String { get }
    
    /// Parameters to be included in the request body.
    var parameters: Parameters? { get }
    
    /// URL parameters to be included in the request URL.
    var urlParameters: Parameters? { get }
    
    /// Headers to be included in the request.
    var headers: [NetworkConstants.HTTPHeaderFieldKey: NetworkConstants.HTTPHeaderFieldValue]? { get }
    
    /// Timeout interval for the request.
    var timeoutInterval: TimeInterval { get }
    
    // MARK: - Methods
    
    /// Converts the service into a URLRequest.
    func asURLRequest() throws -> URLRequest
}

// MARK: - Service Extension

extension Service {
    
    // MARK: - Properties
    
    /// Default base URL for the service.
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    /// Default multipart parameters (nil for most services).
    var multipartParameters: MultipartFormData? {
        return nil
    }
    
    /// Default parameters (nil for most services).
    var parameters: Parameters? {
        return nil
    }
    
    /// Default headers (JSON accept and content type).
    var headers: [NetworkConstants.HTTPHeaderFieldKey: NetworkConstants.HTTPHeaderFieldValue]? {
        return [.acceptType: .json, .contentType: .json]
    }
    
    /// Default URL parameters
    var urlParameters: Parameters? {
        return nil
    }
    
    /// Default timeout interval for the request.
    var timeoutInterval: TimeInterval {
        return 20
    }
    
    // MARK: - Methods
    
    /// Converts the service into a URLRequest, handling various aspects like URL encoding, setting headers, and handling different HTTP methods.
    func asURLRequest() throws -> URLRequest {
        let urlPath = baseURL + path
        
        guard let url = URL(string : urlPath.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? urlPath) else {
            throw NetworkError.badAPIRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        // Set headers if available
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value.rawValue, forHTTPHeaderField: key.rawValue)
            }
        }
        
        // Handle different HTTP methods parameter encoding
        switch method {
        case .get:
            try ParameterEncoding.urlEncoding.encode(urlRequest: &urlRequest, parameters: urlParameters)
        default:
            // For other methods, include URL parameters and JSON parameters
            try ParameterEncoding.urlEncoding.encode(urlRequest: &urlRequest, parameters: urlParameters)
            try ParameterEncoding.jsonEncoding.encode(urlRequest: &urlRequest, parameters: parameters)
        }
        
        // Set timeout interval
        urlRequest.timeoutInterval = timeoutInterval
        
        return urlRequest
    }
}
