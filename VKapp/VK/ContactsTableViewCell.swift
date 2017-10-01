//
//  ContactsTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var contactsIcon: UIImageView!
    
    @IBOutlet weak var contactLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareCell(with user: User, cellForRowAt indexPath: IndexPath) {
        contactsIcon.image = user.profile[indexPath.section].rowsImages[indexPath.row]
        
        contactLabel.text = user.profile[indexPath.section].rowsFilling[indexPath.row]
        
        if user.profile[indexPath.section].rowsImages[indexPath.row] == UIImage(named: "phone icon") {
            contactLabel.textColor = UIColor.blue
        }
    }

}
