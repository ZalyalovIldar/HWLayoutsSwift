//
//  ProfileTableViewController.swift
//  VK
//
//  Created by Elina on 22/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    let mainInfoIdentifier = "mainInformationCell"
    let contactsIdentifier = "contactsCell"
    let careerIdentifier = "careerCell"
    let educationIdentifier = "educationCell"
    let interestsIdentifier = "interestsCell"
    let statusIdentifier = "statusCell"
    let giftsIdentifier = "giftsCell"
    let headerIdentifier = "headerCell"
    let labelIdentifier = "LabelCell"

    
    @IBOutlet weak var usersAvatar: UIImageView!
    
    @IBOutlet weak var usersName: UILabel!
    
    @IBOutlet weak var usersStatus: UILabel!
    
    @IBOutlet weak var usersAgeAndCity: UILabel!
    
    @IBOutlet weak var nameInToolBar: UINavigationItem!
    
    var nameAndSurname = ""
    var status = ""
    var usersPhoto = UIImage(named:"empty")
    var ageAndCity = ""
    var usersNameForToolBar = ""
    
    var statusSection = 0
    var mainInformationSection = 1
    var contactsSection = 2
    var careerSection = 3
    var educationSection = 4
    var giftsSection = 5
    var interestsSection = 6
    var interestsSectionRowHeight = 65
    var sectionsRowHeight = 70
    var mainInfoHeaderHeight = 3
    var giftsHeaderHeight = 70
    var headerHeight = 30
    
    var profileUser = User(name: "Элина", surname: "Батырова", avatar: UIImage.init(named: "Elina")!, photos: [UIImage.init(named: "heart")!], status: "online (моб.)", profile: [Information(sectionName: "Изменить статус", rowsNames: [], rowsImages: [], rowsFilling: []), Information(sectionName: "", rowsNames: ["День рождения", "Семейное положение", "Языки", "Братья, сестры" ], rowsImages: [], rowsFilling: ["17 октября 1998", "не замужем", "русский, english", "Эльвира Батырова"]), Information(sectionName: "Контакты", rowsNames: [], rowsImages: [
        UIImage(named: "phone icon")!, UIImage(named: "home icon")!, UIImage(named: "vk icon")!], rowsFilling: ["89667845699", "Kazan, Nab.Chelny", "vk.com/id8888"]), Information(sectionName: "Карьера", rowsNames: ["iOS lab"], rowsImages: [UIImage(named:"ios icon")!], rowsFilling: ["iOS Developer"]), Information(sectionName: "Образование", rowsNames: ["Вуз", "Школа"], rowsImages: [], rowsFilling: ["КФУ (бывш. КГУ им. Ульянова-Ленина)", "Лицей 78 им.А.С.Пушкина"]), Information(sectionName: "Подарки", rowsNames: [], rowsImages: [], rowsFilling: []), Information(sectionName: "", rowsNames: ["Интересные страницы", "Заметки", "Документы"], rowsImages: [], rowsFilling: ["12", "3","56"])] )
    
    var anotherUsersInformation: [Information] = [Information(sectionName: "Изменить статус", rowsNames: [], rowsImages: [], rowsFilling: []), Information(sectionName: "", rowsNames: ["День рождения", "Семейное положение", "Языки", "Братья, сестры" ], rowsImages: [], rowsFilling: ["24 мая 1996", "не замужем", "русский, english", "Элина Батырова"]), Information(sectionName: "Контакты", rowsNames: [], rowsImages: [
    UIImage(named: "phone icon")!, UIImage(named: "home icon")!, UIImage(named: "vk icon")!], rowsFilling: ["89667777799", "Kazan, Nab.Chelny", "vk.com/id8888"]), Information(sectionName: "Карьера", rowsNames: ["iOS lab"], rowsImages: [UIImage(named:"ios icon")!], rowsFilling: ["iOS Developer"]), Information(sectionName: "Образование", rowsNames: ["Вуз", "Школа"], rowsImages: [], rowsFilling: ["МГУ", "Лицей 78 им.А.С.Пушкина"]), Information(sectionName: "Подарки", rowsNames: [], rowsImages: [], rowsFilling: []), Information(sectionName: "", rowsNames: ["Интересные страницы", "Заметки", "Документы"], rowsImages: [], rowsFilling: ["178", "5","90"])]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        usersAvatar.image = usersPhoto
        usersName.text = nameAndSurname
        usersAgeAndCity.text = ageAndCity
        nameInToolBar.title = usersNameForToolBar
        
        randomFilling()
        
        setupRefreshControl()
        
        nibsRegister()
        
    }
    
    func randomFilling() {
        let randomNumber = Int(arc4random_uniform(UInt32(2)))
        if randomNumber == 1 {
            profileUser.profile = anotherUsersInformation
        }
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func refreshTableView(sender: UIRefreshControl) {
        
        usersAvatar.image = UIImage(named: "ios icon")
        
        self.tableView.reloadData()
        
        sender.endRefreshing()
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    func nibsRegister() {
        
        let mainInfoNib = UINib(nibName: "CustomCellForMainInformation", bundle: nil)
        tableView.register(mainInfoNib, forCellReuseIdentifier: mainInfoIdentifier)
        
        let contactsNib = UINib(nibName: "ContactsCell", bundle: nil)
        tableView.register(contactsNib, forCellReuseIdentifier: contactsIdentifier)
        
        let careerNib = UINib(nibName: "CareerTableViewCell", bundle: nil)
        tableView.register(careerNib, forCellReuseIdentifier: careerIdentifier)
        
        let educationNib = UINib(nibName: "EducationTableViewCell", bundle: nil)
        tableView.register(educationNib, forCellReuseIdentifier: educationIdentifier)
        
        let interestsNib = UINib(nibName: "InterestsTableViewCell", bundle: nil)
        tableView.register(interestsNib, forCellReuseIdentifier: interestsIdentifier)
        
        let statusNib = UINib(nibName: "StatusCustomTableViewCell", bundle: nil)
        tableView.register(statusNib, forCellReuseIdentifier: statusIdentifier)
        
        let giftsNib = UINib(nibName: "GiftsTableViewCell", bundle: nil)
        tableView.register(giftsNib, forCellReuseIdentifier: giftsIdentifier)
        
        let headerNib = UINib(nibName: "CustomHeaderCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: headerIdentifier)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return profileUser.profile.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return profileUser.profile[section].rowsFilling.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == mainInformationSection {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: mainInfoIdentifier) as! MainInformationTableViewCell
            
            cell.prepareCell(with: profileUser, cellForRowAt: indexPath)
            
            return cell
            
        }
        
        if indexPath.section == contactsSection {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: contactsIdentifier) as! ContactsTableViewCell
            
            cell.prepareCell(with: profileUser, cellForRowAt: indexPath)
            
            return cell
            
        }
        
        if indexPath.section == careerSection {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: careerIdentifier) as! CareerTableViewCell
            
            cell.prepareCell(with: profileUser, cellForRowAt: indexPath)
            
            return cell
            
        }
        
        if indexPath.section == educationSection {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: educationIdentifier) as! EducationTableViewCell
            
            cell.prepareCell(with: profileUser, cellForRowAt: indexPath)
            
            return cell
            
        }
        
        if indexPath.section == interestsSection {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: interestsIdentifier) as! InterestsTableViewCell
            
            cell.prepareCell(with: profileUser, cellForRowAt: indexPath)
            
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: labelIdentifier, for: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"

        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == interestsSection {
            return CGFloat(interestsSectionRowHeight)
        }
        return CGFloat(interestsSectionRowHeight)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        if section == statusSection {
            
        let headerCell = tableView.dequeueReusableCell(withIdentifier: statusIdentifier) as! StatusTableViewCell
            
        headerView.addSubview(headerCell)
            
            return headerView
        }
        
        if section == giftsSection {
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: giftsIdentifier) as! GiftsTableViewCell
            
            headerView.addSubview(headerCell)
            
            return headerView
        }
            
        let headerCell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier) as! CustomHeaderTableViewCell
        
        headerCell.prepareCell(with: profileUser, viewForHeaderInSection: section)
        headerView.addSubview(headerCell)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == mainInformationSection {
            return CGFloat(mainInfoHeaderHeight)
        }
        
        if section == giftsSection {
            return CGFloat(giftsHeaderHeight)
        }
        return CGFloat(headerHeight)
    }
   
}
