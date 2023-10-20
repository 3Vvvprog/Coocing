//
//  SearchView.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 18.10.2023.
//

import UIKit
import SnapKit


class SearchView: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialize()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var searchBar = UISearchBar()
}

private extension SearchView {
    func initialize() {
        addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(Constants.screanWidth - 30)
            make.bottomMargin.equalTo(5)
        }
    }
}

