//
//  RecipeDetailsView.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import UIKit
import SnapKit

class RecipeDetailsView: UIView {
    
    // MARK: - Views
    private let titleLabel: UILabel = {
        LabelFactory.build(text: nil, font: .systemFont(ofSize: 20, weight: .bold))
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.roundCorners(with: 10)
        return imageView
    }()
    
    private let instructionsLabel: UILabel = {
        let label = LabelFactory.build(text: nil, font: .systemFont(ofSize: 16))
        label.numberOfLines = 0
        return label
    }()
    
    private let ingredientsTitleLabel: UILabel = {
        LabelFactory.build(text: "Ingredients", font: .systemFont(ofSize: 16, weight: .semibold))
    }()
    
    private lazy var vStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: - Initilizers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    // Populate view from details model
    func configure (with details: RecipeDetails) {
        titleLabel.text = details.title
        instructionsLabel.text = details.instructions
        
        let imageUrl = URL(string: details.imageUrl)
        imageView.sd_setImage(with: imageUrl)
        
        details.ingredients.forEach { ingredient in
            let ingredientView = IngredientView()
            ingredientView.configure(with: ingredient)
            
            vStackView.addArrangedSubview(ingredientView)
        }
    }
    
    // Setup layout
    private func setupLayout () {
        
        // titleLabel constraints
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalToSuperview().offset(23)
        }
        
        // imageView constraints
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(imageView.snp.height)
            make.height.equalTo(215)
        }
        
        // instructionsLabel constraints
        addSubview(instructionsLabel)
        
        instructionsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        // ingredientsTitleLabel constraints
        addSubview(ingredientsTitleLabel)
        
        ingredientsTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalTo(instructionsLabel.snp.bottom).offset(30)
        }
        
        // vStackView constraints
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalTo(ingredientsTitleLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
