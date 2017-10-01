//
//  MainInformationTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class MainInformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rowNameLabel: UILabel!
    
    @IBOutlet weak var rowFillingLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareCell(with user: User, cellForRowAt indexPath: IndexPath) {
        
        let rowsName = user.profile[indexPath.section].rowsNames[indexPath.row]
        rowNameLabel.text = rowsName
        
        let fillingInformation = user.profile[indexPath.section].rowsFilling[indexPath.row]
        
        
        rowFillingLabel.text = fillingInformation
        
        if user.profile[indexPath.section].rowsNames[indexPath.row] == "Братья, сестры" {
            
            rowFillingLabel.textColor = UIColor.blue
        }

    }

}
