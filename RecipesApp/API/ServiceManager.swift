//
//  ServiceManager.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import Foundation
import Combine
import Alamofire

// MARK: - ServiceManager

/// Singleton class responsible for managing network requests using Alamofire.
final class ServiceManager {
    
    /// Shared instance of the ServiceManager for global access.
    static var shared = ServiceManager()
    
    /// Alamofire session manager used for making network requests.
    var manager: Alamofire.Session
    
    /// Initializes the ServiceManager with a default Alamofire session.
    public init() {
        self.manager = Alamofire.Session()
    }
    
    /// Sends a network request for a specified service and returns a Combine publisher for handling responses.
    /// - Parameters:
    ///   - service: The service for which the network request is being made.
    /// - Returns: A Combine publisher emitting the decoded response or an error.
    func request<T: Codable>(for service: Service) -> AnyPublisher<T, Error> {
        let request = preprocess(service)
            .map { urlRequest -> DataRequest in
                return self.manager.request(urlRequest)
            }
            .flatMap { dataRequest -> AnyPublisher<DataResponse<Data, AFError>, Error> in
                return dataRequest.publishData()
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .tryMap { (dataResponse) -> T in
                return try self.processResponse(dataResponse)
            }
            .eraseToAnyPublisher()
        
        return request
    }
    
    /// Processes the Alamofire data response and returns the decoded object or throws an error.
    /// - Parameter response: The Alamofire data response.
    /// - Throws: An error if decoding or processing fails.
    private func processResponse<T: Codable>(_ response: DataResponse<Data, AFError>) throws -> T {
        let error: Error
        
        switch response.result {
        case .success(let data):
            guard let statusCode = response.response?.statusCode else {
                throw NetworkError.unknown(message: "An unknown error has occurred")
            }
            
            switch statusCode {
            case 200..<300:
                let decoder = JSONDecoder()
                
                guard let object = try? decoder.decode(T.self, from: data) else {
                    throw NetworkError.encodingFailed
                }
                
                return object
            default:
                error = parseErrorData(response: response)
            }
            
        case .failure(let afError):
            error = afError
        }
        
        throw error
    }
    
    /// Converts a service into a URLRequest and returns it as a Combine publisher.
    /// - Parameter service: The service to be converted into a URLRequest.
    /// - Returns: A Combine publisher emitting the URLRequest or an error.
    func preprocess(_ service: Service) -> AnyPublisher<URLRequest, Error> {
        Just(service)
            .tryMap{ (service) -> URLRequest in
                return try service.asURLRequest()
            }
            .eraseToAnyPublisher()
    }
    
    /// Parses the error data from the Alamofire data response and returns the corresponding network error.
    /// - Parameter response: The Alamofire data response.
    /// - Returns: The network error based on the response status code.
    func parseErrorData(response: DataResponse<Data, AFError>) -> Error {
        guard let statusCode = response.response?.statusCode else {
            return NetworkError.unknown(message: "An unknown error has occurred")
        }
        
        switch statusCode {
        case 504:
            return NetworkError.timeout
        case 500:
            return NetworkError.serverError
        case 401:
            return NetworkError.unauthorized
        case 404:
            return NetworkError.notFound
        default:
            return NetworkError.unknown(message: "An unknown error with code \(statusCode) has occurred")
        }
    }
}

// MARK: - Data Extension

extension Data {
    /// Returns a pretty-printed JSON string for debugging and logging purposes.
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
