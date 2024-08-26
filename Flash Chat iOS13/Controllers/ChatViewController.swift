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
    let messages: [Message] = [
        Message(sender: "oi", body: "Hello"),
        Message(sender: "oy", body: "hawagi"),
        Message(sender: "oi", body: "haxim")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self //checks the current class
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

extension ChatViewController: UITableViewDataSource{
    //for list length
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    //identifies current cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].sender
        return cell
    }
    
     
}
