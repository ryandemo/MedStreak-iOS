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
    let medications: [String]
    let friends: [String]
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName, lastName, email, type, points, streak, medications, friends
    }
    
    init(id: String, firstName: String, lastName: String, email: String, type: UserType, points: Int, streak: Int, medications: [String], friends: [String]) {
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
