//
//  ProfileInfoTableViewCell.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/3/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func configure(for viewModel: ProfileInfoViewModel) {
        descriptionLabel.text = viewModel.description
        valueLabel.text = viewModel.value
    }

}
