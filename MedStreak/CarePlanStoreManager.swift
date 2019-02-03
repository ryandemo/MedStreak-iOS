//
//  CarePlanStoreManager.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/2/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import CareKit
import Foundation

class CarePlanStoreManager: NSObject {
    
    static let shared = CarePlanStoreManager()
    let store: OCKCarePlanStore
    
    override private init() {
        let searchPaths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        let applicationSupportPath = searchPaths[0]
        let persistenceDirectoryURL = URL(fileURLWithPath: applicationSupportPath)
        
        if !FileManager.default.fileExists(atPath: persistenceDirectoryURL.absoluteString, isDirectory: nil) {
            try? FileManager.default.createDirectory(at: persistenceDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        // Create the store
        store = OCKCarePlanStore(persistenceDirectoryURL: persistenceDirectoryURL)
        
        super.init()
    }
    
    func add(activity: OCKCarePlanActivity) {
        let sema = DispatchSemaphore(value: 0)
        
        store.add(activity) { success, error in
            defer { sema.signal() }
            
            guard success else {
                return print("Did not successfully save activity \(activity.identifier)")
            }
        }
        
        sema.wait()
    }
    
    func delete(activity: OCKCarePlanActivity) {
        let sema = DispatchSemaphore(value: 0)
        
        store.remove(activity) { success, error in
            defer { sema.signal() }
            
            guard success else {
                return print("Did not successfully remove activity \(activity.identifier)")
            }
        }
        
        sema.wait()
    }
    
}

extension CarePlanStoreManager: OCKCarePlanStoreDelegate {
    func carePlanStore(_ store: OCKCarePlanStore, didReceiveUpdateOf event: OCKCarePlanEvent) {
        // update adherence
    }
}
