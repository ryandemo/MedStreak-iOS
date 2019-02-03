//
//  CarePlanViewController.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/2/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import CareKit
import UIKit

class CarePlanViewController: OCKCareCardViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Care Plan"
        glyphType = .medication
        
        HealthRecordsManager.shared.requestHealthRecordsAuthorization { success in
            guard success else {
                self.presentSimpleAlert(title: "Unable to Request Health Records")
                return
            }
            
            HealthRecordsManager.shared.listHealthRecordsMedications(completion: { success in
                if !success {
                    self.presentSimpleAlert(title: "Couldn't Get Health Records")
                }
                
                self.tableView.reloadData()
            })
        }
        
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
