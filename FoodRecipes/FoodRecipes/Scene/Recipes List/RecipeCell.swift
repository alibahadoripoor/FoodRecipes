//
//  RecipeCell.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 20.07.21.
//

import UIKit
import Kingfisher

final class RecipeCell: UITableViewCell {

    static let identifire = String(describing: RecipeCell.self)
    
    // MARK: - Outlets
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var titleLable: UILabel!
    
    // MARK: - Update UI Functions
    
    func updateCell(with viewModel: RecipeCellViewModel?){
        let placeholder = UIImage()
        if let url = viewModel?.imageURL{
            let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
            foodImageView.kf.setImage(with: resource, placeholder: placeholder, options: [.transition(.fade(0.2))], progressBlock: nil) { _ in }
        }
        titleLable.text = viewModel?.title
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainerView()
    }

    // MARK: - Private Functions
    
    private func setupContainerView(){
        containerView.layer.cornerRadius = 10
    }
}
