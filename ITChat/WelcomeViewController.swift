//
//  WelcomeViewController.swift
//  ITChat
//
//  Created by NeilPhung on 8/2/19.
//  Copyright © 2019 NeilPhung. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    //MARK: IBAction
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        dismissKeyboard()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        dismissKeyboard()
    }
    
    @IBAction func backgroundTap(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    //MARK: Helper Method
    
    func dismissKeyboard(){
        view.endEditing(false)
    }
    
    func cleanTextfield(){
        emailTextField.text = ""
        passwordTextField.text = ""
        repeatPasswordTextField.text = ""
    }
}
