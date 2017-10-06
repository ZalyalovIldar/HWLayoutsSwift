//
//  NewsTableViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 02/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    
    func prepare(with text: String) {
    
        noteLabel.text = text
    }
}
