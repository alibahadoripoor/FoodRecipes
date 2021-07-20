//
//  Network.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 20.07.21.
//

import Foundation
import Contentful

typealias RecipesCompletion = (Result<[Recipe], Error>) -> Void

protocol NetworkProtocol {
    func fetchAllRecipes(completion: @escaping RecipesCompletion)
}

final class Network {
    let contentTypeClasses: [EntryDecodable.Type] = [
        Recipe.self,
        Chef.self,
        Tag.self
    ]
    
    lazy var client: Client = {
        return Client(spaceId: Credentials.spaceId,
                      accessToken: Credentials.accessToken,
                      contentTypeClasses: contentTypeClasses)
    }()
}

extension Network: NetworkProtocol{
    func fetchAllRecipes(completion: @escaping RecipesCompletion){
        let query = QueryOn<Recipe>.where(contentTypeId: "recipe")

        client.fetchArray(of: Recipe.self, matching: query) { result in
            switch result {
            case .success(let entriesArrayResponse):
                let recipes = entriesArrayResponse.items
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

