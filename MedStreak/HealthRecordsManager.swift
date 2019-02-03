//
//  HealthRecordsManager.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/3/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import Foundation
import HealthKit

struct HealthRecordsManager {
    let store = HKHealthStore()
    
    static let shared = HealthRecordsManager()
    
    var medicationType: HKClinicalType {
        return HKObjectType.clinicalType(forIdentifier: .medicationRecord)!
    }
    
    var clinicalObjectTypes: Set<HKObjectType> {
        return Set([medicationType] as [HKObjectType])
    }
    
    func requestHealthRecordsAuthorization(completion: @escaping (Bool) -> Void) {
        store.requestAuthorization(toShare: nil, read: clinicalObjectTypes, completion: { success, error in
            completion(success)
        })
    }
    
    func listHealthRecordsMedications(completion: @escaping (Bool) -> Void) {
        listAllHealthRecords(for: medicationType) { records in
            let fhirDecoder = JSONDecoder()
            
            print(records.map { $0.displayName })
            
            let meds = records.compactMap { record -> Medication? in
                guard record.clinicalType.identifier == HKClinicalTypeIdentifier.medicationRecord.rawValue,
                    let identifier = record.fhirResource?.identifier,
                    let fhirData = record.fhirResource?.data else {
                        return nil
                }
                
                if let fhirMedication = try? fhirDecoder.decode(MedicationStatement.self, from: fhirData) {
                    let med = Medication(id: identifier, name: record.displayName, instructions: fhirMedication.instruction ?? "No instructions available", schedule: fhirMedication.schedule)
                    return med
                } else {
                    var total = [[[Int]]]()
                    for _ in 0..<7 {
                        total.append([[8, 00]])
                    }
                    
                    let med = Medication(id: identifier, name: record.displayName, instructions: "No instructions available", schedule: total)
                    return med
                }
            }
            
            for med in meds {
                CarePlanStoreManager.shared.add(activity: med.asOCKActivty)
            }
        }
    }
    
    func listAllHealthRecords(for clinicalType: HKClinicalType, onSuccess: @escaping ([HKClinicalRecord]) -> Void) {
        let query = HKSampleQuery(sampleType: clinicalType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
            guard let recordSamples = samples as? [HKClinicalRecord] else {
                return
            }
            
            onSuccess(recordSamples)
        }
        
        store.execute(query)
    }
}
