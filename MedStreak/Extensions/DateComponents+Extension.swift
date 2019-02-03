//
//  DateComponents+Extension.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/3/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import Foundation

extension DateComponents {
    static var nowComponents: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day], from: Date())
    }
}
