//
//  AddIngredientsController.swift
//  Cookery
//
//  Created by Vladislav Mazurov on 17.05.21.
//

import UIKit

class AddIngredientsController: UIViewController {

    var ingredientModel: [IngredientModel] = []
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FindIngredientCell", bundle: nil), forCellReuseIdentifier: "FindIngredientCell")
        tableView.reloadData()
    }

}

extension AddIngredientsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindIngredientCell", for: indexPath) as! FindIngredientCell
        let ingredients = ingredientModel[indexPath.row]
        
        cell.ingredientImage.image = ingredients.ingredientImage
        cell.ingredientName.text = ingredients.ingredientName
        
        return cell
    }
    
}

extension AddIngredientsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AddIngredientsController: UITextFieldDelegate {
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
        searchField.text = "Tomat"
        ingredientModel = [
            IngredientModel(ingredientImage: UIImage(named: "recipe-placeholder")!, ingredientName: "Tomato"),
            IngredientModel(ingredientImage: UIImage(named: "recipe-placeholder")!, ingredientName: "Tomato Sauce"),
            IngredientModel(ingredientImage: UIImage(named: "recipe-placeholder")!, ingredientName: "Tomato juice"),
            ]
        tableView.reloadData()
    }
}
