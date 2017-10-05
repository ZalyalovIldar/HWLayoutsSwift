//
//  CareerTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class CareerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobLabel: UILabel!
    
    
    @IBOutlet weak var positionLabel: UILabel!
    

    @IBOutlet weak var companysImage: UIImageView!
    
    func prepareCell(with user: User, cellForRowAt indexPath: IndexPath) {
        jobLabel.text = user.profile[indexPath.section].rowsNames[indexPath.row]
        
        positionLabel.text = user.profile[indexPath.section].rowsFilling[indexPath.row]
        
        companysImage.image = user.profile[indexPath.section].rowsImages[indexPath.row]
    }

}
