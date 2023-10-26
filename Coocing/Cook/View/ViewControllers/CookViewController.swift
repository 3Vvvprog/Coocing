//
//  CookViewController.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 13.10.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxRelay

class CookViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let userDefaults = FoodUserDefaults()
    
    func reloadView() {
        collectionView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.screanWidth = view.frame.width
        initialize()
    }
    
    override func viewDidLayoutSubviews() {
        Constants.screanHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        filterContentForFavoriteItems()
    }
    
    private var items: [CookTypeFood] = TypeOfFoodStruct.items
    
    
    private var filtredItems = [FoodItem]()
    private var favoriteItems = [FoodItem]()
    
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
            make.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        starButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didTapStarBarButton))
        
        
        return [starButton]
    }
    
    
    
    
    @objc func didTapStarBarButton() {
        
        if !isFavorite {
            searchController.searchBar.text = ""
            searchController.isActive = false
            filterContentForFavoriteItems()
            starButton.image = UIImage(systemName: "star.fill")
            starButton.tintColor = .yellow
        }else {
            searchController.isActive = false
            collectionView.reloadData()
            starButton.image = UIImage(systemName: "star")
            starButton.tintColor = .white
        }
        
        isFavorite = !isFavorite
        
        
    }
    
    private func filterContentForFavoriteItems() {
        
        favoriteItems = userDefaults.getFavoriteFood()
        collectionView.reloadData()
        
    }
}


extension CookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filtredItems.count
        }else if isFavorite {
            return favoriteItems.count
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
            cell.configure(with: favoriteItems[indexPath.item])
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
            FoodDescriptionConfigure.type = favoriteItems[indexPath.item].type
            FoodDescriptionConfigure.choisedName = favoriteItems[indexPath.item].name
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
