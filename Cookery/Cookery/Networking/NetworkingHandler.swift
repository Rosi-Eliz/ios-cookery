//
//  NetworkingHandler.swift
//  Cookery
//
//  Created by Rosi-Eliz Dzhurkova on 18.05.21.
//

import Foundation

class NetwokringHandler {
    private static let apiKey = "87a44ca0b30d4fba8aab771763b898a8"
    enum Endpoint: String {
        private static let baseURL = "https://api.spoonacular.com"
        case randomRecipes
        case foodIngredientsAutocomplete
        case recipeAutocomplete
        
        fileprivate var stringURL: String {
            switch self {
            case .randomRecipes: return Endpoint.baseURL.appending("/recipes/random")
            case .foodIngredientsAutocomplete: return Endpoint.baseURL.appending("/food/ingredients/autocomplete")
            case .recipeAutocomplete: return
                Endpoint.baseURL
                .appending("/recipes/autocomplete")
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
    
    static func getRecipesForQuery(_ query: String,
                                       completion: @escaping (Result<[Recipes], Error>) -> Void) {
        var queryParameters = apiQueryParameter
        queryParameters["query"] = "\(query)"
        NetworkingManager.shared.request(forUrl: Endpoint.recipeAutocomplete.stringURL,
                                         httpMethod: .get,
                                         queryParameters: queryParameters,
                                         completion: completion)
    }
    
    private static var apiQueryParameter: [String: String] {
        return ["apiKey": apiKey]
    }
}
