//
//  FavoriteFoodProtocol.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 26.10.2023.
//

import Foundation

protocol FavoriteFoodProtocol {
    func getFavoriteFood() -> [FoodItem]
    func setFavoriteFood(item: String)
    func removeFavoriteFood(item: String)
}
