//
//  RegistrationViewController.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//

import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var surnameInput: UITextField!
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func register(_ sender: UIButton) {
        if (!inputsAreValid()) {
            showAlert(title: "Ошибка", message: "Заполните все поля")
            return
        }
        let registrationSchema = RegistrationSchema(first_name: nameInput.text!, last_name: surnameInput.text!, email: emailInput.text!, password: passwordInput.text!)
        userService.sendRegisterRequest(registrationData: registrationSchema) { [weak self] result in
            switch result {
            case .success(let response):
                UserDefaults.standard.set(response.session_id, forKey: "session_id")
                self?.performSegue(withIdentifier: "confirmSegue", sender: nil)
            case .failure(let error):
                print(error)
                self?.showAlert(title: "Ошибка", message: "Некорректные данные")
            }
        }
    }
    
    func inputsAreValid() -> Bool {
        let name = nameInput.text ?? ""
        let surname = surnameInput.text ?? ""
        let email = emailInput.text ?? ""
        let password = passwordInput.text ?? ""
        return !(name.isEmpty || surname.isEmpty || email.isEmpty || password.isEmpty)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
}

