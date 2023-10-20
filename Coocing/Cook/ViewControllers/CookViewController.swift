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
        initialize()
    }
    
    override func viewDidLayoutSubviews() {
        Constants.screanHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
       
        makeConstraints()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
        
       
    }
    
    
    
    private var items: [CookTypeFood] = [
        CookTypeFood(backgroundImage: UIImage(named: "BreakfastBack")!, logo: UIImage(named: "BreakfastLogo")!, nameOfTypeFood: "Завтраки", type: .breakfast),
        CookTypeFood(backgroundImage: UIImage(named: "snacksBack")!, logo: UIImage(named: "snacksLogo")!, nameOfTypeFood: "Закуски", type: .snacks),
        CookTypeFood(backgroundImage: UIImage(named: "saladBack")!, logo: UIImage(named: "saladLogo")!, nameOfTypeFood: "Салаты", type: .salad),
        CookTypeFood(backgroundImage: UIImage(named: "meatBack")!, logo: UIImage(named: "meatLogo")!, nameOfTypeFood: "Вторые блюда", type: .meat),
        CookTypeFood(backgroundImage: UIImage(named: "soupBack")!, logo: UIImage(named: "soupLogo")!, nameOfTypeFood: "Cупы", type: .soup),
    ]
    
    
    private var filtredItems = [FoodItem]()
    
    private var allItems = allFoodDescription.allItems
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    private var isFavorite: Bool = false
    
    // private constants
    private enum UIConstants {
        
    }
    
    // Private properties

    private var collectionView: UICollectionView!
    private var searchButton: UIBarButtonItem!
    private var searchController = UISearchController(searchResultsController: nil)
    private var starButton = UIBarButtonItem()
    
}

private extension CookViewController {
    func initialize() {
        view.backgroundColor = Constants.backColor
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItems = makeLeftBarButtonItem()
        
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
        collectionView.isScrollEnabled = false
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
            make.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        starButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didTapStarBarButton))
        
        
        return [starButton]
    }
    
    
    
    
    @objc func didTapStarBarButton() {
        
        if !isFavorite {
            filterContentForFavoriteItems()
            starButton.image = UIImage(systemName: "star.fill")
            starButton.tintColor = .yellow
        }else {
            collectionView.reloadData()
            starButton.image = UIImage(systemName: "star")
            starButton.tintColor = .white
        }
        
        isFavorite = !isFavorite
        
        
    }
    
    private func filterContentForFavoriteItems() {
        
        
        for item in Food.favorit {
            if !FavoriteFood.items.contains(where: { $0.name == item }) {
                FavoriteFood.items.append(allItems.first(where: { $0.name == item })!)
            }
            
            
        }
        
        collectionView.reloadData()
        
    }
}


extension CookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filtredItems.count
        }else if isFavorite {
            return FavoriteFood.items.count
        }else {
            return items.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isFiltering {
            collectionView.isScrollEnabled = true
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            cell.configure(with: filtredItems[indexPath.item])
            return cell
        
        }else if isFavorite{
            collectionView.isScrollEnabled = true
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            cell.configure(with: FavoriteFood.items[indexPath.item])
            return cell
        }else {
            collectionView.isScrollEnabled = false
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CookFoodCell", for: indexPath) as! CookFoodCell
            cell.configure(with: items[indexPath.item])
            return cell
        }
        
    }
    
    
}

extension CookViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vc: UIViewController
        
        if isFiltering {
            FoodDescriptionConfigure.type = filtredItems[indexPath.item].type
            FoodDescriptionConfigure.choisedName = filtredItems[indexPath.item].name
            vc = FoodDescriptionViewController()
        }else if isFavorite {
            FoodDescriptionConfigure.type = FavoriteFood.items[indexPath.item].type
            FoodDescriptionConfigure.choisedName = FavoriteFood.items[indexPath.item].name
            vc = FoodDescriptionViewController()
        }else {
            FoodDescriptionConfigure.type = items[indexPath.item].type
            vc = FoodViewControllerSet()
        }
        definesPresentationContext = false
        navigationController?.pushViewController(vc, animated: true)
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
