//
//  SignInViewController.swift
//  SnapchatClone
//
//  Created by William Schoettler on 10/7/17.
//  Copyright © 2017 William Schoettler. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func signInUpTapped(_ sender: Any) {
        
        // Attempt to sign in to a Firebase account using email and password
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("We tried to sign in")
            
            // If there was a failure signing in, report the error
            if error != nil {
                print("#########################################")
                print("An error has occurred! \(error)")
                
                // Attempt to create a user since the most likely cause of the error is that none exists
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    
                    if error != nil {
                        // If there was an error creating the user, report the error
                        print("#########################################")
                        print("We have an error attempting to create a user")
                    } else {
                        // If there was not an error, the user was created successfully
                        print("#########################################")
                        print("User created successfully")
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                        
                    }
                })
            } else {
                // If no error, upon the sign-in attempt, then we have signed in successfully
                print("We signed in successfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        }
    }
    
}

