//
//  Constants.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 13.10.2023.
//

import UIKit

enum Constants {
    static var screanHeight: CGFloat = 0
    static var screanWidth: CGFloat = 0
    static let backColor: UIColor = UIColor(red: 32/255.0, green: 25/255.0, blue: 23/255.0, alpha: 1.000)
}

enum TypeOfFood {
    case breakfast, snacks, salad, meat, soup
}

enum Type {
    static var type: TypeOfFood = .breakfast
}
