//
//  FoodDescriptionViewModel.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 23.10.2023.
//

import Foundation


class FoodDescriptionViewModel {
    
}


extension FoodDescriptionViewModel: FoodDescriptionProtocol {
    func getDescription(type: TypeOfFood) -> FoodItemDescription {
        var foodDescription: FoodItemDescription!
        var items: [FoodItemDescription]!
        
        switch type {
        case .breakfast:
            items = breakfastFoodDescription.breakfastItemDescriptions
        case .snacks:
            items = snacksFoodDescription.snacksItemDescriptions
        case .salad:
            items = saladFoodDescription.saladItemDescriptions
        case .meat:
            items = meatFoodDescription.meatItemDescriptions
        case .soup:
            items = soupFoodDescription.soupItemDescriptions
        }
        
        foodDescription = items.first(where: { $0.foodItem.name == FoodDescriptionConfigure.choisedName })
        
        return foodDescription
    }
    
    
}
