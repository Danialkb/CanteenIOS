//
//  AuthModels.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//


struct AuthenticationSchema: Encodable {
    var email: String
    var password: String
}

struct AuthResponse: Decodable {
    let access: String
}
