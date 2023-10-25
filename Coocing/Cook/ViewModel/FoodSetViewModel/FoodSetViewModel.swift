//
//  FoodSetViewModel.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 23.10.2023.
//

import Foundation


class FoodSetViewModel {
    
}

extension FoodSetViewModel: FoodSetProtocol {
    func getAllItems(type: TypeOfFood) -> [FoodItem] {
        switch type {
        case .breakfast:
            return Food.breakfastItems
        case .snacks:
            return Food.snacksItems
        case .salad:
            return Food.saladItems
        case .meat:
            return Food.meatItems
        case .soup:
            return Food.soupItems
        }
    }
}
