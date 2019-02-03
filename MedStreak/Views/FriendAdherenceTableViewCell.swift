//
//  FriendAdherenceTableViewCell.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/2/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import CareKit
import UIKit

class FriendAdherenceTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet weak var adherenceStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addHeaderView()
    }
    
    func addHeaderView() {
        for _ in 0..<6 {
            let view = DayProgressView.instanceFromNib()
            adherenceStack.addArrangedSubview(view)
        }
    }
    
    func configure(for viewModel: FriendAdherenceViewModel) {
        nameLabel.text = viewModel.name
        streakLabel.text = "\(viewModel.streak) day streak"
        
        isUserInteractionEnabled = viewModel.actionable
        accessoryType = viewModel.actionable ? .disclosureIndicator : .none
        
        for i in 0..<viewModel.dayAdherenceViewModels.count {
            if let adherenceView = adherenceStack.arrangedSubviews[i] as? DayProgressView {
                adherenceView.configure(for: viewModel.dayAdherenceViewModels[i].dayString, adherence: viewModel.dayAdherenceViewModels[i].adherence)
            }
        }
    }

}
