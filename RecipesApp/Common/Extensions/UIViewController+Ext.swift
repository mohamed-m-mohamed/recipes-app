//
//  UIViewController+Ext.swift
//  RecipesApp
//
//  Created by Mohamed on 27/01/2024.
//

import UIKit

// MARK: - UIViewController Extension

/// Extension on UIViewController providing utility functions for displaying alerts and managing loading indicators.
extension UIViewController {
    
    /// Displays an alert with a specified title, message, and an OK button.
    ///
    /// - Parameters:
    ///   - title: The title of the alert (default is "Error").
    ///   - message: The message to be displayed in the alert.
    func showAlert(title: String = "Error", message: String) {
        // Create an alert controller with the specified title and message
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add an OK button with a default style
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    /// Starts a loading indicator with a large style centered on the view.
    func startLoadingIndicator() {
        // Create a UIActivityIndicatorView with a large style
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        // Center the activity indicator on the view
        activityIndicator.center = view.center
        
        // Set a unique tag to identify the activity indicator
        activityIndicator.tag = 0x123123
        
        // Start animating the activity indicator
        activityIndicator.startAnimating()
        
        // Add the activity indicator to the view
        view.addSubview(activityIndicator)
    }
    
    /// Stops and removes the loading indicator from the view.
    func stopLoadingIndicator() {
        // Check if an activity indicator with the specified tag exists
        if let activityIndicator = view.viewWithTag(0x123123) as? UIActivityIndicatorView {
            // Stop animating the activity indicator
            activityIndicator.stopAnimating()
            
            // Remove the activity indicator from the view
            activityIndicator.removeFromSuperview()
        }
    }
}

