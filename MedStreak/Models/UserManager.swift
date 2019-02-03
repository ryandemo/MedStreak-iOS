//
//  UserManager.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/2/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private init() {
        
    }
    
    var user: User?
    static var currentUser: User? {
        return User(id: "", firstName: "Ryan", lastName: "Demo", email: "ryan.demo@me.com", type: .patient, points: 200, streak: 4, medications: [], friends: []) // shared.user
    }
}
