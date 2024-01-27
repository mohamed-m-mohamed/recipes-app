//
//  RecipesListViewModel.swift
//  RecipesApp
//
//  Created by Mohamed on 25/01/2024.
//

import UIKit
import Combine

final class RecipesListViewModel {
    // MARK: - State
    enum ResponseState {
        case initial
        case empty
        case loading
        case success([Recipe])
        case error(String)
    }
    
    
    // MARK: - Properties
    private var recipes: [Recipe] = []
    private var cancellables: Set<AnyCancellable> = .init()
    @Published private(set) var state: ResponseState = .initial
    
    
    // MARK: - Methods
    
    // Fetch recipes list using category
    func getRecipes (with category: String) {
        // Prep params and service
        let requestData = RecipesListRequest(category: category)
        let service = RecipesService.listRecipes(params: requestData)
        
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
            }, receiveValue: { [weak self] (response: RecipesListResponse) in
                // Sort fetched items alphabetically and store it for later use while searching
                self?.recipes = response.recipes?.sorted(by: {$0.title < $1.title}) ?? []
                
                if let recipes = self?.recipes {
                    // Set empty or success state and pass data
                    self?.state = recipes.count > 0 ? .success(recipes) : .empty
                }
            })
            .store(in: &cancellables)
    }
    
    // Bind search publisher and return results publisher
    func bindSearch (_ input: AnyPublisher<String, Never>) -> AnyPublisher<[Recipe], Never> {
        return input.debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> [Recipe] in
                
                // if search string is empty return original items
                if string.count < 1 {
                    return self.recipes
                }
                
                // Filter items where contains search string
                return self.recipes.filter { $0.title.lowercased().contains(string.lowercased()) }
            })
            .compactMap{ $0 }
            .eraseToAnyPublisher()
    }
}
