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
    var friends = [User]()
    static var currentUser: User? {
        return shared.user ?? User(id: "", firstName: "Ryan", lastName: "Demo", email: "ryan.demo@me.com", type: .patient, points: 200, streak: 4, medications: [], friends: [])
    }
    
    static var currentFriends: [User] {
        return shared.friends
    }
    
    func refreshUser() {
        MedStreakService.shared.getMe { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error)
            }
        }
        
        MedStreakService.shared.getMyFriends { result in
            switch result {
            case .success(let friends):
                self.friends = friends.friends
            case .failure(let error):
                print(error)
            }
        }
    }
}
