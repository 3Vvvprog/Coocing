//
//  FoodViewControllerSet.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 14.10.2023.
//

import UIKit
import SnapKit

class FoodViewControllerSet: UIViewController {
    
    
    override func viewDidLoad() {
        view.backgroundColor = Constants.backColor
        title = "Завтраки"
        navigationItem.leftBarButtonItems = makeLeftTabBarButton()
        navigationItem.rightBarButtonItems = makeRightBarButtonItem()
        
        initialize()
        makeConstraints()
    }
    
    
    
    deinit {
        print("Deinit")
    }
    
    var breakfastItems: [FoodItem] = [
        FoodItem(name: "Брауни", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        FoodItem(name: "Брауни", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        FoodItem(name: "Брауни", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        FoodItem(name: "Брауни", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
    ]
    
    var snacksItems: [FoodItem] = [
        FoodItem(name: "Snack", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        FoodItem(name: "Snack", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        FoodItem(name: "Snack", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        FoodItem(name: "Snack", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
    ]
    
    var saladItems: [FoodItem] = [
        FoodItem(name: "salad", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        FoodItem(name: "salad", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        FoodItem(name: "salad", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        
    ]
    
    var meatItems: [FoodItem] = [
        FoodItem(name: "meat", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        FoodItem(name: "meat", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        FoodItem(name: "meat", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут"),
        
    ]
    
    
    
    // private properties
    private var collectionView: UICollectionView!
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
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: "FoodCell")
        view.addSubview(collectionView)
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
        
        switch Type.type {
        case .breakfast:
            return breakfastItems.count
        case .snacks:
            return snacksItems.count
        case .salad:
            return saladItems.count
        case .meat:
            return meatItems.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch Type.type {
        case .breakfast:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            
            cell.configure(with: breakfastItems[indexPath.item])
            return cell
        case .snacks:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            
            cell.configure(with: snacksItems[indexPath.item])
            return cell
        case .salad:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            
            cell.configure(with: saladItems[indexPath.item])
            return cell
        case .meat:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            
            cell.configure(with: meatItems[indexPath.item])
            return cell
        }
    }
    
    
}
