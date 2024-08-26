//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var logoutBtn: UIButton!
    @IBOutlet var messageTextfield: UITextField!

    let firebaseAuth = Auth.auth()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true // guess what this one does
    }

    @IBAction func sendPressed(_ sender: UIButton) {
    }

    @IBAction func logout(_ sender: Any) {
        do {
            try firebaseAuth.signOut()
            if let user = firebaseAuth.currentUser {
                return
            } else {
                //navigationController?.popViewController(animated: true) //previous page
                navigationController?.popToRootViewController(animated: true) // to root
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
