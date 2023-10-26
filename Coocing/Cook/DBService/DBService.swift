//
//  DBService.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 23.10.2023.
//

import Foundation


final class FoodUserDefaults: FavoriteFoodProtocol {
    private enum SettingsKey: String {
        case favoriteFood
    }
    
    private func getFood() -> [String] {
        let favoriteFood = UserDefaults.standard.stringArray(forKey: SettingsKey.favoriteFood.rawValue)
        return favoriteFood ?? []
    }
    
    func getFavoriteFood() -> [FoodItem] {
        let favoriteFood = UserDefaults.standard.stringArray(forKey: SettingsKey.favoriteFood.rawValue) ?? []
        var result = [FoodItem]()
        
        favoriteFood.forEach({ item in
            result.append(allFoodDescription.allItems.first(where: { $0.name == item })!)
        })
        
        return result
    }
    
    func setFavoriteFood(item: String) {
        let defaults = UserDefaults.standard
        let key = SettingsKey.favoriteFood.rawValue
        var favFood = getFood()
        if !favFood.contains(item) {
            favFood.append(item)
            defaults.set(favFood, forKey: key)
        }
    }
    func removeFavoriteFood(item: String) {
        let defaults = UserDefaults.standard
        let key = SettingsKey.favoriteFood.rawValue
        var favFood = getFood()
        if favFood.contains(item) {
            favFood.removeAll(where: { $0 == item })
            defaults.set(favFood, forKey: key)
        }
    }
        
        
    
    
    
}
