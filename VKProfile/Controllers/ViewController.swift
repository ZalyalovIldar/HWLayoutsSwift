//
//  ViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 11.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, CreateNewsDelegate {

    @IBOutlet weak var infoScrollView: UIScrollView!
    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet var menuButtons: [UIButton]!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onlineStatusLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet weak var buttonsView: UIView!
    
    var count = 0
    var user: User!
    var infoButtons = [UIButton]()
    var indentionButtonConstraints = [NSLayoutConstraint]()
    var imageViews = [UIImageView]()
    var indentionImageViewConstraints = [NSLayoutConstraint]()
    let defaultIndention: CGFloat = 8
    let photo = "фото"
    let audio = "аудио"
    let video = "видео"
    let seperator = ","
    
    let infoIdentifierSegue = "infoSegue"
    let followersIdentifierSegue = "followersSegue"
    let createNewsIdentifierSegue = "createNewsSegue"
    
    let newsCellIdentefier = "newsCell"
    var news = [News]()
    
    let buttonCounts = 8
    let fontName = "Arial"
    
    //Buttons section
    let friendsButton = 0
    let followersButton = 1
    let groupsButton = 2
    let albumButton = 3
    let videosButton = 4
    let audiosButton = 5
    let presentsButton = 6
    let filesButton = 7
    let createNewsButton = 0
    let takePhotoButton = 1
    
    let imageWidth: CGFloat = 129
    let imageHeight: CGFloat = 97
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        user = generateUser()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        registerCell()
        setLabels()
        createButtons()
        createImageViews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - initialize methods
    
    private func registerCell() {
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: newsCellIdentefier)
    }
    
    @objc private func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            changeDistance(in: infoScrollView, with: infoButtons, constraints: indentionButtonConstraints)
            changeDistance(in: photoScrollView, with: imageViews, constraints: indentionImageViewConstraints)
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            indentionButtonConstraints.forEach { $0.constant = defaultIndention }
            indentionImageViewConstraints.forEach { $0.constant = defaultIndention }
        }
    }
    
    private func createButtons() {
        let textSize:CGFloat = 15
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        guard let font = UIFont(name: fontName, size: textSize) else { return }
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.paragraphStyle.rawValue): paragraph, NSAttributedStringKey.font: font]
        
        for _ in 0 ..< buttonCounts {
            let button = UIButton()
            button.titleLabel?.lineBreakMode = .byCharWrapping
            button.translatesAutoresizingMaskIntoConstraints = false
            infoButtons.append(button)
        }

        for (i, button) in infoButtons.enumerated() {
            infoScrollView.addSubview(button)

            guard let superview = button.superview else { return }
            let leftView = (i == 0) ? superview : infoButtons[i - 1]
            let yCenterConstraint = NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0)
            let leadingConstraint = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: leftView, attribute: .trailing, multiplier: 1, constant: 8)
            indentionButtonConstraints.append(leadingConstraint)

            NSLayoutConstraint.activate([yCenterConstraint, leadingConstraint])
        }
        
        setTitle(with: infoButtons[friendsButton], count: user.friends, declinationWord: DeclinationWordDictionary.friend, attributes: attributes)
        setTitle(with: infoButtons[followersButton], count: user.followers.count, declinationWord: DeclinationWordDictionary.follower, attributes: attributes)
        setTitle(with: infoButtons[groupsButton], count: user.groups, declinationWord: DeclinationWordDictionary.group, attributes: attributes)
        setTitle(with: infoButtons[albumButton], count: user.photos.count, word: photo, attributes: attributes)
        setTitle(with: infoButtons[videosButton], count: user.videos, word: video, attributes: attributes)
        setTitle(with: infoButtons[audiosButton], count: user.audios, word: audio, attributes: attributes)
        setTitle(with: infoButtons[presentsButton], count: user.presents, declinationWord: DeclinationWordDictionary.present, attributes: attributes)
        setTitle(with: infoButtons[filesButton], count: user.files, declinationWord: DeclinationWordDictionary.file, attributes: attributes)
        
        infoButtons[createNewsButton].addTarget(self, action: #selector(onFollowersClick), for: .touchUpInside)
        
    }
    
    private func createImageViews() {
        for _ in 0 ..< user.photos.count {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageViews.append(imageView)
        }
        
        for (i, imageView) in imageViews.enumerated() {
            photoScrollView.addSubview(imageView)
            
            guard let superview = imageView.superview else { return }
            let leftView = (i == 0) ? superview : imageViews[i - 1]
            
            let yCenterConstraint = NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0)
            let leadingConstraint = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: leftView, attribute: .trailing, multiplier: 1, constant: defaultIndention)
            indentionImageViewConstraints.append(leadingConstraint)
            let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: imageWidth)
            let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: imageHeight)
            
            NSLayoutConstraint.activate([yCenterConstraint, leadingConstraint, widthConstraint, heightConstraint])
            
            imageView.image = user.photos[i]
        }
    }
    
    private func changeDistance(in scrollView: UIScrollView, with elements: [UIView], constraints: [NSLayoutConstraint]) {
        let screenWidth = UIScreen.main.bounds.width
        var elementsWidth: CGFloat = 0
        elements.forEach { elementsWidth += $0.frame.width }
        let newDistance = (screenWidth - defaultIndention * 2 - elementsWidth) / CGFloat(elements.count)
        constraints.forEach { $0.constant = newDistance }
    }
    
    override func viewDidLayoutSubviews() {
        setContentSize(with: infoScrollView, elements: infoButtons, indention: defaultIndention)
        setContentSize(with: photoScrollView, elements: imageViews, indention: defaultIndention)
        createStyles()
    }
    
    private func setContentSize(with scrollView: UIScrollView, elements: [UIView], indention: CGFloat) {
        let heightContent = scrollView.frame.height
        var widthContent: CGFloat = 0
        
        elements.forEach { widthContent += $0.frame.width + indention }
        scrollView.contentSize = CGSize(width: widthContent, height: heightContent)
    }
    
    private func createStyles() {
        let defaultMarginX:CGFloat = 10
        
        infoScrollView.createBorders(on: .bottom, marginX: defaultMarginX)
        infoScrollView.createBorders(on: .top, marginX: defaultMarginX)
        buttonsView.createBorders(on: .top, marginX: defaultMarginX)
        menuButtons[createNewsButton].createBorders(on: .right, marginX: defaultMarginX)
        menuButtons[takePhotoButton].createBorders(on: .right, marginX: defaultMarginX)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x3180d6)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        avatarImage.roundCorners()
        self.view.layoutIfNeeded()
    }
    
    private func generateUser() -> User {
        var user = UserInfoData.generateUser()
        for _ in 0 ..< 25 {
            user.followers.append(UserInfoData.generateUser())
        }
        user.followers[0].onlineStatus = .computer
        return user
    }
    
    private func setLabels() {
        self.title = user.name
        nameLabel.text = user.name + " " + user.surname
        onlineStatusLabel.text = user.onlineStatus.rawValue
        
        ageLabel.text = String(user.age)
        yearsLabel.text = EndingWord.getCorrectEnding(with: user.age, and: DeclinationWordDictionary.age) + seperator
        cityLabel.text = user.city
        
        let photoCount = user.photos.count
        let photoTitle = EndingWord.getCorrectEnding(with: photoCount, and: DeclinationWordDictionary.photograph)
        photosButton.setTitle("\(photoCount) " + photoTitle, for: .normal)
        
        avatarImage.image = user.profileImage
    }
    
    //MARK: - button methods
    
    private func setTitle(with button: UIButton, count: Int, declinationWord: DeclinationWord, attributes: [NSAttributedStringKey : Any]) {
        let title = EndingWord.getCorrectEnding(with: count, and: declinationWord)
        let attrString = NSAttributedString(string: "\(count)" + "\n" + title, attributes: attributes)
        button.setAttributedTitle(attrString, for: .normal)
    }
    
    private func setTitle(with button: UIButton, count: Int, word: String, attributes: [NSAttributedStringKey : Any]) {
        let attrString = NSAttributedString(string: "\(count)" + "\n" + word, attributes: attributes)
        button.setAttributedTitle(attrString, for: .normal)
    }
    
    func createNews(from newsData: News) {
        news.append(newsData)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func onFollowersClick(sender: UIButton!) {
        performSegue(withIdentifier: followersIdentifierSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == followersIdentifierSegue) {
            let followerTVC = segue.destination as! FollowersTableViewController
            followerTVC.followers = user.followers
        } else if (segue.identifier == infoIdentifierSegue) {
            let backItem = UIBarButtonItem()
            self.navigationItem.backBarButtonItem = backItem
            
            let infoTVC = segue.destination as! InfoTableViewController
            infoTVC.user = user
        } else if (segue.identifier == createNewsIdentifierSegue) {
            let noteVC = segue.destination as! NoteViewController
            noteVC.createNewsDelegate = self
        }
    }
    
    //MARK: - TableView methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentefier, for: indexPath) as! NewsTableViewCell
        
        let news = self.news[indexPath.row]
        cell.prepareCell(with: news)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}










