//
//  CartTableViewCell.swift
//  CanteenApp
//
//  Created by Apple on 24.12.2024.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    static let identifier = "cartTableCell"
    
    @IBOutlet weak var orderName: UILabel!
    
    @IBOutlet weak var orderPrice: UILabel!
    
    func configure(order: Order) {
        orderName.text = order.food.name
        orderPrice.text = "\(order.food.price) тг"
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: "CartTableViewCell", bundle: nil)
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
