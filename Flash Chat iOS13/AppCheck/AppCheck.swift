//
//  AppCheck.swift
//  Flash Chat iOS13
//
//  Created by Gözde Aydin on 29.08.2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAppCheck

class CustomAppCheckProvider: NSObject, AppCheckProvider {
    var app: FirebaseApp

    init(withFirebaseApp app: FirebaseApp) {
        self.app = app
        super.init()
    }

    func getToken() async throws -> AppCheckToken {
        let getTokenTask = Task { () -> AppCheckToken in
            // ...

            // Create AppCheckToken object.
            let exp = Date(timeIntervalSince1970: TimeInterval(exactly: 1727384400000)!)
            let token = AppCheckToken(
                token: "",
                expirationDate: exp
            )

            if Date() > exp {
                throw NSError(domain: "ExampleError", code: 1, userInfo: nil)
            }

            return token
        }

        return try await getTokenTask.value
    }
}
