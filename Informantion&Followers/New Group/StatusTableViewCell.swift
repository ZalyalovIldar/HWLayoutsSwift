//
//  StatusTableViewCell.swift
//  Informantion&Followers
//
//  Created by Дамир Зарипов on 23.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func prepateCell(with item: InfoViewModelStatusItem){
        statusLabel.text = item.status
        statusLabel.sizeToFit()
    }
    
}
