//
//  SavedRecipesController.swift
//  Cookery
//
//  Created by Vladislav Mazurov on 16.05.21.
//

import UIKit

class SavedRecipesController: UIViewController {
    
    var recipeModel: [SavedRecipeModel] = [
        SavedRecipeModel(recipeImage: UIImage(named: "recipe-placeholder")!, recipeName: "Caesar Salad", recipeRating: 8, recipeTime: 20, recipePrice: "$"),
        SavedRecipeModel(recipeImage: UIImage(named: "recipe-placeholder")!, recipeName: "Lasagna", recipeRating: 7, recipeTime: 45, recipePrice: "$$$"),
        SavedRecipeModel(recipeImage: UIImage(named: "recipe-placeholder")!, recipeName: "Oriental Bowl", recipeRating: 9, recipeTime: 30, recipePrice: "$$")]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SavedRecipeCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        tableView.reloadData()
    }


}

extension SavedRecipesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! SavedRecipeCell
        let recipe = recipeModel[indexPath.row]
        
        cell.recipeRatingLabel.attributedText = ratingCalc(rating: recipe.recipeRating)
        cell.recipeImage.image = recipe.recipeImage
        cell.recipeNameLabel.text = recipe.recipeName
        cell.recipeTimeLabel.text = String(recipe.recipeTime)
        cell.recipePriceLabel.text = recipe.recipePrice
        
        return cell
    }
    
    //rendering stars for rating
    func ratingCalc(rating: Int) ->  NSMutableAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow)
        let fullString = NSMutableAttributedString()
        if((rating%2) != 0) {
            let imageAttachmentHalf = NSTextAttachment()
            imageAttachmentHalf.image = UIImage(systemName: "star.leadinghalf.fill")?.withTintColor(.systemYellow)
            for _ in 0...((rating/2)-1) {
                fullString.append(NSAttributedString(attachment: imageAttachment))
            }
            fullString.append(NSAttributedString(attachment: imageAttachmentHalf))
        } else {
            for _ in 1...((rating/2)) {
                fullString.append(NSAttributedString(attachment: imageAttachment))
            }
        }
        fullString.append(NSAttributedString(string: "  \(rating)"))
        return fullString
    }
}
