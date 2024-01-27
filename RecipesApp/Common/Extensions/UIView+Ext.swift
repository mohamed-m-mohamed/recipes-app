//
//  UIView+Ext.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import UIKit

// MARK: - UIView Extension

/// Extension on UIView providing a utility function for rounding corners.
extension UIView {
    
    /// Rounds the corners of the view with a specified radius.
    ///
    /// - Parameter radius: The radius to use when rounding the corners.
    func roundCorners(with radius: CGFloat) {
        // Enable maskToBounds to ensure the corners are rounded
        layer.masksToBounds = true
        // Set the corner radius
        layer.cornerRadius = radius
    }
}

