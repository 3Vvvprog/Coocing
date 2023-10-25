//
//  FoodViewControllerSet.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 14.10.2023.
//

import UIKit
import SnapKit

class FoodViewControllerSet: UIViewController {
    
    // MARK: - View Model
    private let viewModel: FoodSetProtocol = FoodSetViewModel()
    
    // MARK: - init
    override func viewDidLoad() {
        allItems = viewModel.getAllItems(type: FoodDescriptionConfigure.type)
        initialize()
        makeConstraints()
    }
    // MARK: - Private arrays
    private var filtredItems = [FoodItem]()
    private var allItems: [FoodItem]!
    
    
    // MARK: - Private properties
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    private var collectionView: UICollectionView!
    
    private var searchController = UISearchController(searchResultsController: nil)
}

// MARK: - Private methods
private extension FoodViewControllerSet {
    
    func initialize() {
        view.backgroundColor = Constants.backColor
        title = "Завтраки"
        navigationItem.leftBarButtonItems = makeLeftTabBarButton()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.backColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: "FoodCell")
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        
        navigationItem.titleView = searchController.searchBar
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Поиск"
        definesPresentationContext = true
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func makeLeftTabBarButton() -> [UIBarButtonItem] {
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(didTapBackBarButton))
        
        return [backBarButton]
    }
    
}

// MARK: - Button actions
private extension FoodViewControllerSet {
    
    @objc func didTapSearchBarButton() {
        print("Search")
    }
    
    @objc func didTapBackBarButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - DataSource
extension FoodViewControllerSet: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering {
            return filtredItems.count
        }else {
            return allItems.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if isFiltering {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            
            cell.configure(with: filtredItems[indexPath.item])
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            
            cell.configure(with: allItems[indexPath.item])
            return cell
            
        }
    }
    
    
}

// MARK: - Delegate
extension FoodViewControllerSet: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FoodDescriptionViewController()
        let number = indexPath.item
        FoodDescriptionConfigure.choisedName = allItems[number].name
        
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
}


// MARK: - Search update action
extension FoodViewControllerSet: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filtredItems = allItems.filter { item -> Bool in
            return item.name.lowercased().contains(searchText.lowercased())
        }
        
        collectionView.reloadData()
    }
}
