//
//  RecipesListViewController.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 20.07.21.
//

import UIKit

final class RecipesListViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables and Constants
    
    private var viewModel: RecipesListViewModel?
    
    // MARK: - Class Functions
    
    class func newInstance(with viewModel: RecipesListViewModel) -> RecipesListViewController {
        let viewController = RecipesListViewController(nibName: String(describing: RecipesListViewController.self), bundle: nil)
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCallBacks()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - Private Functions
    
    private func setupUI(){
        title = "Food Recipes"
        tableView.rowHeight = 300
        tableView.tableFooterView = UIView()
    }
    
    private func setupCallBacks(){
        viewModel?.onFetchCompleted = { [weak self] in
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
        
        viewModel?.onFetchFailed = { [weak self] (message) in
            self?.showAlert("Error", message: message)
        }
    }
}

// MARK: - TableView Delegate and DataSource

extension RecipesListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellsNumber() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifire) == nil{
            tableView.register(UINib(nibName: RecipeCell.identifire, bundle: nil),
                               forCellReuseIdentifier: RecipeCell.identifire)
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifire, for: indexPath) as? RecipeCell {
            cell.updateCell(with: viewModel?.cellViewModel(for: indexPath))
            return cell
        }
        
        return UITableViewCell()
    }
}
