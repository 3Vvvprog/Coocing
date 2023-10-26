//
//  BreakfastItem.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 14.10.2023.
//

import UIKit

class FoodItem: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding = false
    
    
    
    var name: String
    var image: String
    var numberOfIngredients: String
    var nameOfPortions: String
    var time: String
    var type: TypeOfFood
    
    init(name: String, image: String, numberOfIngredients: String, nameOfPortions: String, time: String, type: TypeOfFood) {
        self.name = name
        self.image = image
        self.numberOfIngredients = numberOfIngredients
        self.nameOfPortions = nameOfPortions
        self.time = time
        self.type = type
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
        coder.encode(numberOfIngredients, forKey: "numberOfIngredients")
        coder.encode(nameOfPortions, forKey: "nameOfPortions")
        coder.encode(time, forKey: "time")
        coder.encode(type, forKey: "type")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
        numberOfIngredients = coder.decodeObject(forKey: "numberOfIngredients") as? String ?? ""
        nameOfPortions = coder.decodeObject(forKey: "nameOfPortions") as? String ?? ""
        time = coder.decodeObject(forKey: "time") as? String ?? ""
        type = TypeOfFood(rawValue: coder.decodeObject(forKey: "type") as! String) ?? .breakfast
    }
    
}


