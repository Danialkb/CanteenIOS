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
    
    func configure(food: Food) {
        nameLabel.text = food.name
        priceLabel.text = "\(food.price) тг"
        let foodImageURL = URL(string: food.image)
        foodImage.kf.setImage(with: foodImageURL)
    }

    @IBAction func addToCart(_ sender: UIButton) {
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
