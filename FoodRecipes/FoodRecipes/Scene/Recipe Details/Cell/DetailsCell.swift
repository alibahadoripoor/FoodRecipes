//
//  DetailsCell.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 24.07.21.
//

import UIKit

class DetailsCell: UICollectionViewCell {
    static let identifier = String(describing: DetailsCell.self)
    
    @IBOutlet private weak var textLabel: UILabel!
    
    var sectionType: RecipeDetailsViewController.Section? {
        didSet{
            setupUI()
        }
    }
    
    var text: String?{
        didSet{
            textLabel.text = text
        }
    }
    
    private func setupUI(){
        guard let type = sectionType else { return }
        switch type {
        case .title:
            textLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            textLabel.numberOfLines = 0
            self.backgroundColor = .clear
            self.layer.cornerRadius = 0
        case .tags:
            textLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            textLabel.numberOfLines = 1
            self.backgroundColor = .systemGray5
            self.layer.cornerRadius = 8
        default:
            textLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            textLabel.numberOfLines = 0
            self.backgroundColor = .clear
            self.layer.cornerRadius = 0
        }
    }

}
