//
//  RecipesListViewController.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import UIKit
import SnapKit
import Combine

final class RecipesListViewController: UIViewController {
    // MARK: - Properties
    let viewModel: RecipesListViewModel
    private var recipes: [Recipe] = []
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Views
    private let searchHeaderView: SearchHeaderView = {
        let view = SearchHeaderView()
        
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 13
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 18, left: 18, bottom: 0, right: 18)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.registerCell(cellClass: RecipeCollectionViewCell.self)
        collectionView.backgroundColor = UIColor(hexString: "#F5F5F5")
        
        return collectionView
    }()
    
    // MARK: - Initializers
    init(viewModel: RecipesListViewModel = RecipesListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionView()
        setupKeyboardObservers()
        bind()
        viewModel.getRecipes(with: "Dessert")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Bind to ViewModel
    private func bind () {
        
        // Update UI according to ViewModel state
        let stateValueHandler: (RecipesListViewModel.ResponseState) -> Void = { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loading:
                self.startLoadingIndicator()
            case .empty:
                self.stopLoadingIndicator()
            case .error(let error):
                self.stopLoadingIndicator()
                self.showAlert(message: error)
            case .success(let recipes):
                self.stopLoadingIndicator()
                self.recipes = recipes
                self.collectionView.reloadData()
            default:
                self.stopLoadingIndicator()
            }
        }
        
        // Bind to ViewModel state
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &cancellables)
        
        // Bind search bar publisher to viewmodel and return results
        let searchOutput = viewModel.bindSearch(searchHeaderView.valuePublisher)
        searchOutput.sink { [weak self] recipes in
            
            // if no results are found set empty state
            if (recipes.count == 0) {
                self?.collectionView.setEmptyMessage("No recipes found")
            } else {
                self?.collectionView.restore()
            }
            
            self?.recipes = recipes
            self?.collectionView.reloadData()
        }.store(in: &cancellables)
    }
    
    // Setup collection view delegates
    private func setupCollectionView () {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // Setup layout
    private func setupLayout () {
        view.addSubview(collectionView)
        view.addSubview(searchHeaderView)
        
        // collectionView constraints
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchHeaderView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        // searchHeaderView constraints
        searchHeaderView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}

extension RecipesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(indexPath: indexPath) as RecipeCollectionViewCell
        
        let recipe = recipes[indexPath.item]
        cell.configure(with: recipe)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = recipes[indexPath.item]
        let vc = RecipeDetailsViewController(recipeId: item.id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecipesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 18 - 18 - 13)/2, height: 235)
    }
}

extension RecipesListViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        collectionView.contentInset = UIEdgeInsets.zero
        collectionView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

}
