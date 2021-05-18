//
//  NetworkingModels.swift
//  Cookery
//
//  Created by Rosi-Eliz Dzhurkova on 18.05.21.
//

import Foundation

struct RandomRecipeQuery: Decodable {
    let recipes: [Recipes]
}

struct Recipes: Decodable {
    let id: Int64
    let title: String
}
