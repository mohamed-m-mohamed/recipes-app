//
//  UISearchBar+Ext.swift
//  RecipesApp
//
//  Created by Mohamed on 27/01/2024.
//

import UIKit

// MARK: - UISearchBar Extension

/// Extension on UISearchBar providing a utility function to add a "Done" button to the keyboard toolbar.
extension UISearchBar {
    
    /// Adds a "Done" button to the keyboard toolbar of the search bar.
    func addDoneButtonToKeyboard() {
        // Create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Create a flexible space UIBarButtonItem to separate buttons
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // Create a "Done" button that dismisses the keyboard when tapped
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        // Set the items of the toolbar
        toolbar.items = [flexibleSpace, doneButton]
        
        // Set the toolbar as the input accessory view of the search bar
        self.inputAccessoryView = toolbar
    }
    
    /// Handles the tap event of the "Done" button by resigning the search bar as the first responder.
    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
}

