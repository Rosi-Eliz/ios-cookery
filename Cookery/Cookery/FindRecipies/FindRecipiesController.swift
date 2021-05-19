//
//  FindRecipiesController.swift
//  Cookery
//
//  Created by Vladislav Mazurov on 19.05.21.
//

import UIKit

class FindRecipiesController: UIViewController {

    var recipeModel: [SavedRecipeModel] = []
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FindRecipeCell", bundle: nil), forCellReuseIdentifier: "FindRecipeCell")
        tableView.reloadData()
    }
    
}

extension FindRecipiesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindRecipeCell", for: indexPath) as! FindRecipeCell
        let recipes = recipeModel[indexPath.row]
        
        cell.recipeImage.image = recipes.recipeImage
        cell.recipeNameLabel.text = recipes.recipeName
        
        return cell
    }
    
}

extension FindRecipiesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FindRecipiesController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "type smth"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //placeholder text
        searchField.text = "Grenne Pea"
        recipeModel = [
            SavedRecipeModel(recipeImage: UIImage(named: "recipe-placeholder")!, recipeName: "Grean Peas", recipeRating: 8, recipeTime: 20, recipePrice: "$"),
            SavedRecipeModel(recipeImage: UIImage(named: "recipe-placeholder")!, recipeName: "Grean Peas with beans", recipeRating: 7, recipeTime: 45, recipePrice: "$$$"),
            SavedRecipeModel(recipeImage: UIImage(named: "recipe-placeholder")!, recipeName: "Tomato with green peas", recipeRating: 9, recipeTime: 30, recipePrice: "$$")]
        tableView.reloadData()
    }
}
