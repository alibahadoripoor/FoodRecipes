//
//  RecipeCellViewModel.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 20.07.21.
//

import Foundation

final class RecipeCellViewModel{
    let title: String?
    let imageURL: URL?
    
    init(recipe: Recipe) {
        self.title = recipe.title
        self.imageURL = recipe.photo?.file?.url
    }
}
