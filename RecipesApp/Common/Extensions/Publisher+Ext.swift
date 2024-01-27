//
//  Publisher+Ext.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import Combine

// MARK: - Observable Type Alias

/// Type alias for an observable stream with a generic type and error.
public typealias Observable<T> = AnyPublisher<T, Error>

// MARK: - Publisher Extension

/// Extension on the Publisher protocol providing utility functions for creating and transforming observables.
extension Publisher {
    
    /// Converts a publisher into an observable stream.
    ///
    /// - Returns: An observable stream of the publisher's output type.
    public func asObservable() -> Observable<Output> {
        self
            .mapError { $0 } // Map errors to the generic Error type
            .eraseToAnyPublisher()
    }
    
    /// Creates an observable stream with a single value.
    ///
    /// - Parameter output: The value to emit in the observable stream.
    /// - Returns: An observable stream containing the specified value.
    public static func just(_ output: Output) -> Observable<Output> {
        Just(output)
            .setFailureType(to: Error.self) // Set the failure type to the generic Error type
            .eraseToAnyPublisher()
    }
    
    /// Creates an empty observable stream.
    ///
    /// - Returns: An empty observable stream.
    public static func empty() -> Observable<Output> {
        return Empty().eraseToAnyPublisher()
    }
}

