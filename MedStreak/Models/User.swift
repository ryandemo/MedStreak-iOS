//
//  User.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/2/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import Foundation

enum UserType: String, Codable {
    case patient, support, physician
}

struct User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let type: UserType
    let points: Int
    let streak: Int
    let medications: [Medication]
    let friends: [String]
    
    init(id: String, firstName: String, lastName: String, email: String, type: UserType, points: Int, streak: Int, medications: [Medication], friends: [String]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.type = type
        self.points = points
        self.streak = streak
        self.medications = medications
        self.friends = friends
    }
}

struct UserComposer: Codable {
    let firstName: String?
    let lastName: String?
    let email: String?
    let password: String?
    let type: String?
}
