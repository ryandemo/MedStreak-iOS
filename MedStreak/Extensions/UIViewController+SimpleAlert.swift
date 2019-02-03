//
//  UIViewController+SimpleAlert.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/3/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentSimpleAlert(title: String, message: String? = nil, _ onDismiss: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: onDismiss))
        self.present(alert, animated: true, completion: nil)
    }
}
