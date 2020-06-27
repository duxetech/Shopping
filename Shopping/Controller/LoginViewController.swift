//
//  ViewController.swift
//  Shopping
//
//  Created by Karthik on 6/15/20.
//  Copyright © 2020 Karthik. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet var loader: UIActivityIndicatorView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: Any) {
      loader.isHidden = false
      loader.startAnimating()
        
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty  else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.loader.stopAnimating()
            self.loader.isHidden = true
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print(result?.additionalUserInfo)
        }
    }
    
}

