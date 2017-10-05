//
//  InterestsTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class InterestsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var interestNameLabel: UILabel!
    
    @IBOutlet weak var interestsCountLabel: UILabel!
    
    func prepareCell(with user: User, cellForRowAt indexPath: IndexPath) {
        interestNameLabel.text = user.profile[indexPath.section].rowsNames[indexPath.row]
        
        interestsCountLabel.text = user.profile[indexPath.section].rowsFilling[indexPath.row]
    }
}
