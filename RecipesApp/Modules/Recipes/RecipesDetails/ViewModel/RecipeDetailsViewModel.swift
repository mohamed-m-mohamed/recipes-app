//
//  RecipeDetailsViewModel.swift
//  RecipesApp
//
//  Created by Mohamed on 26/01/2024.
//

import Foundation
import Combine

final class RecipeDetailsViewModel {
    // MARK: - State
    enum ResponseState {
        case initial
        case loading
        case success(RecipeDetails)
        case error(String)
    }
    
    
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable> = .init()
    @Published private(set) var state: ResponseState = .initial
    
    
    // MARK: - Methods
    
    // Fetch recipe details using recipe id
    func getRecipeDetails (with id: String?) {
        // Prep params and service
        let requestData = RecipeDetailsRequest(id: id)
        let service = RecipesService.getRecipeDetails(params: requestData)
        
        // Set loading state
        state = .loading
        
        // Fire request
        ServiceManager.shared.request(for: service)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    print("finished")
                case .failure(let failure):
                    // Set error state
                    self?.state = .error(failure.localizedDescription)
                }
            }, receiveValue: { [weak self] (response: RecipeDetailsResponse) in
                
                // Set success state and pass cleaned data
                if let recipeDetailsModel = response.recipes.first?.transform() {
                    self?.state = .success(recipeDetailsModel)
                }
            })
            .store(in: &cancellables)
    }
}

