//
//  FriendAdherenceViewModel.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/3/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import Foundation

struct AdherenceViewModel {
    let me: FriendAdherenceViewModel
    let friends: [FriendAdherenceViewModel]
    
    var hasFriends: Bool {
        return !friends.isEmpty
    }
    
    static let empty = AdherenceViewModel(me: FriendAdherenceViewModel(name: "Me", streak: 0, actionable: false, dayAdherenceViewModels: []), friends: [])
    
    init(me: FriendAdherenceViewModel, friends: [FriendAdherenceViewModel]) {
        self.me = me
        self.friends = friends
    }
    
    init(user: User, friends: [User]) {
        let range = 0..<6
        let lastSixDays = range.map { delta -> DateComponents in
            let date = Date().addingTimeInterval(TimeInterval(60*60*24*(-5 + delta)))
            return Calendar.current.dateComponents(Set([.year, .month, .day]), from: date)
        }
        
        let adherenceViewModels = lastSixDays.map {
            DayAdherenceViewModel(dayString: "\($0.month ?? 0)/\($0.day ?? 0)", adherence: 0.9)
        }
        
        me = FriendAdherenceViewModel(name: user.firstName + " " + user.lastName, streak: user.streak, actionable: false, dayAdherenceViewModels: adherenceViewModels)
        
        self.friends = friends.map {
            FriendAdherenceViewModel(name: $0.firstName + " " + $0.lastName, streak: $0.streak, actionable: true, dayAdherenceViewModels: adherenceViewModels)
        }
    }
}

struct FriendAdherenceViewModel {
    let name: String
    let streak: Int
    let actionable: Bool
    let dayAdherenceViewModels: [DayAdherenceViewModel]
}

struct DayAdherenceViewModel {
    let dayString: String
    let adherence: Float
}
