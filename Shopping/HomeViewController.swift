//
//  HomeViewController.swift
//  Shopping
//
//  Created by Karthik on 6/27/20.
//  Copyright © 2020 Karthik. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    
    @IBOutlet var loginButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = Auth.auth().currentUser {
            loginButton.title = "Logout"
        } else {
            loginButton.title = "Login"
        }
    }
    

    @IBAction func loginPressed(_ sender: Any) {
       
        self.dismiss(animated: true)
        navigationController?.popViewController(animated: true)
        
        if let _ = Auth.auth().currentUser {
            do {
              try Auth.auth().signOut()
                navigate()
            } catch {
              debugPrint(error.localizedDescription)
            }
        } else {
             navigate()
        }
        
    }
    
    func navigate(){
        let story = UIStoryboard(name: "Login", bundle: nil)
        let controller = story.instantiateViewController(identifier: "LoginViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    deinit {
        print(self,"deinit called")
    }
    
}
