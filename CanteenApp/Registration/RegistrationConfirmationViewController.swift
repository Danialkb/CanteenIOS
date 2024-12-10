//
//  Untitled.swift
//  CanteenApp
//
//  Created by мак on 10.12.2024.
//

import UIKit

class RegistrationConfirmationViewController: UIViewController {
    
    let userService = UserService()
    
    @IBOutlet weak var codeInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func confirmRegistration(_ sender: Any) {
        if (!inputsAreValid()) {
            showAlert(title: "Ошибка", message: "Введите код")
            return
        }
        let registrationConfirmSchema = RegistrationConfirmSchema(session_id: UserDefaults.standard.string(forKey: "session_id")!, code: codeInput.text!)
        userService.confirmRegister(registrationConfirmData: registrationConfirmSchema) { [weak self] result in
            switch result {
            case .success(_):
                self?.performSegue(withIdentifier: "authSegue", sender: nil)
                self?.showAlert(title: "Ураа", message: "Вы успешно зарегистрированы")
            case .failure(let error):
                print(error)
                self?.showAlert(title: "Ошибка", message: "Неверный код")
            }
        }
    }

    func inputsAreValid() -> Bool {
        let code = codeInput.text ?? ""
        return !(code.isEmpty)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
}
