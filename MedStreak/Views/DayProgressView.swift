//
//  DayProgressView.swift
//  MedStreak
//
//  Created by Ryan Demo on 2/3/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import UICircularProgressRing
import UIKit

class DayProgressView: UIView {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressRing: UICircularProgressRing!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressRing.innerRingColor = globalTint
    }
    
    func configure(for dateString: String, adherence: Float) {
        textLabel.text = dateString
        progressRing.startProgress(to: CGFloat(adherence), duration: 0.75)
    }

    class func instanceFromNib() -> DayProgressView {
        return UINib(nibName: "DayProgressView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DayProgressView
    }
}
