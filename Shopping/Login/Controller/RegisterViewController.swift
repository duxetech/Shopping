//
//  RegisterViewController.swift
//  Shopping
//
//  Created by Karthik on 6/26/20.
//  Copyright © 2020 Karthik. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    @IBOutlet var loader: UIActivityIndicatorView!
    @IBOutlet var passCheck: UIImageView!
    @IBOutlet var confirmPassCheck: UIImageView!
    
    @IBOutlet var responseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passCheck.isHidden = true
        confirmPassCheck.isHidden = true
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: UIControl.Event.editingChanged)
        confirmTextField.addTarget(self, action: #selector(textDidChange), for: UIControl.Event.editingChanged)
        responseLabel.isHidden = true
    }
    
    @objc func textDidChange(_ textField : UITextField){
        
        if textField == confirmTextField || textField == passwordTextField {
            passCheck.isHidden = false
            confirmPassCheck.isHidden = false
        }
     
        if confirmTextField.text!.isEmpty && passwordTextField.text!.isEmpty {
            passCheck.isHidden = true
            confirmPassCheck.isHidden = true

        }
        
        if passwordTextField.text == confirmTextField.text {
            passCheck.image = UIImage(named: AppImages.GREENCHECK)
            confirmPassCheck.image = UIImage(named: AppImages.GREENCHECK)
        } else {
            passCheck.image = UIImage(named: AppImages.REDCHECK)
            confirmPassCheck.image = UIImage(named: AppImages.REDCHECK)
        }
    }
    

    
    
    @IBAction func registerPressed(_ sender: Any) {
        responseLabel.isHidden = true
        guard let user = userTextField.text else { return }
        guard let pass = passwordTextField.text else { return }
        guard let confirm = confirmTextField.text  else { return }
        guard  let email = emailTextField.text else { return }
        
        if user == "" || pass == "" || confirm == "" || email == "" {
            print("blank text")
            return
        }
        if pass != confirm {
            passwordTextField.placeholder = "not matching"
            print("pass not matching")
            return
        }
        loader.isHidden = false
        loader.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: pass) { result, error in
            print(result,error)
            self.loader.isHidden = true
            self.loader.stopAnimating()
            if let error = error {
                print(error)
                self.responseLabel.text = error.localizedDescription
                self.responseLabel.isHidden = false
                return
            }
            self.navigate()
        }
    }
    
   func navigate(){
          let story = UIStoryboard(name: "Main", bundle: nil)
          let controller = story.instantiateViewController(identifier: "HomeViewController")
          navigationController?.pushViewController(controller, animated: true)
      }
    
  
    

    
    
}
