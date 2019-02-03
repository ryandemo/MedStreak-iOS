//
//  Medication.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/2/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import CareKit
import Foundation

struct Medication: Codable {
    let id: String
    let name: String
    let instructions: String
    let schedule: [[[Int]]]
    let adherence: [Date: [Int]]
    
    init(id: String, name: String, instructions: String, schedule: [[[Int]]]) {
        self.id = id
        self.name = name
        self.instructions = instructions
        self.schedule = schedule
        self.adherence = [Date: [Int]]()
    }
    
    var scheduleDescription: String? {
        guard let first = schedule.first(where: { !$0.isEmpty }) else {
            return nil
        }
        
        let components = first.map {
            DateComponents(calendar: Calendar.current, hour: $0[0], minute: $0[1])
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        return components.map {
            Calendar.current.date(from: $0).flatMap(formatter.string) ?? ""
        }.joined(separator: ", ")
    }
    
    var ockSchedule: OCKCareSchedule {
//        let occurrences = schedule.map { NSNumber(value: $0.count) }
        return OCKCareSchedule.dailySchedule(withStartDate: DateComponents.nowComponents, occurrencesPerDay: 1)
    }
    
    var asOCKActivty: OCKCarePlanActivity {
        return OCKCarePlanActivity.intervention(withIdentifier: id, groupIdentifier: "Medications", title: name, text: scheduleDescription, tintColor: globalTint, instructions: instructions, imageURL: nil, schedule: ockSchedule, userInfo: nil, optional: false)
    }
}
