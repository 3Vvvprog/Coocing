//
//  FoodDescriptionScrollView.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 23.10.2023.
//

import UIKit
import SnapKit

class FoodDescriptionScrollView: UIScrollView {
    
    private var foodDescription: FoodItemDescription!
    func configure(foodDescription: FoodItemDescription) {
        self.foodDescription = foodDescription
        
        initialize()
        makeConstraintes()
        
        imageView.image = UIImage(named: foodDescription.foodItem.image)
        descriptionLabel.text = foodDescription.description
        instructionLabel.text = foodDescription.instruction
        adviceLabel.text = foodDescription.advice
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    
    
    private enum UIConstants {
        static var imageHeight: CGFloat = 200
        static var imageWidth: CGFloat = Constants.screanWidth
    }
}

private extension FoodDescriptionScrollView {
    func initialize() {
        addSubview(imageView)
        addSubview(descriptionLabel)
        addSubview(enginLabel)
        addSubview(enginStack)
        addSubview(ingredientsLabel)
        addSubview(instruction)
        addSubview(instructionLabel)
        addSubview(advice)
        addSubview(adviceLabel)
    }
    
    func makeConstraintes() {
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
        
        makeEngineStack(foodDescription: foodDescription)
        
        for (key, value) in foodDescription.ingredients.enumerated() {
            if key == foodDescription.ingredients.count - 1 {
                lastIngredient = makeIngredient(ingredient: value.key, ingredientNumber: value.value, count: key)
                addSubview(lastIngredient)
                
            }else {
                addSubview(makeIngredient(ingredient: value.key, ingredientNumber: value.value, count: key))
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
    
    
    
}

private extension FoodDescriptionScrollView {
    func makeEngineStack(foodDescription: FoodItemDescription) {
        let kkalStack = makeStack(text: "КАЛОРИЙНОСТЬ", number: foodDescription.kkal, desc: "ККАЛ")
        enginStack.addArrangedSubview(kkalStack)
        
        let proteinsStack = makeStack(text: "БЕЛКИ", number: foodDescription.proteins, desc: "ГРАММ")
        enginStack.addArrangedSubview(proteinsStack)
        
        let fatsStack = makeStack(text: "ЖИРЫ", number: foodDescription.fats, desc: "ГРАММ")
        enginStack.addArrangedSubview(fatsStack)
        
        let carbohydratesStack = makeStack(text: "УГЛЕВОДЫ", number: foodDescription.carbohydrates, desc: "ГРАММ")
        enginStack.addArrangedSubview(carbohydratesStack)
        
        ingredientsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(enginStack.snp.bottom).offset(30)
            
        }
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
        addSubview(view)
        
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
}
