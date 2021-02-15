//
//  LoginViewController.swift
//  Social
//
//  Created by Ирина Калинина on 15.02.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        passwordTextField.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        print("Username: \(usernameTextField.text ?? "")")
        print("Password: \(passwordTextField.text ?? "")")
    }
    
}

