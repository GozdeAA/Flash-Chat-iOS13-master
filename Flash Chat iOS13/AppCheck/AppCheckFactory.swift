//
//  AppCheckFactory.swift
//  Flash Chat iOS13
//
//  Created by Gözde Aydin on 29.08.2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import FirebaseAppCheck
import FirebaseCore

class CustomAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        return CustomAppCheckProvider(withFirebaseApp: app)
    }
}
