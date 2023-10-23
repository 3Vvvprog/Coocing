//
//  FoodDescription.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 15.10.2023.
//

import Foundation
import UIKit

struct FoodDescriptionConfigure {
    static var type: TypeOfFood = FoodDescriptionConfigure.type
    static var choisedName: String = ""
}

struct allFoodDescription {
    
    static var allItems: [FoodItem] = Food.breakfastItems + Food.snacksItems + Food.saladItems + Food.meatItems + Food.soupItems
}
