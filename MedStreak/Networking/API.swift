//
//  API.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/2/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import Foundation

struct API {
    let login: URL
    let user: URL
    let medications: URL

    init(baseURL: URL) {
        login = baseURL.appendingPathComponent("login")
        user = baseURL.appendingPathComponent("user")
        medications = baseURL.appendingPathComponent("medications")
    }
    
    func user(withID id: String) -> URL {
        return user.appendingPathComponent(id)
    }
    
    func friends(forUserWithID id: String) -> URL {
        return user(withID: id).appendingPathComponent("friends")
    }
    
    func friend(withID friendID: String, forUserWithID id: String) -> URL {
        return friends(forUserWithID: id).appendingPathComponent(friendID)
    }
    
    func medications(forUserWithID id: String) -> URL {
        return medications.appendingPathComponent(id)
    }
}

