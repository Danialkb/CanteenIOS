//
//  UserModels.swift
//  CanteenApp
//
//  Created by Apple on 26.12.2024.
//

struct UserSchema: Decodable {
    var user_id: Int
    var first_name: String
    var second_name: String
    var email: String
    var user_type: String
}
