//
//  FindRecipiesController.swift
//  Cookery
//
//  Created by Vladislav Mazurov on 19.05.21.
//

import UIKit

class FindRecipiesController: UIViewController {
    
    private var recipes: [Recipes] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    
    @IBOutlet weak var searchBarContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = .primaryTitleFont
        titleLabel.textColor = .primaryTitleText
        titleLabel.text = "Find Recipes"
        
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        searchBarContainer.backgroundColor = .paleGrey
        searchBarContainer.layer.cornerRadius = 10
        
        tableView.rowHeight = 100
        tableView.separatorColor = .lightGray
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FindRecipeCell", bundle: nil), forCellReuseIdentifier: "FindRecipeCell")
        tableView.reloadData()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchBar.resignFirstResponder()
    }
    
}

extension FindRecipiesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindRecipeCell", for: indexPath) as! FindRecipeCell
        let recipe = recipes[indexPath.row]
        
        //cell.recipeImage.image = recipes.recipeImage
        cell.recipeNameLabel.text = recipe.title
        
        return cell
    }
    
}

extension FindRecipiesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FindRecipiesController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            NetwokringHandler.getRecipesForQuery(searchText, completion: { [weak self] result in
                switch result {
                case .success(let recipes): self?.recipes = recipes
                case .failure(let error): print(error)
                }
            })
        } else {
            recipes = []
        }
    }
}

/*extension FindRecipiesController: UITextFieldDelegate {
    
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
}*/
