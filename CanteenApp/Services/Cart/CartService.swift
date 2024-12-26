
import Alamofire

/// In some cases, you might want a small struct to handle empty responses from the server.
struct EmptyResponse: Decodable {}

class CartService {
    private let networkClient = NetworkClient() // your custom class
    private let endpoint = "http://localhost:8000/api/v1/order"
    
   
    func getCart (orderStatus: OrderStatus ,completion: @escaping(Result<[Order], AFError>) -> Void){
        var cartGetEndpoint = ""
        if(orderStatus == OrderStatus.waiting) {
            cartGetEndpoint = "\(endpoint)/my_orders/"
        } else {
            cartGetEndpoint = "\(endpoint)/get_active_orders/"
        }
        networkClient.request(
            urlString: cartGetEndpoint,
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
    
    func saveChanges(orderId: Int, orderData: OrderUpdateSchema, completion: @escaping (Result<OrderUpdateResponse, AFError>) -> Void) {
        do {
            let parameters = try orderData.asDictionary()
            
            networkClient.request(
                urlString: "\(endpoint)/\(orderId)/",
                method: .put,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: nil,
                responseType: OrderUpdateResponse.self
            ) { result in
                completion(result)
            }
        } catch {
            completion(.failure(AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))))
        }
    }
    
    func deleteOrder (orderId: Int, completion: @escaping (AFError?) -> Void){
        var headers = HTTPHeaders()
            
        if let token = UserDefaults.standard.string(forKey: "access_token") {
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }
        
        AF.request("\(endpoint)/\(orderId)/", method: .delete, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }

    }
    
    func sendOrders(completion: @escaping (AFError?) -> Void){
        var headers = HTTPHeaders()
            
        if let token = UserDefaults.standard.string(forKey: "access_token") {
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }
        
        AF.request("\(endpoint)/send_user_orders/", method: .get, encoding: URLEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
