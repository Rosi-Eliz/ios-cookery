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
        
        fileprivate var stringURL: String {
            switch self {
            case .randomRecipes: return Endpoint.baseURL.appending("/recipes/random")
            }
        }
    }
    
    static func getRandomRecipes(withLimit limit: Int,
                                 andCompletion completion: @escaping((Result<RandomRecipeQuery, Error>)->Void)){
        var queryParameters = apiQueryParameter
        queryParameters["number"] = "\(limit)"
        NetworkingManager.shared.request(forUrl: Endpoint.randomRecipes.stringURL,
                                         httpMethod: .get,
                                         queryParameters: queryParameters,
                                         completion: completion)
    }
    
    private static var apiQueryParameter: [String: String] {
        return ["apiKey": apiKey]
    }
}
