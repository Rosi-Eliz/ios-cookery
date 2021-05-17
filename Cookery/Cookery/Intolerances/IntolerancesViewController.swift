//
//  IntolerancesViewController.swift
//  Cookery
//
//  Created by Rosi-Eliz Dzhurkova on 17.05.21.
//

import UIKit

struct Intolerance: ChipRepresentable {
    var name: String
}

class IntolerancesViewController: UIViewController {
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var actionButton: PrimaryButton!
    @IBOutlet weak var chipSelectorViewContainer: UIView!
    private var chipsSelectorView: ChipsSelectorView<Intolerance>?
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        sectionLabel.text = "My intolerances"
        sectionLabel.font = .primaryTitleFont
        sectionLabel.textColor = .primaryTitleText
        actionButton.setTitle("Start using Cookery", for: .normal)
        separatorView.backgroundColor = .paleGrey
        descriptionLabel.textColor = .descriptiontText
        descriptionLabel.font = .descriptionFont
        descriptionLabel.text = """
            A food intolerance is difficulty digesting certain foods and having an unpleasant physical reaction to them. It causes symptoms, such as bloating and tummy pain, which usually happen a few hours after eating the food.
            """
        
        let intolerances: [Intolerance] = [
            Intolerance(name: "Dairy"),
            Intolerance(name: "Egg"),
            Intolerance(name: "Gluten"),
            Intolerance(name: "Grain"),
            Intolerance(name: "Peanut"),
            Intolerance(name: "Seafood"),
            Intolerance(name: "Sesame"),
            Intolerance(name: "Shellfish"),
            Intolerance(name: "Soy"),
            Intolerance(name: "Sulfite"),
            Intolerance(name: "Tree Nut"),
            Intolerance(name: "Wheat")
        ]
        
        chipsSelectorView = ChipsSelectorView(chips: intolerances)
        if let chipsSelectorView = chipsSelectorView {
            chipSelectorViewContainer.addSubview(chipsSelectorView)
            chipsSelectorView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                chipsSelectorView.leadingAnchor.constraint(equalTo: chipSelectorViewContainer.leadingAnchor, constant: 0.0),
                chipsSelectorView.trailingAnchor.constraint(equalTo: chipSelectorViewContainer.trailingAnchor, constant: 0.0),
                chipsSelectorView.topAnchor.constraint(equalTo: chipSelectorViewContainer.topAnchor, constant: 0),
                chipsSelectorView.bottomAnchor.constraint(equalTo: chipSelectorViewContainer.bottomAnchor, constant: 0.0)
            ])
        }
    }
    
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let selectedChips = chipsSelectorView?.selectedChips
    }
    
}
