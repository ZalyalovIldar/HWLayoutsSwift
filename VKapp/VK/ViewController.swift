//
//  ViewController.swift
//  VK
//
//  Created by Elina on 11/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var usersStatus: UILabel!
    
    @IBOutlet weak var ageAndCity: UILabel!
    
    @IBOutlet weak var userNameInToolBar: UINavigationItem!
    
    @IBOutlet weak var usersAvatar: UIImageView!
   
    @IBOutlet weak var informationButton: UIButton!
    
    @IBOutlet weak var scrollDescription: UIScrollView!
    
    @IBOutlet weak var scrollPhotos: UIScrollView!
    
    @IBOutlet weak var photoArrow: UIButton!
    
    @IBOutlet weak var usersImage: UIImageView!
    
    @IBOutlet weak var friendsCount: UIButton!
    
    @IBOutlet weak var followersCount: UIButton!
    
    @IBOutlet weak var groupsCount: UIButton!
    
    @IBOutlet weak var photosCount: UIButton!
    
    @IBOutlet weak var videosCount: UIButton!
    
    var users: [User] = [User(name: "Элина", surname: "Батырова", avatar: UIImage.init(named: "Elina")!, photos: [UIImage.init(named: "heart")!], status: "online (моб.)", profile: [Information(sectionName: "Изменить статус", rowsNames: [], rowsImages: [], rowsFilling: []), Information(sectionName: "", rowsNames: ["День рождения", "Семейное положение", "Языки", "Братья, сестры" ], rowsImages: [], rowsFilling: ["17 октября 1998", "не замужем", "русский, english", "Эльвира Батырова"]), Information(sectionName: "Контакты", rowsNames: [], rowsImages: [
        UIImage(named: "phone icon")!, UIImage(named: "home icon")!, UIImage(named: "vk icon")!], rowsFilling: ["89667845699", "Kazan, Nab.Chelny", "vk.com/id8888"]), Information(sectionName: "Карьера", rowsNames: ["iOS lab"], rowsImages: [UIImage(named:"ios icon")!], rowsFilling: ["iOS Developer"]), Information(sectionName: "Образование", rowsNames: ["Вуз", "Школа"], rowsImages: [], rowsFilling: ["КФУ (бывш. КГУ им. Ульянова-Ленина)", "Лицей 78 им.А.С.Пушкина"]), Information(sectionName: "Подарки", rowsNames: [], rowsImages: [], rowsFilling: []), Information(sectionName: "", rowsNames: ["Интересные страницы", "Заметки", "Документы"], rowsImages: [], rowsFilling: ["12", "3","56"])] ), User(name: "Эльвира", surname: "Батырова", avatar: UIImage.init(named: "Elvira")!, photos: [UIImage.init(named: "heart")!], status: "online", profile: [] ), User(name: "Айгуль", surname: "Ризатдинова", avatar: UIImage.init(named: "Information")!, photos: [UIImage.init(named: "heart")!], status: "offline", profile: [] )]
    
    var photoButtonLabel = "фото"
    var arrowButtonLabel = "фотографий"
    var friendsButtonLabel = "друзей"
    var followersButtonLabel = "подписчиков"
    var groupsButtonLabel = "групп"
    var videosButtonLabel = "видео"
    var space = " "
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomFilling()
        setupNavigationBar()
        
        informationButton.addTarget(self, action: #selector(informationButtonPressed), for: .touchDragEnter)
      
    }
  
    
    func informationButtonPressed() {
        performSegue(withIdentifier: "info", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info" && sender != nil {
            
            let destinationTVC = segue.destination as! ProfileTableViewController
            
            destinationTVC.nameAndSurname = name.text!
            
            destinationTVC.ageAndCity = ageAndCity.text!
            
            destinationTVC.status = usersStatus.text!
            
            destinationTVC.usersPhoto = usersAvatar.image
            
            destinationTVC.usersNameForToolBar = users[index].name
            
            // Уберем текст backitem следующего контроллера
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    func randomFilling() {
        index = Int(arc4random_uniform(UInt32(users.count)))
        
        name.text = users[index].name + space + users[index].surname
        
        userNameInToolBar.title = users[index].name
        
        usersAvatar.image = users[index].avatar
        
        usersImage.image = users[index].photos.first
        
        let randomCountForPhotos = Int(arc4random_uniform(UInt32(1000)))
        
        let titleForPhotos = NSAttributedString(string: randomCountForPhotos.description + space + photoButtonLabel,
                                                attributes: [NSForegroundColorAttributeName : UIColor.black] )
        photosCount.setAttributedTitle(titleForPhotos, for: .normal)
        photosCount.titleLabel?.textAlignment = NSTextAlignment.center
        
        let titleForPhotoArrow = NSAttributedString(string: randomCountForPhotos.description + space + arrowButtonLabel,
                                                    attributes: [NSForegroundColorAttributeName : UIColor.black] )
        photoArrow.setAttributedTitle(titleForPhotoArrow, for: .normal)
        
        
        let randomCountForFriends = Int(arc4random_uniform(UInt32(1000)))
        
        let titleForFriends = NSAttributedString(string: randomCountForFriends.description + space + friendsButtonLabel,
                                                 attributes: [NSForegroundColorAttributeName : UIColor.black])
        friendsCount.setAttributedTitle(titleForFriends, for: .normal)
        friendsCount.titleLabel?.textAlignment = NSTextAlignment.center
        
        
        let randomCountForFollowers = Int(arc4random_uniform(UInt32(1000)))
        
        let titleForFollowers = NSAttributedString(string: randomCountForFollowers.description + space + followersButtonLabel,
                                                   attributes: [NSForegroundColorAttributeName : UIColor.black])
        followersCount.setAttributedTitle(titleForFollowers, for: .normal)
        followersCount.titleLabel?.textAlignment = NSTextAlignment.center
        
        
        let randomCountForGroups = Int(arc4random_uniform(UInt32(1000)))
        
        let titleForGroups = NSAttributedString(string: randomCountForGroups.description + space + groupsButtonLabel,
                                                attributes: [NSForegroundColorAttributeName : UIColor.black])
        groupsCount.setAttributedTitle(titleForGroups, for: .normal)
        groupsCount.titleLabel?.textAlignment = NSTextAlignment.center
        
        let randomCountForVideos = Int(arc4random_uniform(UInt32(1000)))
        
        let titleForVideos = NSAttributedString(string: randomCountForVideos.description + space + videosButtonLabel,
                                                 attributes: [NSForegroundColorAttributeName : UIColor.black])
        videosCount.setAttributedTitle(titleForVideos, for: .normal)
        videosCount.titleLabel?.textAlignment = NSTextAlignment.center
    }
}

