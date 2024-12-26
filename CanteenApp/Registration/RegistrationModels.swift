//
//  Models.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//


struct RegistrationSchema: Encodable {
    var first_name: String
    var last_name: String
    var email: String
    var password: String
}

struct RegistrationConfirmSchema: Encodable {
    var session_id: String
    var code: String
}

struct RegistrationResponse: Decodable {
    let session_id: String
}

struct UserResponse: Decodable {
    let id: Int
    let first_name: String
    let last_name: String
    let email: String
}



