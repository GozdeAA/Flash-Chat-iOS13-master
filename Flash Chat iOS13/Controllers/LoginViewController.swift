//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!

    @IBAction func loginPressed(_ sender: UIButton) {
        /*
         let emailIsValid = emailTextfield.text != nil && !emailTextfield.text!.isEmpty && emailTextfield.text!.contains("@")
         let passwordIsValid = passwordTextfield.text != nil && !passwordTextfield.text!.isEmpty && passwordTextfield.text!.count > 3
         */

        if let password = passwordTextfield.text, let email = emailTextfield.text { // checks if values are not nil
            login(email: email, password: password)
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { //this must be at the top of the closure, this usage and "weak self" prevents memory leak
                // if self is nil returns otherwise self will be assinged to strongself :)
                return
            }
            if let newError = error {
                print(newError.localizedDescription)
                return
            }

            if let res = authResult {
                print(res.user.uid)
                strongSelf.performSegue(withIdentifier: Constants.loginToChat , sender: self)
            } else {
                print(authResult)
            }
        }
    }
}
