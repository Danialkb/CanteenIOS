//
//  Encodable.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        guard let dictionary = json as? [String: Any] else {
            throw NSError(domain: "Invalid format", code: 0, userInfo: nil)
        }
        return dictionary
    }
}
