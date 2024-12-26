//
//  FoodDetailsViewController.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//

import UIKit

class FoodDetailsViewController: UIViewController {
    var food: Food!
        
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodDescription: UILabel!
    
    var foodId: String = ""
    var cartService = CartService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let foodImageURL = URL(string: food.image)
        foodImage.kf.setImage(with: foodImageURL)
        foodPriceLabel.text = "\(food.price) тг"
        foodDescription.text = food.description
        foodId = food.id
    }
    
    @IBAction func addToCart(_ sender: Any) {
        let orderSchema = OrderSchema(food: foodId, amount: 1, special_wishes: "")
        cartService.addToCart(orderData: orderSchema){
            result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(_):
                print("succes")
            }
        }
    }
    
}

