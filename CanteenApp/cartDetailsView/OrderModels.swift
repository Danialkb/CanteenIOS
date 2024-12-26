//
//  OrderModels.swift
//  CanteenApp
//
//  Created by Apple on 24.12.2024.
//

import Foundation

enum OrderStatus: String, Decodable {
    case waiting = "Waiting"
    case processing = "Processing"
}

struct Order: Decodable {
    let id: Int
    var food: Food
    var special_wishes: String
    var amount: Int
    var status: OrderStatus
    var order_identifier: Int
}


struct OrderSchema: Encodable {
    let food: String
    let amount: Int
    let special_wishes: String
}

struct OrderUpdateSchema: Encodable {
    let amount: Int
    let special_wishes: String
}

struct OrderUpdateResponse: Decodable {
    var special_wishes: String
    var amount: Int
}


struct OrderCreatedResponse: Decodable {
    var food: String
    var amount: Int
    var special_wishes: String
}


