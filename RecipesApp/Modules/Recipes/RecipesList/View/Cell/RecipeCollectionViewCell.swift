//
//  RecipeCollectionViewCell.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import UIKit
import SDWebImage
import SnapKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.roundCorners(with: 10)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = LabelFactory.build(text: nil, font: .systemFont(ofSize: 13, weight: .medium))
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Intializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    // Populate cell from recipe model
    func configure (with recipe: Recipe) {
        let imageUrl = URL(string: recipe.thumbnailUrl)
        imageView.sd_setImage(with: imageUrl)
        
        titleLabel.text = recipe.title
    }
    
    // Setup layout
    private func setupLayout () {
        // ImageView layout
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
            
            make.height.equalTo(imageView.snp.width)
        }
        
        // TitleLabel layout
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        // Cell Layout
        contentView.backgroundColor = .white
        backgroundColor = .clear
        
        contentView.roundCorners(with: 10)
        layer.applyShadow(color: .black,
                          alpha: 0.08,
                          x: 0,
                          y: 0,
                          blur: 5)
    }
}
