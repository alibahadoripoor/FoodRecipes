//
//  RecipeDetailsViewController.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 24.07.21.
//

import UIKit
import Kingfisher

final class RecipeDetailsViewController: BaseViewController, UIScrollViewDelegate {
    
    // MARK: - Enums
    
    enum Section {
        case title
        case chefName
        case tags
        case description
    }
    
    // MARK: - Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var imageHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    
    private var viewModel: RecipeDetailsViewModel!
    private var dataSource: UICollectionViewDiffableDataSource<Section, DetailsCellViewModel>! = nil
    
    // MARK: - Class Functions
    
    class func newInstance(with viewModel: RecipeDetailsViewModel) -> RecipeDetailsViewController {
        let viewController = RecipeDetailsViewController(nibName: String(describing: RecipeDetailsViewController.self), bundle: nil)
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetNavigationController()
    }
    
    // MARK: - Private UI Functions
    
    private func setupNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func resetNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func configureUI(){
        ///imageView
        let width = Double(view.bounds.width)
        let height = width / viewModel.imageAspectRatio
        imageHeight.constant = CGFloat(height)
        let placeholder = UIImage()
        if let url = viewModel?.imageURL{
            let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
            imageView.kf.setImage(with: resource, placeholder: placeholder, options: [.transition(.fade(0.2))], progressBlock: nil) { _ in }
        }
        
        ///collectionView
        collectionView.register(UINib(nibName: DetailsCell.identifier, bundle: nil), forCellWithReuseIdentifier: DetailsCell.identifier)
        collectionView.collectionViewLayout = generateLayout()
        let navHeight = navigationController?.navigationBar.bounds.height ?? 0
        collectionView.contentInset.top = imageHeight.constant - navHeight
    }
    
    // MARK: - CollectionView DataSource Functions
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, DetailsCellViewModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, viewModel: DetailsCellViewModel) -> UICollectionViewCell? in

            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DetailsCell.identifier,
                    for: indexPath) as? DetailsCell else { fatalError("Could not create new cell") }
            cell.text = viewModel.text
            cell.sectionType = self.viewModel.sections[indexPath.section]
            return cell
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, DetailsCellViewModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DetailsCellViewModel>()
        
        if viewModel.titleCellViewModel.text != nil {
            snapshot.appendSections([Section.title])
            snapshot.appendItems([viewModel.titleCellViewModel])
        }
        
        if viewModel.chefNameCellViewModel.text != nil {
            snapshot.appendSections([Section.chefName])
            snapshot.appendItems([viewModel.chefNameCellViewModel])
        }
        
        if let tagsCellViewModels = viewModel.tagsCellViewModels{
            snapshot.appendSections([Section.tags])
            snapshot.appendItems(tagsCellViewModels)
        }
        
        if viewModel.descriptionCellViewModel.text != nil {
            snapshot.appendSections([Section.description])
            snapshot.appendItems([viewModel.descriptionCellViewModel])
        }
        
        return snapshot
    }
    
    // MARK: - CollectionView Layout Functions
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = self?.viewModel.sections[sectionIndex]
            switch (sectionLayoutKind) {
            case .tags: return self?.generateTagsLayout()
            default: return self?.generateDefaultLayout()
            }
        }
        return layout
    }
    
    private func generateDefaultLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(10))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    private func generateTagsLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .estimated(10), heightDimension: .estimated(10))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.edgeSpacing = .init(leading: .fixed(8), top: nil, trailing: nil, bottom: nil)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    //MARK: - ScrollView Delegates
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentWidth = Double(view.bounds.width)
        let currentHeight = currentWidth / viewModel.imageAspectRatio
        let y = Double(scrollView.contentOffset.y)
        let offsetY = currentHeight - ( y + currentHeight)
        imageHeight.constant = CGFloat(max(64, offsetY))
    }
}
