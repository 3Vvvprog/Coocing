//
//  FoodItemDescription.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 15.10.2023.
//

import UIKit

struct FoodItemDescription {
    var foodItem: FoodItem
    var description: String
    var kkal: Int
    var proteins: Int // Белки
    var fats: Int //Жиры
    var carbohydrates: Int //Углеводы
    var ingredients: [String: String]
    var instruction: String
    var advice: String // Совет
}
