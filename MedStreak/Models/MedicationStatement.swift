//
//  MedicationStatement.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/3/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import Foundation

struct MedicationStatement: Codable {
    let id: String
    let dosage: [Dosage]
    let medicationCodeableConcept: MedicationCodableConcept
    let status: String?
    let effectivePeriod: EffectivePeriod?
    
    var date: Date? {
        let formatter = DateFormatter()
        
        for format in ["yyyy-MM-dd", "yyyy-MM-dd'T'HH:mm:ssZ"] {
            formatter.dateFormat = format
            if let effectivePeriod = effectivePeriod, let date = formatter.date(from: effectivePeriod.start) {
                return date
            }
        }
        
        return nil
    }
    
    var instruction: String? {
        return dosage.first?.text
    }
    
    var timesPerDay: Int {
        guard let repeatCadence = dosage.first?.timing.repeat else {
            return 1
        }
        
        switch repeatCadence.periodUnits {
        case .min:
            return repeatCadence.frequency * 24 * 60 / repeatCadence.period
        case .h:
            return repeatCadence.frequency * 24 / repeatCadence.period
        case .d:
            return repeatCadence.frequency * repeatCadence.period
        default:
            return 1
        }
    }
    
    var schedule: [[[Int]]] {
        let daily: [[Int]] = {
            switch timesPerDay {
            case 2:
                return [[8, 00], [20, 00]]
            default:
                return [[8, 00]]
            }
        }()
        
        var total = [[[Int]]]()
        for _ in 0..<7 {
            total.append(daily)
        }
        return total        
    }
}

struct MedicationCodableConcept: Codable {
    let coding: [MedicationCoding]
    let text: String
}

struct MedicationCoding: Codable {
    let code: String?
    let display: String?
    let system: URL?
}

struct Dosage: Codable {
    let asNeededBoolean: Bool
    let method: Method
    let quantityQuantity: Quantity
    let route: Route
    let text: String
    let timing: Timing
}

struct EffectivePeriod: Codable {
    let start: String
}

struct Method: Codable {
    let text: String
}

struct Quantity: Codable {
    let code: String
    let system: URL
    let unit: String
    let value: Double
}

struct Route: Codable {
    let text: String
}

struct Timing: Codable {
    let code: Code
    let `repeat`: Repeat
}

struct Code: Codable {
    let text: String
}

struct Repeat: Codable {
    let boundsPeriod: EffectivePeriod
    let frequency: Int
    let period: Int
    let periodUnits: PeriodUnits
}

enum PeriodUnits: String, Codable {
    case s, min, h, d, wk, mo, a
}
