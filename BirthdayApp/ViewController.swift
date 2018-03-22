//
//  ViewController.swift
//  BirthdayApp
//
//  Created by Marcus Lundgren on 2018-02-21.
//  Copyright © 2018 Marcus Lundgren. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createAccountTapped(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text
        {
            Auth.auth().createUser(withEmail: email, password: password, completion: { user, Error in
              
                if let firebaseError = Error{
                    print(firebaseError.localizedDescription)
                    return
                }
                print("Success")
            })
        }
    }
    @IBAction func loginTapped(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text
        {
            Auth.auth().signIn(withEmail: email, password: password, completion: { user, error in
                
                if let firebaseError = error{
                    print(firebaseError.localizedDescription)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
                //self.presentLoggedInScreen()
            })
        }
    }
    
    /*
    func presentLoggedInScreen(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let loggedInVC:LoggedInVC = storyboard.instantiateViewController(withIdentifier: "LoggedInVC") as! LoggedInVC
        self.present(loggedInVC, animated: true, completion: nil)
    }
    */
}

