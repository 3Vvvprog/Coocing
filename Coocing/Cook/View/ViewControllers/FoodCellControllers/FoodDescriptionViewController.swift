//
//  FoodDescriptionViewController.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 15.10.2023.
//

import UIKit
import SnapKit
import Foundation


class FoodDescriptionViewController: UIViewController {
    
    // MARK: - View Model
    private var viewModel: FoodDescriptionProtocol = FoodDescriptionViewModel()
    private var foodDescription: FoodItemDescription!
    
    // MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initialize()
        makeConstrains()
        
    }
    
    // MARK: - Private constants
    private enum UIConstants {
        static var imageHeight: CGFloat = 200
        static var imageWidth: CGFloat = Constants.screanWidth
    }
    
    // MARK: - Private properties
    private let scrollView = FoodDescriptionScrollView()
    private var starButton = UIBarButtonItem()
    private var isFavorit: Bool = false
}

// MARK: - Private methods
private extension FoodDescriptionViewController {
    func initialize() {
        navigationItem.rightBarButtonItems = makeRightBarButtonItem()
        view.backgroundColor = Constants.backColor
        view.addSubview(scrollView)
    }
    
    func makeConstrains() {
        scrollView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configure() {
        foodDescription = viewModel.getDescription(type: FoodDescriptionConfigure.type)
        title = foodDescription.foodItem.name
        scrollView.configure(foodDescription: foodDescription)
        
        if FavoriteFood.items.contains(where: { $0.name == title! }) {
            isFavorit = true
        }
        
        FoodDescriptionConfigure.choisedName = ""
        
    }
    
    func makeRightBarButtonItem() -> [UIBarButtonItem] {
        if !isFavorit {
            starButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didTapStarBarButtonItem))
        }else {
            starButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(didTapStarBarButtonItem))
            starButton.tintColor = .yellow
        }
        
        return [starButton]
    }
        
    // MARK: - Star button action
    @objc func didTapStarBarButtonItem() {
        if !isFavorit {
            UIView.animate(withDuration: 2) {
                self.starButton.image = UIImage(systemName: "star.fill")
                self.starButton.tintColor = .yellow
                FavoriteFood.items.append(allFoodDescription.allItems.first(where: { $0.name == self.title! })!)
            }
        }else {
            UIView.animate(withDuration: 2) {
                self.starButton.image = UIImage(systemName: "star")
                self.starButton.tintColor = .white
                FavoriteFood.items.removeAll(where: { $0.name == self.title! })
            }
        }
        
        isFavorit = !isFavorit
    }
}
