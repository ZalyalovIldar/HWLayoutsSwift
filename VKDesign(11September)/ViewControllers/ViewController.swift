//
//  ViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 11/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataTransferProtocol {
    @IBOutlet weak var photoScroll: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var aboutScroll: UIScrollView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var friendsCount: UIButton!
    @IBOutlet weak var followersCount: UIButton!
    @IBOutlet weak var groupsCount: UIButton!
    @IBOutlet weak var photosCount: UIButton!
    @IBOutlet weak var videoCount: UIButton!
    @IBOutlet weak var audioCount: UIButton!
    @IBOutlet weak var documentsCount: UIButton!
    @IBOutlet weak var giftsCount: UIButton!
    @IBOutlet weak var newsTableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    let navigationBarColor = UIColor.init(red: 89/255.0, green: 125/255.0, blue: 163/255.0, alpha: 1.0)
    let borderColor = UIColor.init(red: 184/255.0, green: 184/255.0, blue:184/255.0, alpha: 1.0).cgColor
    let surnameArray = ["Ivanov","Petrov","Sidorov"]
    let nameArray = ["Ivan", "Anton", "Vlad"]
    let ageArray = ["18 years old,", "21 years old,", "35 years old,"]
    let locationArray = ["Kirov", "Kazan", "Moscow"]
    let borderThickness : CGFloat = 0.5
    let avatarCornersMultiply : CGFloat = 10
    let friendsConst = "friends"
    let followersConst = "followers"
    let groupsConst = "groups"
    let photosConst = "photos"
    let videosConst = "videos"
    let audiosConst = "audios"
    let giftsConst = "gifts"
    let docsConst = "docs"
    let randomConst : UInt32 = 100
    let infoSequeIdentifier = "infoIdentifier"
    let noteSequeIdentifier = "noteSequeIdentifier"
    let radiusRoundCorner: CGFloat = 50
    var notesArray: [String] = []
    let noteCellIdentifier = "noteIdentifier"
    
    var buttonPressedDelegate : ButtonPressedProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomName()
        randomSurname()
        randomAge()
        randomLocation()
        topAboutScrollBorder()
        bottomAboutScrollBorder()
        bottomPhotoScrollBorder()
        photoButtonBorder()
        noteButtonBorder()
        randomInInfoScroll()
        setNavigationBarColorAndFont()
        avatar.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: radiusRoundCorner)
        cellRegistration()
        
    }

    @IBAction func moreInfoButtonPressed(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Редактировать профиль", style: .default, handler: nil)
        
        let copyAction = UIAlertAction(title: "Скопировать ссылку", style: .default, handler: nil)
        
        let shareAction = UIAlertAction(title: "Поделиться...", style: .default, handler: nil)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        optionMenu.addAction(editAction)
        optionMenu.addAction(copyAction)
        optionMenu.addAction(shareAction)
        optionMenu.addAction(cancelAction)
        
        present(optionMenu, animated: true, completion: nil)
        
    }
    
    func setNavigationBarColorAndFont(){
        navigationController?.navigationBar.barTintColor = navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    //MARK: Random fill arrays
    
    func randomName() {
        
        nameLabel.text = nameArray[Int(arc4random_uniform(UInt32(nameArray.count)))]
        navigationItem.title = nameLabel.text
        nameLabel.sizeToFit()
        
    }
    
    func randomSurname() {
        
        surnameLabel.text = surnameArray[Int(arc4random_uniform(UInt32(surnameArray.count)))]
        surnameLabel.sizeToFit()
        
    }
    
    func randomAge() {
        
        ageLabel.text = ageArray[Int(arc4random_uniform(UInt32(ageArray.count)))]
        ageLabel.sizeToFit()
        
    }
    
    func randomLocation() {
        
        locationLabel.text = locationArray[Int(arc4random_uniform(UInt32(locationArray.count)))]
        locationLabel.sizeToFit()
        
    }
    
    func randomInInfoScroll() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let color = UIColor.black

        
        let friends = NSAttributedString(string: "\(arc4random_uniform(randomConst)) \(friendsConst)",
            attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
        friendsCount.setAttributedTitle(friends, for: .normal)
        
        let followers = NSAttributedString(string: "\(arc4random_uniform(randomConst)) \(followersConst)",
            attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle ])
        followersCount.setAttributedTitle(followers, for: .normal)
        
        let groups = NSAttributedString(string: "\(arc4random_uniform(randomConst)) \(groupsConst)",
            attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
        groupsCount.setAttributedTitle(groups, for: .normal)
        
        let photos = NSAttributedString(string: "\(arc4random_uniform(randomConst)) \(photosConst)",
            attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
        photosCount.setAttributedTitle(photos, for: .normal)
        
        let videos = NSAttributedString(string: "\(arc4random_uniform(randomConst)) \(videosConst)",
            attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
        videoCount.setAttributedTitle(videos, for: .normal)
        
        let audios = NSAttributedString(string: "\(arc4random_uniform(randomConst)) \(audiosConst)",
            attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
        audioCount.setAttributedTitle(audios, for: .normal)
        
        let gifts = NSAttributedString(string: "\(arc4random_uniform(randomConst)) \(giftsConst)",
            attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
        giftsCount.setAttributedTitle(gifts, for: .normal)
        
        let docs = NSAttributedString(string: "\(arc4random_uniform(randomConst)) \(docsConst)",
            attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle ])
        documentsCount.setAttributedTitle(docs, for: .normal)

    }
    
    //MARK: Register custom cell
    
    func cellRegistration() {
        
        let newsCellNib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(newsCellNib, forCellReuseIdentifier: noteCellIdentifier)
        
    }
    
    //MARK: Button and Scroll Borders
    
    func bottomAboutScrollBorder() {
        
        let border = CALayer()
        border.backgroundColor = borderColor
        border.frame = CGRect(x: 0, y: aboutScroll.frame.height - borderThickness, width: aboutScroll.frame.width, height: borderThickness)
        aboutScroll.layer.addSublayer(border)
        
    }
    
    func topAboutScrollBorder() {
        
        let border = CALayer()
        border.backgroundColor = borderColor
        border.frame = CGRect(x: 0, y: 0, width: aboutScroll.frame.width, height: borderThickness)
        aboutScroll.layer.addSublayer(border)

    }
    
    func bottomPhotoScrollBorder() {
        
        let border = CALayer()
        border.backgroundColor = borderColor
        border.frame = CGRect(x: 0, y: photoScroll.frame.height - borderThickness, width: photoScroll.frame.width, height: borderThickness)
        
        photoScroll.layer.addSublayer(border)
        
    }
    
    func photoButtonBorder() {
        let border = CALayer()
        border.backgroundColor = borderColor
        border.frame = CGRect(x: photoButton.frame.width - borderThickness, y: 0, width: borderThickness, height: photoButton.frame.height)
        
        photoButton.layer.addSublayer(border)
    }
    
    func noteButtonBorder() {
        
        let border = CALayer()
        border.backgroundColor = borderColor
        border.frame = CGRect(x: noteButton.frame.width - borderThickness, y: 0, width: borderThickness, height: noteButton.frame.height)
        
        noteButton.layer.addSublayer(border)
        
    }
    
    //MARK: DataTransferProtocol
    
    func didPressDone(with note: String) {
        notesArray.append(note)
        tableView.reloadData()
    }
    
    //MARK: TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: noteCellIdentifier) as! NewsTableViewCell
        
        cell.prepare(with: notesArray[indexPath.row])
        
        return cell
    }
    
    //MARK: Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == infoSequeIdentifier {
            let profileVC = segue.destination as! InformationAboutUserTableViewController
            profileVC.name = (nameLabel.text)!
            profileVC.surname = (surnameLabel.text)!
            profileVC.age = (ageLabel.text)!
            profileVC.location = (locationLabel.text)!
            profileVC.avatarFrom = avatar.image!
        }
        
        if segue.identifier == noteSequeIdentifier {
            let controller = segue.destination as! NoteViewController
            controller.dataTransferDelagete = self
        }
    }
    
}


