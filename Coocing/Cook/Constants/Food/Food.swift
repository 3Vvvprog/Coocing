//
//  Food.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 15.10.2023.
//

import UIKit


enum TypeOfFood: String {
    case breakfast
    case snacks
    case salad
    case meat
    case soup
}

struct TypeOfFoodStruct {
    static var items: [CookTypeFood] = [
        CookTypeFood(backgroundImage: UIImage(named: "BreakfastBack")!, logo: UIImage(named: "BreakfastLogo")!, nameOfTypeFood: "Завтраки", type: .breakfast),
        CookTypeFood(backgroundImage: UIImage(named: "snacksBack")!, logo: UIImage(named: "snacksLogo")!, nameOfTypeFood: "Закуски", type: .snacks),
        CookTypeFood(backgroundImage: UIImage(named: "saladBack")!, logo: UIImage(named: "saladLogo")!, nameOfTypeFood: "Салаты", type: .salad),
        CookTypeFood(backgroundImage: UIImage(named: "meatBack")!, logo: UIImage(named: "meatLogo")!, nameOfTypeFood: "Вторые блюда", type: .meat),
        CookTypeFood(backgroundImage: UIImage(named: "soupBack")!, logo: UIImage(named: "soupLogo")!, nameOfTypeFood: "Cупы", type: .soup),
    ]
}

struct FavoriteFood {
    static var items: [String] = []
}

struct Food {
    
    static var breakfastItems: [FoodItem] = [
        FoodItem(name: "Брауни", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .breakfast),
        FoodItem(name: "Сырники из творога", image: "сырники", numberOfIngredients: "5 ингридиентов", nameOfPortions: "2 порции", time: "30 минут", type: .breakfast),
        FoodItem(name: "Яйца-крэмбл", image: "Яйца-крэмбл", numberOfIngredients: "6 ингридиентов", nameOfPortions: "2 порции", time: "5 минут", type: .breakfast),
        FoodItem(name: "Завтрак приморский", image: "завтракПриморский", numberOfIngredients: "11 ингридиентов", nameOfPortions: "1 порция", time: "30 минут", type: .breakfast),
    ]
    
    static var snacksItems: [FoodItem] = [
        FoodItem(name: "Брауни", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .snacks),
        FoodItem(name: "Брауни", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .snacks),
        FoodItem(name: "Брауни", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .snacks),
        FoodItem(name: "Брауни", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .snacks),
    ]
    
    static var saladItems: [FoodItem] = [
        FoodItem(name: "salad", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .salad),
        FoodItem(name: "salad", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .salad),
        FoodItem(name: "salad", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .salad),
        
    ]
    
    static var meatItems: [FoodItem] = [
        FoodItem(name: "meat", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .meat),
        FoodItem(name: "meat", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .meat),
        FoodItem(name: "meat", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .meat),
        
    ]
    
    static var soupItems: [FoodItem] = [
        FoodItem(name: "soup", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .soup),
        FoodItem(name: "soup", image: "брауни", numberOfIngredients: "6 ингридиентов", nameOfPortions: "6 порций", time: "40 минут", type: .soup),
        
        
    ]
}
