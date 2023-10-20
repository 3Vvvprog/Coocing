//
//  CustomSearchController.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 19.10.2023.
//

import UIKit

class CustomSearchController: UISearchController {
    
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var customSearchBar = UISearchBar(frame: .zero)
    
    override var searchBar: UISearchBar { customSearchBar }
    
    
}

private extension CustomSearchController {
    func initialize() {
        view.addSubview(customSearchBar)
        
        customSearchBar.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(Constants.screanWidth - 30)
            make.bottomMargin.equalTo(5)
        }
    }
}
