//
//  EducationTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class EducationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var educationTypeLabel: UILabel!
    
    @IBOutlet weak var educationPlaceLabel: UILabel!
    
    func prepareCell(with user: User, cellForRowAt indexPath: IndexPath) {
        
        educationTypeLabel.text = user.profile[indexPath.section].rowsNames[indexPath.row]
        
        educationPlaceLabel.text = user.profile[indexPath.section].rowsFilling[indexPath.row]
    }

}
