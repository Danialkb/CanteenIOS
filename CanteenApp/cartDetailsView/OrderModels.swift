//
//  OrderModels.swift
//  CanteenApp
//
//  Created by Apple on 24.12.2024.
//

import Foundation

enum OrderStatus: String, Decodable {
    case waiting = "Waiting"
    case accepted = "Accepted"
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

struct OrderCreatedResponse: Decodable {
//    var food: String
//    var amount: Int
//    var special_wishes: String
}


