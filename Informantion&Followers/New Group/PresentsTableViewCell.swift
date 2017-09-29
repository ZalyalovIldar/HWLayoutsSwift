//
//  PresentsTableViewCell.swift
//  Informantion&Followers
//
//  Created by Дамир Зарипов on 24.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class PresentsTableViewCell: UITableViewCell {
    @IBOutlet weak var numberOfPresentsLabel: UILabel!
    
    func prepareCell(with item: InfoViewModelPresentsItem) {
        numberOfPresentsLabel.text = item.presentsNumbers
        numberOfPresentsLabel.sizeToFit()
    }
    
}
