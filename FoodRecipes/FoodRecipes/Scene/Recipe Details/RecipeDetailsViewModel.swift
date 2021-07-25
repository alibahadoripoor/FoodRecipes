//
//  RecipeDetailsViewModel.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 24.07.21.
//

import Foundation

final class RecipeDetailsViewModel{
    private var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var sections: [RecipeDetailsViewController.Section] {
        var sections: [RecipeDetailsViewController.Section] = []
        if titleCellViewModel.text != nil {
            sections.append(.title)
        }
        if chefNameCellViewModel.text != nil {
            sections.append(.chefName)
        }
        if tagsCellViewModels != nil {
            sections.append(.tags)
        }
        if descriptionCellViewModel.text != nil {
            sections.append(.description)
        }
        return sections
    }
    
    var imageURL: URL?{
        recipe.photo?.url
    }
    
    var imageAspectRatio: Double{
        guard let width = recipe.photo?.file?.details?.imageInfo?.width,
              let height = recipe.photo?.file?.details?.imageInfo?.height
        else {
            return 1.33
        }
        return width / height
    }
    
    var titleCellViewModel: DetailsCellViewModel{
        DetailsCellViewModel(text: recipe.title)
    }
    
    var chefNameCellViewModel: DetailsCellViewModel{
        if let chefName = recipe.chef?.name{
            return DetailsCellViewModel(text: "Chef Name: " + chefName)
        }else{
            return DetailsCellViewModel(text: nil)
        }
    }
    
    var tagsCellViewModels: [DetailsCellViewModel]? {
        return recipe.tags?.map { DetailsCellViewModel(text: $0.name) }
    }
    
    var descriptionCellViewModel: DetailsCellViewModel{
        DetailsCellViewModel(text: recipe.description)
    }
}
