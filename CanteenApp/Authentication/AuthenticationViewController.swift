//
//  AuthenticationViewController.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    var userService = UserService()
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    
    var isErrorRequest = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        if (!inputsAreValid()) {
            showAlert(title: "Ошибка", message: "Заполните все поля")
            return
        }
        let loginSchema = AuthenticationSchema(email: emailInput.text!, password: passwordInput.text!)
        userService.authenticate(loginData: loginSchema) { [weak self] result in
            switch result {
            case .success(let response):
                self?.isErrorRequest = false
                print("Token: \(response.access)")
                UserDefaults.standard.set(response.access, forKey: "access_token")
                DispatchQueue.main.async {
                    self?.navigateToTabBarController()
                }
            case .failure(let error):
                print(error)
                self?.isErrorRequest = true
                self?.showAlert(title: "Ошибка", message: "Неверная почта или пароль")
            }
        }
    }

    func inputsAreValid() -> Bool {
        let email = emailInput.text ?? ""
        let password = passwordInput.text ?? ""
        return !(email.isEmpty || password.isEmpty)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return inputsAreValid() && !isErrorRequest
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateToTabBarController() {
        if let tabBarController = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            navigationController?.setViewControllers([tabBarController], animated: true)
        }
    }
    
}
