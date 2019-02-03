//
//  ProfileViewModel.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/3/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import Foundation

struct ProfileViewModel {
    let sections: [ProfileSectionViewModel]
    
    static let empty = ProfileViewModel(sections: [])
    
    init(sections: [ProfileSectionViewModel]) {
        self.sections = sections
    }
    
    init(user: User) {
        sections = [
            ProfileSectionViewModel(title: "Basic Info", rows: [
                ProfileInfoViewModel(description: "First Name", value: user.firstName),
                ProfileInfoViewModel(description: "Last Name", value: user.lastName),
                ProfileInfoViewModel(description: "Email", value: user.email),
                ProfileInfoViewModel(description: "Account Type", value: user.type.rawValue.capitalized)
            ]),
            ProfileSectionViewModel(title: "Insurance Benefits", rows: [
                ProfileInfoViewModel(description: "MedPoints", value: String(describing: user.points)),
                ProfileInfoViewModel(description: "Next Reward", value: "2000 points, 10% off medication copay")
            ])
        ]
    }
}

struct ProfileSectionViewModel {
    let title: String
    let rows: [ProfileInfoViewModel]
}

struct ProfileInfoViewModel {
    let description: String
    let value: String
}
