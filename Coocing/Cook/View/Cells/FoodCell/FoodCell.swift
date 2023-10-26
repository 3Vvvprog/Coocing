//
//  BreakfastCell.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 14.10.2023.
//

import UIKit
import SnapKit


class FoodCell: UICollectionViewCell {
    
    func configure(with info: FoodItem) {
        imageView.image = UIImage(named: info.image)
        nameLabel.text = info.name
        ingredientsLabel.text = info.numberOfIngredients
        portionsLabel.text = info.nameOfPortions
        timeLabel.text = info.time
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum UIConstants {
        static var cellHeight: CGFloat = 173
        static var cellWidth: CGFloat = Constants.screanWidth
    }
    
    private let imageView = UIImageView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let portionsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
}

private extension FoodCell   {
    func initialize() {
       
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
            make.height.equalTo(173)
            make.width.equalTo(UIConstants.cellWidth)
        }
        
        let rightStack = UIStackView()
        rightStack.axis = .vertical
        rightStack.alignment = .fill
        rightStack.spacing = 10
        rightStack.distribution = .fillEqually
        imageView.addSubview(rightStack)
        
        rightStack.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(10)
        }
        
        rightStack.addArrangedSubview(nameLabel)
        rightStack.addArrangedSubview(ingredientsLabel)
        rightStack.addArrangedSubview(portionsLabel)
        rightStack.addArrangedSubview(timeLabel)
        
        
    }
}
