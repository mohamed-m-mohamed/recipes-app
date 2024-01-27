//
//  RecipeDetailsViewController.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import UIKit
import SnapKit
import Combine

final class RecipeDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private lazy var viewModel = RecipeDetailsViewModel()
    private let recipeId: String
    
    
    // MARK: - Views
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(hexString: "#F5F5F5")
        return scrollView
    }()
    
    private let recipeDetailsView: RecipeDetailsView = {
        let recipeDetailsView = RecipeDetailsView()
        return recipeDetailsView
    }()
    
    
    // MARK: - Initializers
    init (recipeId: String) {
        self.recipeId = recipeId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Call API
        viewModel.getRecipeDetails(with: recipeId)
    }
    
    // Bind to ViewModel
    private func bind () {
        // Update UI according to ViewModel state
        let stateValueHandler: (RecipeDetailsViewModel.ResponseState) -> Void = { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loading:
                // Start loading
                self.startLoadingIndicator()
                
            case .error(let error):
                // Stop loading and show alert
                self.stopLoadingIndicator()
                self.showAlert(message: error)
                
            case .success(let recipeDetails):
                // Stop loading and populate views
                self.stopLoadingIndicator()
                self.title = recipeDetails.title
                recipeDetailsView.configure(with: recipeDetails)
            default:
                // Stop loading
                self.stopLoadingIndicator()
            }
        }
        
        // Bind to ViewModel state
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &cancellables)
    }
    
    // setup layout
    private func setupLayout () {
        
        // scrollView constraints
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        // recipeDetailsView constraints
        scrollView.addSubview(recipeDetailsView)
        
        recipeDetailsView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
    }
}
