//
//  HorizontalListTableViewCell.swift
//  Cookery
//
//  Created by Rosi-Eliz Dzhurkova on 21.05.21.
//

import UIKit

protocol Listable {
    var imageResource: String { get }
    var displayedName: String { get }
}

class HorizontalListTableViewCell: UITableViewCell {
    struct Model {
        let title: String
        let items: [Listable]
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var separatorView: UIView!
    
    var model: Model? {
        didSet {
            collectionView.reloadData()
            self.titleLabel.text = model?.title
            self.subtitleLabel.text = "\(model?.items.count ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    private func configureUI() {
        separatorView.backgroundColor = .paleGrey
        [titleLabel, subtitleLabel].forEach {
            $0?.textColor = .mainGreen
            $0?.font = .primaryTitleFont
        }
    }
}

extension HorizontalListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = model else {
            return 0
        }
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoFrame", for: indexPath) as? InfoFrameCollectionViewCell,
              let model = model else {
            return UICollectionViewCell()
        }
        let item = model.items[indexPath.row]
        NetwokringHandler.loadImageURL(item.imageResource, into: cell.imageView)
        cell.label.text = item.displayedName

        return cell
    }
}
