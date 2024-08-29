//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Gözde Aydin on 28.08.2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var messageBubble: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = 16
      //  messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
