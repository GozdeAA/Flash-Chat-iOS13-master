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
    var messages: [Message] = [
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

    func loadMessages() {
        // continuously listens messages collection
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            self.messages = [] // clear previous messages
            if let e = error {
                print("an error occurred while fetching messages from firebase \(e)")
            } else {
                if let querySnapshot = querySnapshot?.documents {
                    for doc in querySnapshot {
                        let data = doc.data() // get each data from collection
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)

                            DispatchQueue.main.async { // to reload ui with new data
                                self.tableView.reloadData()
                                // this one is necessary for getting indexpath of the list
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0) // if there is more than 1 item with scrolls this indicates which section will have the indexpath
                                // scroll to bottom on each new message
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
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
        let message = messages[indexPath.row]
        // to convert messagecell class
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body

        // This is a message from the current user.
        if message.sender == Auth.auth().currentUser?.email {
            cell.youAvatar.isHidden = true
            cell.avatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        // This is a message from another sender.
        else {
            cell.youAvatar.isHidden = false
            cell.avatar.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }

        return cell
    }
}
