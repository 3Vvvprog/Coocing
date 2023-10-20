//
//  FoodViewControllerSet.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 14.10.2023.
//

import UIKit
import SnapKit

class FoodViewControllerSet: UIViewController {
    
    
    private func configure() {
        switch FoodDescriptionConfigure.type {
        case .breakfast:
            allItems = Food.breakfastItems
        case .snacks:
            allItems = Food.snacksItems
        case .salad:
            allItems = Food.saladItems
        case .meat:
            allItems = Food.meatItems
        case .soup:
            allItems = Food.soupItems
            
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = Constants.backColor
        title = "Завтраки"
        navigationItem.leftBarButtonItems = makeLeftTabBarButton()
        
        configure()
        initialize()
        makeConstraints()
        
    }
    
    
    
    deinit {
        print("Deinit")
    }
    
    
    private var filtredItems = [FoodItem]()
    
    private var allItems = [FoodItem]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // private properties
    private var collectionView: UICollectionView!
    
    private var searchController = UISearchController(searchResultsController: nil)
}


private extension FoodViewControllerSet {
    
    func initialize() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.backColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: "FoodCell")
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
    
    func makeRightBarButtonItem() -> [UIBarButtonItem] {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(didTapSearchBarButton))
        
        return [searchButton]
    }
    
    @objc func didTapSearchBarButton() {
        print("Search")
    }
    
    @objc func didTapBackBarButton() {
        navigationController?.popViewController(animated: true)
    }
}



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


extension FoodViewControllerSet: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FoodDescriptionViewController()
        let number = indexPath.item
        FoodDescriptionConfigure.cellNumber = number
        
        if breakfastFoodDescription.breakfastItemDescriptions.count > number {
            navigationController?.pushViewController(vc, animated: true)
        }else {
            print("Ничего не найдено!!")
        }
        
        
    }
}



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
