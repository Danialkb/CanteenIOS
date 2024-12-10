//
//  FoodModels.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//


struct Food: Decodable {
    let id: String
    let name: String
    let description: String
    let price: Int
    let image: String
}
