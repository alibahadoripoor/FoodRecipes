//
//  ViewController.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 20.07.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Network().fetchAllRecipes { result in
            switch result{
            case .success(let recipes):
                print(recipes)
            case .failure(let err):
                print(err)
            }
        }
    }
}

