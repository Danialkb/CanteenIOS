//
//  UserProfileViewController.swift
//  CanteenApp
//
//  Created by Apple on 26.12.2024.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userSurnameLabel: UILabel!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    var userService = UserService()
    
    var user: UserResponse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getUser()
    }
    
    func getUser(){
        userService.getUser( ){
            result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                DispatchQueue.main.async {
                    self.userNameLabel.text = data.first_name
                    self.userSurnameLabel.text = data.last_name
                    self.userEmailLabel.text = data.email
                }
            }
        }
        
    }
}
