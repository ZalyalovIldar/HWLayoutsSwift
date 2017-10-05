//
//  CustomHeaderTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class CustomHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    
    func prepareCell(with user: User, viewForHeaderInSection section: Int) {
        headerLabel.text = user.profile[section].sectionName
    }

}
