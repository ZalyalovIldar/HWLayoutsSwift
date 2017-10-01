//
//  GiftsTableViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 24/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class GiftsTableViewCell: UITableViewCell {

    @IBOutlet weak var giftsNumberLabel: UILabel!
    
    func prepareCell(with item: InformationViewModelGiftsItem) {
        giftsNumberLabel.text = item.giftNumbers
        giftsNumberLabel.sizeToFit()
    }
}
