//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!

    @IBAction func registerPressed(_ sender: UIButton) {
        let emailIsValid = emailTextfield.text != nil && !emailTextfield.text!.isEmpty && emailTextfield.text!.contains("@")
        let passwordIsValid = passwordTextfield.text != nil && !passwordTextfield.text!.isEmpty && passwordTextfield.text!.count > 3
        
        if emailIsValid && passwordIsValid {
            createFirebaseUser(email: emailTextfield.text!, password: passwordTextfield.text!)
        }else{
            //TODO: show warning
        }
    }

    func createFirebaseUser(email: String, password: String) {
        //show loading till operation is overf
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let newError = error {
                print(newError)
            }
            if let res = authResult {
                print("login successful")
                print(res.user.uid)
                self.performSegue(withIdentifier: Constants.registerToChat, sender: self) //need to add self to access "self" in clousure
                //navigate next screen
            }
        }
    }
}
