//
//  PresentTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 23.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class PresentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var presentsCountLabel: UILabel!
    @IBOutlet var presentsImageView: [UIImageView]!
    @IBOutlet var distances: [NSLayoutConstraint]!
    
    var accessoryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        accessoryButton = self.subviews.flatMap { $0 as? UIButton }.first
        
        //configureDistance()
    }
    
    private func configureDistance() {
        let screenWidth = UIScreen.main.bounds.width
        let newDistance = (screenWidth - 8 - 8 - 4 * (presentsImageView[0].frame.width) - accessoryButton.frame.width) / 3
        for distance in distances {
            distance.constant = newDistance
        }
    }
    
    override func layoutSubviews() {
        let arrowPosition: CGFloat = 8
        
        super.layoutSubviews()
        accessoryButton.frame.origin.y = arrowPosition
    }
    
    func prepareCell(with presents: [Present]) {
        presentsCountLabel.text = "\(presents.count) \(EndingWord.getCorrectEnding(with: presents.count, and: DeclinationWordDictionary.present))"
        presentsImageView.forEach { $0.image = presents[0].image }
        
        presentsImageView.enumerated().forEach { $0.element.image = presents[$0.offset].image }
    }
    
}
