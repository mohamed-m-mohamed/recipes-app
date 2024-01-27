//
//  CALayer+Ext.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import UIKit

// MARK: - CALayer Extension

/// Extension on CALayer providing a utility function for applying shadow to the layer.
extension CALayer {
    
    /// Applies a shadow effect to the layer with customizable properties.
    ///
    /// - Parameters:
    ///   - color: The color of the shadow (default is black).
    ///   - alpha: The opacity of the shadow (default is 0.05).
    ///   - x: The horizontal offset of the shadow (default is 1).
    ///   - y: The vertical offset of the shadow (default is 2).
    ///   - blur: The blur radius of the shadow (default is 4).
    ///   - spread: The spread of the shadow (default is 0).
    func applyShadow(
        color: UIColor = UIColor.black,
        alpha: Float = 0.05,
        x: CGFloat = 1,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        // Disable masking to allow shadow to extend beyond the layer's bounds
        masksToBounds = false
        // Set the color of the shadow
        shadowColor = color.cgColor
        // Set the opacity of the shadow
        shadowOpacity = alpha
        // Set the offset of the shadow
        shadowOffset = CGSize(width: x, height: y)
        // Set the radius of the shadow (half of the blur radius)
        shadowRadius = blur / 2.0
        // Set the shadow path, considering spread
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

