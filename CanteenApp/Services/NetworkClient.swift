//
//  NetworkClient.swift
//  CanteenApp
//
//  Created by мак on 03.12.2024.
//
import Alamofire

class NetworkClient {
    
    func request<T: Decodable>(
        urlString: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        AF.request(urlString, method: method, parameters: parameters, encoding: encoding, headers: headers).responseDecodable(of: responseType) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
