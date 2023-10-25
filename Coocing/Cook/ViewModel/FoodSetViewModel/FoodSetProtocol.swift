//
//  FoodSetProtocol.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 23.10.2023.
//

import UIKit

protocol FoodSetProtocol {
    func getAllItems(type: TypeOfFood) -> [FoodItem]
}
