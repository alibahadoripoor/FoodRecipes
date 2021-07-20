//
//  RecipesListViewModel.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 20.07.21.
//

import Foundation

final class RecipesListViewModel: ObservableObject{
    private let network: NetworkProtocol
    private var recipes: [Recipe] = []
    var onFetchCompleted: ()->() = {}
    var onFetchFailed: (String)->() = { _ in }
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func viewDidLoad(){
        fetchRecipes()
    }
    
    func cellsNumber() -> Int {
        return recipes.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> RecipeCellViewModel {
        return RecipeCellViewModel(recipe: recipes[indexPath.item])
    }
    
    private func fetchRecipes(){
        network.fetchAllRecipes { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let recipes):
                    self?.recipes = recipes
                    self?.onFetchCompleted()
                case .failure(let error):
                    self?.onFetchFailed("Somthing went wrong: \(error.localizedDescription)")
                }
            }
        }
    }
}


