//
//  FoodDescriptionViewController.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 15.10.2023.
//

import UIKit
import SnapKit


class FoodDescriptionViewController: UIViewController {
    
    private var source: FoodItemDescription!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initialize()
        makeConstrains()
        
    }
    
    private enum UIConstants {
        static var imageHeight: CGFloat = 200
        static var imageWidth: CGFloat = Constants.screanWidth
    }
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let enginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "ЭНЕРГЕТИЧЕСКАЯ ЦЕННОСТЬ НА ПОРЦИЮ"
        label.textAlignment = .center
        return label
    }()
    
    private let enginStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "ИНГРЕДИЕНТЫ"
        label.textAlignment = .center
        return label
    }()
    
    private var lastIngredient: UIView!
    
    private let instruction: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "ИНСТРУКЦИЯ ПРИГОТОВЛЕНИЯ"
        label.textAlignment = .center
        return label
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let advice: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "СОВЕТ"
        return label
    }()
    
    private let adviceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private var starButton = UIBarButtonItem()
    private var isFavorit: Bool = false {
        didSet {
            if isFavorit {
                UIView.animate(withDuration: 2) {
                    self.starButton.image = UIImage(systemName: "star.fill")
                    self.starButton.tintColor = .yellow
                }
            }else {
                UIView.animate(withDuration: 2) {
                    self.starButton.image = UIImage(systemName: "star")
                    self.starButton.tintColor = .white
                }
            }
        }
    }
}


private extension FoodDescriptionViewController {
    func initialize() {
        navigationItem.rightBarButtonItems = makeRightBarButtonItem()
        view.backgroundColor = Constants.backColor
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(enginLabel)
        scrollView.addSubview(enginStack)
        scrollView.addSubview(ingredientsLabel)
        scrollView.addSubview(instruction)
        scrollView.addSubview(instructionLabel)
        scrollView.addSubview(advice)
        scrollView.addSubview(adviceLabel)
    }
    
    func makeConstrains() {
        scrollView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(UIConstants.imageHeight)
            make.width.equalTo(UIConstants.imageWidth)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
        
        enginLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
        }
        enginStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(enginLabel.snp.bottom).offset(10)
            make.height.equalTo(70)
        }
        
    
        let kkalStack = makeStack(text: "КАЛОРИЙНОСТЬ", number: source.kkal, desc: "ККАЛ")
        enginStack.addArrangedSubview(kkalStack)
        
        let proteinsStack = makeStack(text: "БЕЛКИ", number: source.proteins, desc: "ГРАММ")
        enginStack.addArrangedSubview(proteinsStack)
        
        let fatsStack = makeStack(text: "ЖИРЫ", number: source.fats, desc: "ГРАММ")
        enginStack.addArrangedSubview(fatsStack)
        
        let carbohydratesStack = makeStack(text: "УГЛЕВОДЫ", number: source.carbohydrates, desc: "ГРАММ")
        enginStack.addArrangedSubview(carbohydratesStack)
        
        ingredientsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(enginStack.snp.bottom).offset(30)
            
        }
        
        
        
        for (key, value) in source.ingredients.enumerated() {
            print(key)
            if key == source.ingredients.count - 1 {
                print("yes")
                lastIngredient = makeIngredient(ingredient: value.key, ingredientNumber: value.value, count: key)
                scrollView.addSubview(lastIngredient)
                
            }else {
                scrollView.addSubview(makeIngredient(ingredient: value.key, ingredientNumber: value.value, count: key))
            }
        }
        
        
        instruction.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(lastIngredient.snp.bottom).offset(30)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(instruction.snp.bottom).offset(10)
        }
        
        advice.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(instructionLabel.snp.bottom).offset(30)
        }
        
        adviceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(advice.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
       
    }
    
    func configure() {
        let type = FoodDescriptionConfigure.type
        let number = FoodDescriptionConfigure.cellNumber
        
        switch type {
        case .breakfast:
            source = breakfastFoodDescription.breakfastItemDescriptions.first(where: { $0.foodItem.name == FoodDescriptionConfigure.choisedName }) ?? breakfastFoodDescription.breakfastItemDescriptions[number]
        case .snacks:
            source = snacksFoodDescription.snacksItemDescriptions.first(where: { $0.foodItem.name == FoodDescriptionConfigure.choisedName }) ?? snacksFoodDescription.snacksItemDescriptions[number]
            
        default:
            break
        }
        title = source.foodItem.name
        imageView.image = source.foodItem.image
        descriptionLabel.text = source.description
        instructionLabel.text = source.instruction
        adviceLabel.text = source.advice
        
        isFavorit = source.isFavorit
        
    }
    
    
    func makeStack(text: String, number: Int, desc: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 9)
        label.textColor = .white
        stack.addArrangedSubview(label)
        
        let numberLabel = UILabel()
        numberLabel.text = "\(number)"
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont.boldSystemFont(ofSize: 20)
        numberLabel.textColor = .white
        stack.addArrangedSubview(numberLabel)
        
        let descLabel = UILabel()
        descLabel.text = desc
        descLabel.textAlignment = .center
        descLabel.font = UIFont.systemFont(ofSize: 9)
        descLabel.textColor = .white
        stack.addArrangedSubview(descLabel)
        
        return stack
    }
    
    
    func makeIngredient(ingredient: String, ingredientNumber: String, count: Int) -> UIView {
        let view = UIView()
        scrollView.addSubview(view)
        
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = ingredient
        view.addSubview(label)
        
       
        
        let numberLabel = UILabel()
        numberLabel.textColor = .white
        numberLabel.font = UIFont.systemFont(ofSize: 18)
        numberLabel.numberOfLines = 0
        numberLabel.text = ingredientNumber
        view.addSubview(numberLabel)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(ingredientsLabel.snp.bottom).offset(25 * (count + 1))
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        numberLabel.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
        }
       
        
        return view
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
    
    @objc func didTapStarBarButtonItem() {
        
        isFavorit = !isFavorit
    }
    
    
}
