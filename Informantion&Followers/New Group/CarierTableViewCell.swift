//
//  CarierTableViewCell.swift
//  Informantion&Followers
//
//  Created by Дамир Зарипов on 24.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class CarierTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var localAndYearsLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareCell(with item: InfoViewModelCarierItem) {
        companyLabel.text = item.company
        companyLabel.sizeToFit()
        localAndYearsLabel.text = item.locationAndPeriod
        localAndYearsLabel.sizeToFit()
        professionLabel.text = item.position
        professionLabel.sizeToFit()
    }
}
