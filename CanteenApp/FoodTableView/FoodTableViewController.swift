//
//  FoodTableViewController.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//

import UIKit

class FoodTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var foodListTableView: UITableView!
    @IBOutlet weak var searchInput: UITextField!
    
    var foodList: [Food] = []
    var foodService = FoodService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodListTableView.dataSource = self
        foodListTableView.delegate = self
        foodListTableView.register(FoodTableViewCell.nib(), forCellReuseIdentifier: FoodTableViewCell.identifier)
        loadMenu()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.identifier, for: indexPath) as! FoodTableViewCell
        let food = foodList[indexPath.row]
        
        cell.configure(food: food)
        
        return cell
    }
    @IBAction func searchByName(_ sender: UIButton){
        loadMenu()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "foodDetails", sender: foodList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? FoodDetailsViewController {
            if let selectedFood = sender as? Food {
                detailsViewController.food = selectedFood
                detailsViewController.navigationItem.title = selectedFood.name
            }
        }
    }
    
    func loadMenu() {
        foodService.getMenu(search: searchInput.text ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.foodList = response
                    self?.foodListTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
         }
    }

}
