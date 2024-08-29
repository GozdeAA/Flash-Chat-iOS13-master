//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var logoutBtn: UIButton!
    @IBOutlet var messageTextfield: UITextField!

    let db = Firestore.firestore()
    
    let firebaseAuth = Auth.auth()
    let messages: [Message] = [
        Message(sender: "oi", body: "Hello"),
        Message(sender: "oy", body: "hawagi"),
        Message(sender: "oi", body: "haxim"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self // checks the current class
        navigationItem.hidesBackButton = true // guess what this one does

        // to register custom cell view
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }

    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody]) { error in
                if let newError = error {
                    print(newError.localizedDescription)
                } else {
                    print("yaay")
                }
            }
        }
    }

    @IBAction func logout(_ sender: Any) {
        do {
            try firebaseAuth.signOut()
            if let user = firebaseAuth.currentUser {
                return
            } else {
                // navigationController?.popViewController(animated: true) //previous page
                navigationController?.popToRootViewController(animated: true) // to root
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    // for list length
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    // identifies current cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // to convert messagecell class
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label?.text = messages[indexPath.row].sender
        cell.avatar
        return cell
    }
}
