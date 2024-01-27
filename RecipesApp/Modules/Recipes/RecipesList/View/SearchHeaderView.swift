//
//  SearchHeaderView.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import UIKit
import SnapKit
import Combine

class SearchHeaderView: UIView {
    
    // MARK: - Properties
    private let textSubject = CurrentValueSubject<String?, Never>(nil)
    var valuePublisher: AnyPublisher<String, Never> {
        textSubject.compactMap({ $0 }).eraseToAnyPublisher()
    }
    
    // MARK: - Views
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a recipe"
        searchBar.backgroundImage = UIImage()
        searchBar.roundCorners(with: 10)
        searchBar.addDoneButtonToKeyboard()
        return searchBar
    }()
    
    // MARK: - Intializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
        setSearchBarDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    
    // Setup layout
    private func setupLayout () {
        // searchBar constraints
        addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        // View layout
        backgroundColor = .white
        layer.applyShadow(color: .black,
                          alpha: 0.1,
                          x: 0,
                          y: 0,
                          blur: 6)
    }
    
    // Setup searchBarDelegate {
    private func setSearchBarDelegate () {
        searchBar.delegate = self
    }
}

extension SearchHeaderView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textSubject.send(searchBar.text ?? "")
    }
}
