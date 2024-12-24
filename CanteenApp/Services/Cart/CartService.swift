
import Alamofire

/// In some cases, you might want a small struct to handle empty responses from the server.
struct EmptyResponse: Decodable {}

class CartService {
    private let networkClient = NetworkClient() // your custom class
    private let endpoint = "http://localhost:8000/api/v1/order"
    
   
    func getCart (completion: @escaping(Result<[Order], AFError>) -> Void){
//        var finalHeaders = HTTPHeaders()
//            
//        if let token = UserDefaults.standard.string(forKey: "authToken") {
//            finalHeaders.add(name: "Authorization", value: "Bearer \(token)")
//        }
        networkClient.request(
            urlString: "\(endpoint)/my_orders/",
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil,
            responseType: [Order].self
        ) { result in
            completion(result)
        }

    }
    
    func addToCart(orderData: OrderSchema, completion: @escaping(Result <OrderCreatedResponse, AFError>)-> Void){
        do {
            let parameters = try orderData.asDictionary()
            print(parameters)
            
            networkClient.request(
                urlString: "\(endpoint)/",
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: nil,
                responseType: OrderCreatedResponse.self
            ) { result in
                completion(result)
            }
        } catch {
            completion(.failure(AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))))
        }
    }
}
