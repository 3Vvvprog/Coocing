//
//  CookViewController.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 13.10.2023.
//

import UIKit
import SnapKit
import RxCocoa
import RxRelay
import RxSwift


class CookViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.screanWidth = view.frame.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        initialize()
        Constants.screanHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        makeConstraints()
       
    }
    
    private var items: [CookTypeFood] = [
        CookTypeFood(backgroundImage: UIImage(named: "BreakfastBack")!, logo: UIImage(named: "BreakfastLogo")!, nameOfTypeFood: "Завтраки", type: .breakfast),
        CookTypeFood(backgroundImage: UIImage(named: "snacksBack")!, logo: UIImage(named: "snacksLogo")!, nameOfTypeFood: "Закуски", type: .snacks),
        CookTypeFood(backgroundImage: UIImage(named: "saladBack")!, logo: UIImage(named: "saladLogo")!, nameOfTypeFood: "Салаты", type: .salad),
        CookTypeFood(backgroundImage: UIImage(named: "meatBack")!, logo: UIImage(named: "meatLogo")!, nameOfTypeFood: "Вторые блюда", type: .meat),
        CookTypeFood(backgroundImage: UIImage(named: "soupBack")!, logo: UIImage(named: "soupLogo")!, nameOfTypeFood: "Cупы", type: .soup),
    ]
    
    private var customBar = CustomSearchController(searchResultsController: nil)
    private var bag = DisposeBag()
    
    private var filtredItems = [FoodItem]()
    
    private let searchBarheight: Int = 40
    private var allItems = allFoodDescription.allItems
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // private constants
    private enum UIConstants {
        
    }
    
    // Private properties

    private var collectionView: UICollectionView!
    private var searchButton: UIBarButtonItem!
    private var searchLabel: UIBarButtonItem!
    private var searchController = UISearchController(searchResultsController: nil)
    
}

private extension CookViewController {
    func initialize() {
        view.backgroundColor = Constants.backColor
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.backColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CookFoodCell.self, forCellWithReuseIdentifier: "CookFoodCell")
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: "FoodCell")
        navigationItem.titleView = searchController.searchBar
        view.addSubview(collectionView)
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        
        definesPresentationContext = true
        
        
        
        
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func makeRightBarButtonItem() -> [UIBarButtonItem] {
        searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(didTapSearchBarButton))
        
        return [searchButton]
    }
    
    func makeSearchLabel() -> [UIBarButtonItem] {
        
        searchLabel = UIBarButtonItem(customView: customBar.searchBar)
        return [searchLabel]
    }
    
    
    
    @objc func didTapSearchBarButton() {
        print("Search")
        
        
    }
}


extension CookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filtredItems.count
        }else {
            return items.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isFiltering {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            cell.configure(with: filtredItems[indexPath.item])
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CookFoodCell", for: indexPath) as! CookFoodCell
            cell.configure(with: items[indexPath.item])
            return cell
        }
        
    }
    
    
}

extension CookViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vc: UIViewController
        
        if !isFiltering {
            FoodDescriptionConfigure.type = items[indexPath.item].type
            FoodDescriptionConfigure.choisedName = items[indexPath.item].nameOfTypeFood
            vc = FoodViewControllerSet()
            navigationController?.pushViewController(vc, animated: true)
        }else {
            FoodDescriptionConfigure.type = filtredItems[indexPath.item].type
            FoodDescriptionConfigure.choisedName = filtredItems[indexPath.item].name
            vc = FoodDescriptionViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}

extension CookViewController: UISearchResultsUpdating {
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
