//
//  NetworkingHandler.swift
//  Cookery
//
//  Created by Rosi-Eliz Dzhurkova on 18.05.21.
//

import UIKit

class NetwokringHandler {
    private static let apiKey = "87a44ca0b30d4fba8aab771763b898a8"
    enum Endpoint {
        private static let baseURL = "https://api.spoonacular.com"
        case randomRecipes
        case foodIngredientsAutocomplete
        case detailedRecipe(id: String)
        
        fileprivate var stringURL: String {
            switch self {
            case .randomRecipes: return Endpoint.baseURL.appending("/recipes/random")
            case .foodIngredientsAutocomplete: return Endpoint.baseURL.appending("/food/ingredients/autocomplete")
            case .detailedRecipe(let id): return Endpoint.baseURL.appending("/recipes/\(id)/information")
            }
        }
    }
    
    static func getRandomRecipes(withLimit limit: Int,
                                 completion: @escaping((Result<RandomRecipeQuery, Error>) -> Void)){
        var queryParameters = apiQueryParameter
        queryParameters["number"] = "\(limit)"
        NetworkingManager.shared.request(forUrl: Endpoint.randomRecipes.stringURL,
                                         httpMethod: .get,
                                         queryParameters: queryParameters,
                                         completion: completion)
    }
    
    static func getIngredientsForQuery(_ query: String,
                                       completion: @escaping (Result<[Ingredient], Error>) -> Void) {
        var queryParameters = apiQueryParameter
        queryParameters["query"] = "\(query)"
        NetworkingManager.shared.request(forUrl: Endpoint.foodIngredientsAutocomplete.stringURL,
                                         httpMethod: .get,
                                         queryParameters: queryParameters,
                                         completion: completion)
    }
    
    static func getDetailedRecipe(with id: Int,
                                  completion: @escaping (Result<DetailedRecipe, Error>) -> Void)  {
        var queryParameters = apiQueryParameter
        queryParameters["includeNutrition"] = "true"
        NetworkingManager.shared.request(forUrl: Endpoint.detailedRecipe(id: "\(id)").stringURL,
                                         httpMethod: .get,
                                         queryParameters: queryParameters,
                                         completion: completion)
    }
    
    static func loadImageURL(_ imageURL: String, into imageView: UIImageView) {
        DispatchQueue.global().async { [weak imageView] in
            if let url = URL(string: imageURL),
               let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView?.image = image
                    }
                }
            }
        }
    }
    
    private static var apiQueryParameter: [String: String] {
        return ["apiKey": apiKey]
    }
}
