//
//  CartViewController.swift
//  CanteenApp
//
//  Created by Apple on 24.12.2024.
//

import Foundation
import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CanRemoveCellFromTable {
    
    
    @IBOutlet weak var sendOrdersBitton: UIButton!
    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var makeOrderButton: UIButton!
    @IBOutlet weak var activeOrdersButton: UIButton!
    var orderList: [Order] = []
    var cartService = CartService()
    var orderFilterChoice: OrderStatus = OrderStatus.waiting
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.dataSource = self
        cartTableView.delegate = self
        cartTableView.register(CartTableViewCell.nib(), forCellReuseIdentifier: CartTableViewCell.identifier)
        loadCart()
        
//        makeOrderButton.titleLabel?.textColor = UIColor.systemOrange
        
        makeOrderButton.setTitleColor(UIColor.systemOrange, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCart()
    }
    
    @IBAction func sendOrders(_ sender: Any) {
        cartService.sendOrders {
            error in
            if let error = error {
                print("Error sending orders: \(error)")
            } else {
                self.loadCart()
            }
        }
    }
    @IBAction func getWaitingOrders(_ sender: Any) {
        orderFilterChoice = OrderStatus.waiting
        loadCart()
        sendOrdersBitton.isHidden = false
        
        activeOrdersButton.titleLabel?.textColor = UIColor.black
        
    }
    
    @IBAction func getActiveOrders(_ sender: Any) {
        orderFilterChoice = OrderStatus.processing
        loadCart()
        sendOrdersBitton.isHidden = true
        
//        activeOrdersButton.titleLabel?.textColor = UIColor.red
        makeOrderButton.titleLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        cell.delegate = self
        let order = orderList[indexPath.row]
        
        cell.configure(order: order, orderFilterChoice: orderFilterChoice)
        
        return cell
    }
    
    func removeOrderFromList(orderId: Int) {
        print("removing order")
        loadCart()
    }
    
    func loadCart() {
        cartService.getCart(orderStatus: orderFilterChoice) {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.orderList = response
                    self?.cartTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
         }
    }
    
    func updateButtonStates(activeButton: UIButton, inactiveButton: UIButton) {
        activeButton.setTitleColor(.systemOrange, for: .normal)
        inactiveButton.setTitleColor(.black, for: .normal)
    }
}

