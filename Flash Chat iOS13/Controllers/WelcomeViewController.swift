//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import CLTypingLabel
import UIKit

class WelcomeViewController: UIViewController {
    // @IBOutlet var titleLabel: UILabel!

    @IBOutlet var titleLabel: CLTypingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = K.appName
    }

    // runs before viewdidload
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    //runs after page is closed
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    /// basic animation for title text
    func animateTitle() {
        titleLabel.text = ""
        var charIndex = 0.0
        let title = "⚡️FlashChat"
        for letter in title {
            /// Timer
            Timer.scheduledTimer(withTimeInterval: 0.5 * charIndex, repeats: false) { [self] _ in
                titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
}
