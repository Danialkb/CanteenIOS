//
//  CartViewController.swift
//  CanteenApp
//
//  Created by Apple on 24.12.2024.
//

import Foundation
import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var cartTableView: UITableView!
    
    var orderList: [Order] = []
    var cartService = CartService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.dataSource = self
        cartTableView.delegate = self
        cartTableView.register(CartTableViewCell.nib(), forCellReuseIdentifier: CartTableViewCell.identifier)
        loadCart()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        let order = orderList[indexPath.row]
        
        cell.configure(order: order)
        
        return cell
    }

    
    func loadCart() {
        cartService.getCart() {
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

}

