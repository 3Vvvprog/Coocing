//
//  CookViewController.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 13.10.2023.
//

import UIKit
import SnapKit

class CookViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.screanWidth = view.frame.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        Constants.screanHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        initialize()
        makeConstraints()
       
    }
    
    private var items: [CookTypeFood] = [
        CookTypeFood(backgroundImage: UIImage(named: "BreakfastBack")!, logo: UIImage(named: "BreakfastLogo")!, nameOfTypeFood: "Завтраки"),
        CookTypeFood(backgroundImage: UIImage(named: "snacksBack")!, logo: UIImage(named: "snacksLogo")!, nameOfTypeFood: "Закуски"),
        CookTypeFood(backgroundImage: UIImage(named: "saladBack")!, logo: UIImage(named: "saladLogo")!, nameOfTypeFood: "Салаты"),
        CookTypeFood(backgroundImage: UIImage(named: "meatBack")!, logo: UIImage(named: "meatLogo")!, nameOfTypeFood: "Вторые блюда"),
        CookTypeFood(backgroundImage: UIImage(named: "soupBack")!, logo: UIImage(named: "soupLogo")!, nameOfTypeFood: "Cупы"),
    ]
    // private constants
    private enum UIConstants {
        
    }
    
    // Private properties

    private var collectionView: UICollectionView!
}

private extension CookViewController {
    func initialize() {
        view.backgroundColor = Constants.backColor
        navigationController?.navigationBar.barStyle = .black
        navigationItem.rightBarButtonItems = makeRightBarButtonItem()
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
        view.addSubview(collectionView)
        
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func makeRightBarButtonItem() -> [UIBarButtonItem] {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(didTapSearchBarButton))
        
        return [searchButton]
    }
    
    @objc func didTapSearchBarButton() {
        print("Search")
    }
}


extension CookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CookFoodCell", for: indexPath) as! CookFoodCell
        cell.configure(with: items[indexPath.item])
        return cell
    }
    
    
}

extension CookViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vc: UIViewController
        
        switch indexPath.item {
        case 0:
            Type.type = .breakfast
        case 1:
            Type.type = .snacks
        case 2:
            Type.type = .salad
        case 3:
            Type.type = .meat
        case 4:
            Type.type = .soup
        default:
            break
        }
        vc = FoodViewControllerSet()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
