//
//  UIColor+Ext.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import UIKit

// MARK: - UIColor Extension

/// Extension on UIColor providing a convenience initializer for creating UIColor instances from hex strings.
extension UIColor {
    
    /// Creates a UIColor instance from a hex string.
    ///
    /// - Parameter hexString: The hex string representing the color.
    /// - Note: Supports RGB (12-bit and 24-bit) and ARGB (32-bit) formats.
    convenience init(hexString: String) {
        // Trim and clean the hex string
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        
        // Scan the hex string and convert it to an integer
        Scanner(string: hex).scanHexInt64(&int)
        
        // Define variables for alpha, red, green, and blue components
        let a, r, g, b: UInt64
        
        // Determine the format based on the length of the hex string
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            // Default to opaque black if the format is not recognized
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        // Initialize the UIColor with the components converted to CGFloat values
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

