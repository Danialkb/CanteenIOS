//
//  CartTableViewCell.swift
//  CanteenApp
//
//  Created by Apple on 24.12.2024.
//

import UIKit

protocol CanRemoveCellFromTable: AnyObject {
    func removeOrderFromList(orderId: Int)
}


class CartTableViewCell: UITableViewCell {
    static let identifier = "cartTableCell"
    
    @IBOutlet weak var orderName: UILabel!
    
    @IBOutlet weak var orderPrice: UILabel!
    
    @IBOutlet weak var orderFoodImage: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var substractButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    

    @IBOutlet weak var amountLabel: UILabel!
    
    var cartService = CartService()
    var order: Order? = nil
    weak var delegate: CanRemoveCellFromTable?
    
    func configure(order: Order, orderFilterChoice: OrderStatus) {
        orderName.text = order.food.name
        orderPrice.text = "\(order.food.price) тг"
        self.order = order
        let foodImageURL = URL(string: order.food.image)
        orderFoodImage.kf.setImage(with: foodImageURL)
        
        if orderFilterChoice == OrderStatus.waiting {
            deleteButton.isHidden = false
            addButton.isHidden = false
            substractButton.isHidden = false
        } else {
            deleteButton.isHidden = true
            addButton.isHidden = true
            substractButton.isHidden = true
        }
        amountLabel.text = "\(order.amount) шт."
    }

    @IBAction func substractAmount(_ sender: Any) {
        order!.amount -= 1
        if order!.amount <= 0 {
            deleteOrder()
            return
        }
        saveChanges()
    }
    @IBAction func addAmount(_ sender: Any) {
        order!.amount += 1
        saveChanges()
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        deleteOrder()
    }
    
    func deleteOrder() {
        cartService.deleteOrder(orderId: order!.id) {
            error in
            if let error = error {
                print("Error deleting order: \(error)")
            } else {
                self.delegate?.removeOrderFromList(orderId: self.order!.id)
            }
        }
    }
    
    func saveChanges() {
        cartService.saveChanges(orderId: order!.id, orderData: OrderUpdateSchema(amount: order!.amount, special_wishes: order!.special_wishes)) {
            result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                DispatchQueue.main.async {
                    self.amountLabel.text = "\(data.amount) шт."
                }
            }
        }
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
