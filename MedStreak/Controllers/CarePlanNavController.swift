//
//  CarePlanNavController.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/2/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import UIKit

class CarePlanNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let store = CarePlanStoreManager.shared.store
        let carePlanViewController = CarePlanViewController(carePlanStore: store)
        
        // load tasks into carekit
        
        self.pushViewController(carePlanViewController, animated: false)
    }

}
