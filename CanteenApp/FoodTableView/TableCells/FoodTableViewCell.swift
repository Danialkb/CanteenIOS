//
//  FoodTableViewCell.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//

import UIKit
import Kingfisher

class FoodTableViewCell: UITableViewCell {
    static let identifier = "foodTableCell"
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var cartService = CartService()
    var foodId: String = ""
    
    func configure(food: Food) {
        nameLabel.text = food.name
        priceLabel.text = "\(food.price) тг"
        let foodImageURL = URL(string: food.image)
        foodImage.kf.setImage(with: foodImageURL)
        foodId = food.id
    }

    @IBAction func addToCart(_ sender: UIButton) {
        let orderSchema = OrderSchema(food: foodId, amount: 1, special_wishes: "")
        cartService.addToCart(orderData: orderSchema)
        {
            result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(_):
                print("succes")
            }
        }
//        do {
//            print(try orderSchema.asDictionary())
//        }catch{
//            print("")
//        }
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FoodTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
