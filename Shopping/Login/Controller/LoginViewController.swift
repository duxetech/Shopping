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
    
    @IBOutlet var invalidCredLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        loader.isHidden = true
        invalidCredLabel.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func createUserClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "RegisterViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func guestClicked(_ sender: Any) {
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        invalidCredLabel.isHidden = true
        guard let email = emailTextField.text, email.isNotEmpty,
            let password = passwordTextField.text, password.isNotEmpty
          else {
              return
           }
        loader.isHidden = false
        loader.startAnimating()

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.loader.stopAnimating()
            self.loader.isHidden = true
            if let error = error {
                print(error.localizedDescription)
                self.invalidCredLabel.isHidden = false
                self.invalidCredLabel.text = "incorrect credentials"
                return
            }
            self.navigate()
            print(result?.additionalUserInfo)
        }
    }
    func navigate(){
           let story = UIStoryboard(name: "Main", bundle: nil)
           let controller = story.instantiateViewController(identifier: "HomeViewController")
           navigationController?.pushViewController(controller, animated: true)
       }
    
}

