//
//  FindRecipesController.swift
//  Cookery
//
//  Created by Vladislav Mazurov on 19.05.21.
//

import UIKit

class FindRecipesController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SavedRecipeCell", bundle: nil), forCellReuseIdentifier: "SavedRecipeCell")
        tableView.reloadData()
    }
    
    
}
