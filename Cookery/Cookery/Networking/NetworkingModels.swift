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
    let imageType: String
}

struct Ingredient: StorageMainainable {
    static var key = "Ingredients"
    
    let name: String
    let image: String
    
    enum Size: Int {
        case small = 100
        case medium = 250
        case large = 500
    }
    
    func imageURL(for size: Size) -> String {
        return "https://spoonacular.com/cdn/ingredients_\(size.rawValue)x\(size.rawValue)/\(image)"
    }
}
