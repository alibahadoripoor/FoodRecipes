//
//  UIView + Extensions.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 24.07.21.
//

import UIKit

extension UIView {
    func fixInView(_ container: UIView) {
        container.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    }
}
