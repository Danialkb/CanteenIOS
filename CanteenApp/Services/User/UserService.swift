//
//  UserService.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//

import Alamofire

class UserService {
    let networkClient = NetworkClient()
    let endpoint = "http://localhost:8000/api/v1/users/"
    
    func sendRegisterRequest(registrationData: RegistrationSchema, completion: @escaping (Result<RegistrationResponse, AFError>) -> Void) {
        do {
            let parameters = try registrationData.asDictionary()
            
            networkClient.request(
                urlString: endpoint,
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: nil,
                responseType: RegistrationResponse.self
            ) { result in
                completion(result)
            }
            
        } catch {
            completion(.failure(AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))))
        }
    }
    
    func confirmRegister(registrationConfirmData: RegistrationConfirmSchema, completion: @escaping (Result<UserResponse, AFError>) -> Void) {
        do {
            let parameters = try registrationConfirmData.asDictionary()
            
            networkClient.request(
                urlString: "\(endpoint)verify/",
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: nil,
                responseType: UserResponse.self
            ) { result in
                completion(result)
            }
            
        } catch {
            completion(.failure(AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))))
        }
    }
    
    func authenticate(loginData: AuthenticationSchema, completion: @escaping (Result<AuthResponse, AFError>) -> Void) {
        do {
            let parameters = try loginData.asDictionary()
            
            networkClient.request(
                urlString: "\(endpoint)token/",
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: nil,
                responseType: AuthResponse.self
            ) { result in
                completion(result)
            }
            
        } catch {
            completion(.failure(AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))))
        }
    }
    
    
    func getUser(completion: @escaping (Result<UserResponse, AFError>) -> Void) {
        networkClient.request(
            urlString: "\(endpoint)user/",
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil,
            responseType: UserResponse.self
        ) { result in
            completion(result)
        }
    }

}
