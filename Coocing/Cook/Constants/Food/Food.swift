//
//  Food.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 15.10.2023.
//

import UIKit


struct FavoriteFood {
    static var items: [FoodItem] = []
}


struct Food {
    
    static var favorit: [String] = ["Сырники из творога", "Завтрак приморский" ]
    
    static var breakfastItems: [FoodItem] = [
        FoodItem(name: "Брауни", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .breakfast),
        FoodItem(name: "Сырники из творога", image: UIImage(named: "сырники")!, numberOfIngredients: "5 ингридиентов", nameOfPortions: "2 порции", time: "30 минут", type: .breakfast),
        FoodItem(name: "Яйца-крэмбл", image: UIImage(named: "Яйца-крэмбл")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "2 порции", time: "5 минут", type: .breakfast),
        FoodItem(name: "Завтрак приморский", image: UIImage(named: "завтракПриморский")!, numberOfIngredients: "11 ингридиентов", nameOfPortions: "1 порция", time: "30 минут", type: .breakfast),
    ]
    
    static var snacksItems: [FoodItem] = [
        FoodItem(name: "Брауни", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .snacks),
        FoodItem(name: "Брауни", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .snacks),
        FoodItem(name: "Брауни", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .snacks),
        FoodItem(name: "Брауни", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .snacks),
    ]
    
    static var saladItems: [FoodItem] = [
        FoodItem(name: "salad", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .salad),
        FoodItem(name: "salad", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .salad),
        FoodItem(name: "salad", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .salad),
        
    ]
    
    static var meatItems: [FoodItem] = [
        FoodItem(name: "meat", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .meat),
        FoodItem(name: "meat", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .meat),
        FoodItem(name: "meat", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .meat),
        
    ]
    
    static var soupItems: [FoodItem] = [
        FoodItem(name: "soup", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .soup),
        FoodItem(name: "soup", image: UIImage(named: "брауни")!, numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .soup),
        
        
    ]
}
