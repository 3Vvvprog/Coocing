//
//  FoodDescriptionProtocol.swift
//  Coocing
//
//  Created by Вячеслав Вовк on 23.10.2023.
//

import UIKit

protocol FoodDescriptionProtocol {
    func getDescription(type: TypeOfFood) -> FoodItemDescription
}
