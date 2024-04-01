//
//  DishModel.swift
//  MyRestaurant
//
//  Created by Vinayak Bora on 01/04/24.
//

import Foundation

struct DishResponse: Codable {
    let data: [Dish]?
    let message: String?
    let status: String?
}

struct Dish: Codable, Identifiable {
    let id = UUID()
    let name: String?
    let price: Int?
    let ingredients: String?
    let tag: String?
    let prepTime: String?
    let imageUrl: String?
}
