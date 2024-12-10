//
//  FoodService.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//


import Alamofire

class FoodService {
    let networkClient = NetworkClient()
    let endpoint = "http://localhost:8000/api/v1/food/"
    
    func getMenu(search: String, completion: @escaping (Result<[Food], AFError>) -> Void) {
        var parameters: [String: Any]? = nil
        if (search != "") {
            parameters = ["search": search]
        }
        networkClient.request(
            urlString: endpoint,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: nil,
            responseType: [Food].self
        ) { result in
            completion(result)
        }
    }
}
