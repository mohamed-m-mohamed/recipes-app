//
//  LabelFactory.swift
//  tip-calculator
//
//  Created by Mohamed on 01/11/2023.
//

import UIKit

// MARK: - LabelFactory Struct

/// A factory for creating UILabel instances with customizable properties.
struct LabelFactory {
    
    /// Builds and returns a UILabel with specified properties.
    ///
    /// - Parameters:
    ///   - text: The text to be displayed in the label.
    ///   - font: The font of the text.
    ///   - backgoundColor: The background color of the label (default is clear).
    ///   - textColor: The text color of the label (default is black).
    ///   - textAlignment: The alignment of the text in the label (default is left).
    /// - Returns: A configured UILabel.
    static func build(
        text: String?,
        font: UIFont,
        backgoundColor: UIColor = .clear,
        textColor: UIColor = .black,
        textAlignment: NSTextAlignment = .left) -> UILabel {
        
        // Create a new UILabel instance
        let label = UILabel()
        
        // Set the properties based on the provided parameters
        label.text = text
        label.font = font
        label.backgroundColor = backgoundColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        
        // Return the configured UILabel
        return label
    }
}
