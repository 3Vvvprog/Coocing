//
//  CookFoodCell.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 13.10.2023.
//

import UIKit
import SnapKit

class CookFoodCell: UICollectionViewCell {
    
    // Public
    func configure(with info: CookTypeFood) {
        initialize()
        makeConstraints()
        backImageView.image = info.backgroundImage
        logoimageView.image = info.logo
        label.text = info.nameOfTypeFood
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum UIConstants {
        static var cellHeight: CGFloat = (Constants.screanHeight) / 5
        static var cellWidth: CGFloat = Constants.screanWidth
    }
    
    // Private properties
    private var backImageView = UIImageView()
    private var logoimageView = UIImageView()
    private var label = UILabel()
    
}

private extension CookFoodCell {
    func initialize() {
        contentView.addSubview(backImageView)
        let stack = UIStackView()
        stack.axis = .vertical
        backImageView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.height.width.centerX.centerY.equalToSuperview()
            
        }
        
        stack.addSubview(logoimageView)
        stack.addSubview(label)
        
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
    }
    
    func makeConstraints() {
        backImageView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
            make.height.equalTo(UIConstants.cellHeight)
            make.width.equalTo(UIConstants.cellWidth)
        }
        
        logoimageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(70)
            
        }
        
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(logoimageView.snp.bottom)
        }
    }
}
