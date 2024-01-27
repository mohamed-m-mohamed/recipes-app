//
//  IngredientView.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import UIKit
import SnapKit

class IngredientView: UIView {
    // MARK: - Views
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        LabelFactory.build(text: nil, font: .systemFont(ofSize: 15))
    }()
    
    private let measurementLabel: UILabel = {
        LabelFactory.build(text: nil, font: .systemFont(ofSize: 13), textColor: .gray)
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    // Populate view from ingredient model
    func configure (with ingredient: Ingredient) {
        nameLabel.text = ingredient.name
        measurementLabel.text = ingredient.measure
        
        let imageUrl = URL(string: ingredient.imageUrl)
        imageView.sd_setImage(with: imageUrl)
    }
    
    // Setup layout
    private func setupLayout () {
        // imageView constraints
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().offset(6)
            
            make.height.width.equalTo(40)
        }
        
        // nameLabel constraints
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.centerY.equalTo(imageView.snp.centerY)
        }
        
        // measurementLabel constraints
        addSubview(measurementLabel)
        
        measurementLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(imageView.snp.centerY)
        }
    }
}
