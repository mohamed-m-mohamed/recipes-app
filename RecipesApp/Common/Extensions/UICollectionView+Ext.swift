//
//  UICollectionView+Ext.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import UIKit

// MARK: - UICollectionView Extension

/// Extension on UICollectionView providing utility functions for cell registration, dequeuing, and managing empty states.
extension UICollectionView {
    
    /// Registers a UICollectionViewCell class for use in the collection view.
    ///
    /// - Parameter cellClass: The type of the cell to register.
    func registerCell<Cell: UICollectionViewCell>(cellClass: Cell.Type) {
        self.register(Cell.self, forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    /// Dequeues a reusable cell for a given index path.
    ///
    /// - Parameter indexPath: The index path specifying the location of the cell.
    /// - Returns: A dequeued cell of the specified type.
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
    
    /// Sets a message to be displayed when the collection view is empty.
    ///
    /// - Parameter message: The message to be displayed.
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    /// Restores the collection view to its normal state by removing the empty message.
    func restore() {
        self.backgroundView = nil
    }
}
