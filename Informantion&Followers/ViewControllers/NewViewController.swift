//
//  NewViewController.swift
//  Informantion&Followers
//
//  Created by itisioslab on 22.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameNavigationItem: UINavigationItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var infoScrollView: UIScrollView!
    @IBOutlet weak var numberOfFriendButton: UIButton!
    @IBOutlet weak var numberOfFollowersButton: UIButton!
    @IBOutlet weak var numberOfGroupsButton: UIButton!
    @IBOutlet weak var numberOfPhotoButton: UIButton!
    @IBOutlet weak var photoesScrollView: UIScrollView!
    @IBOutlet weak var addEntryButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var addPlaceButton: UIButton!
    
    var user: User!
    let years = " years"
    let borderWidth: CGFloat = 1
    let borderColour = UIColor.init(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
    let buttonWidth = 35
    let buttonHeight = 35
    let followersSegueIdentifier = "followersIdentifier"
    let ownInfoSegueIdentifier = "ownInfoIdentifier"
    let navigationBarColor = UIColor.init(red: 89/255.0, green: 125/255.0, blue: 163/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackgroundNavagation()
        user = createUser()
        setInfo(for: user)
        setNavigationBarColorAndFont()
        roundImage(for: avatarImageView)
        changeBorder(for: infoScrollView)
        changeBorder(for: photoesScrollView)
        changeBorder(for: addPhotoButton)
        changeBorder(for: addEntryButton)
        changeBorder(for: addPlaceButton)
    }
    
    func changeBackgroundNavagation() {
        self.navigationController?.navigationBar.barTintColor = UIColor.blue
    }
    
    func roundImage(for image: UIImageView) {
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
    }
    
    func createUser() -> User {
        var user = UserInfo.createInfo()
        for _ in 0 ..< 10 {
            user.followers.append(UserInfo.createInfo())
        }
        return user 
    }
    
    func changeBorder(for view: UIView) {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColour
    }
    
    func setInfo(for user: User) {
        avatarImageView.image = user.avatar
        nameNavigationItem.title = user.name
        nameLabel.text = user.name
        nameLabel.sizeToFit()
        surnameLabel.text = user.surname
        surnameLabel.sizeToFit()
        ageLabel.text = String(user.age) + years
        ageLabel.sizeToFit()
        cityLabel.text = user.city
        cityLabel.sizeToFit()
    }
    
    func setNavigationBarColorAndFont(){
        self.navigationController?.navigationBar.barTintColor = navigationBarColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == followersSegueIdentifier {
            let followersVC = segue.destination as! FollowersTableViewController
            followersVC.followers = user.followers
        }
        if segue.identifier == ownInfoSegueIdentifier {
            let ownInfoVC = segue.destination as! OwnInfoTableViewController
            ownInfoVC.nameUser = user.name
            ownInfoVC.surnameUser = user.surname
            ownInfoVC.avatarUser = user.avatar
            ownInfoVC.ageUser = String(user.age) + years
            ownInfoVC.cityUser = user.city
        }
    }

}
