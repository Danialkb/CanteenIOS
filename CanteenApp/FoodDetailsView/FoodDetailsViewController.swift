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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let foodImageURL = URL(string: food.image)
        foodImage.kf.setImage(with: foodImageURL)
        foodPriceLabel.text = "\(food.price) тг"
        foodDescription.text = food.description
    }

}

