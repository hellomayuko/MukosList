//
//  SettingsHelper.swift
//  MukosList
//
//  Created by Mayuko Inoue on 9/18/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation

let usernameKey = "kaimemo.username"

struct SettingsHelper {
    func fetchUserName() -> String {
        guard let username = UserDefaults.standard.value(forKey: usernameKey) as? String else {
            return ""
        }
        return username
    }
    
    func updateUsername(_ username: String) {
        UserDefaults.standard.setValue(username, forKey: usernameKey)
    }
}
