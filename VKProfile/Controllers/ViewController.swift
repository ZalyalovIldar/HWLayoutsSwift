//
//  ViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 11.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

fileprivate enum BorderPosition {
    case top
    case bottom
    case right
    case left
}

class ViewController: UIViewController {

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
    let photo = "фото"
    let audio = "аудио"
    let video = "видео"
    let seperator = ","
    let infoIdentifier = "infoSegue"
    let followersIdentifier = "followersSegue"
    let defaultIndention: CGFloat = 8
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = generateUser()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        setLabels()
        createButtons()
        createImageViews()
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
        let buttonCounts = 8
        let fontName = "Arial"
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
        
        setTitle(with: infoButtons[0], count: user.friends, declinationWord: DeclinationWordDictionary.friend, attributes: attributes)
        setTitle(with: infoButtons[1], count: user.followers.count, declinationWord: DeclinationWordDictionary.follower, attributes: attributes)
        setTitle(with: infoButtons[2], count: user.groups, declinationWord: DeclinationWordDictionary.group, attributes: attributes)
        setTitle(with: infoButtons[3], count: user.photos.count, word: photo, attributes: attributes)
        setTitle(with: infoButtons[4], count: user.videos, word: video, attributes: attributes)
        setTitle(with: infoButtons[5], count: user.audios, word: audio, attributes: attributes)
        setTitle(with: infoButtons[6], count: user.presents, declinationWord: DeclinationWordDictionary.present, attributes: attributes)
        setTitle(with: infoButtons[7], count: user.files, declinationWord: DeclinationWordDictionary.file, attributes: attributes)
        
        infoButtons[1].addTarget(self, action: #selector(onFollowersClick), for: .touchUpInside)
        
    }
    
    private func createImageViews() {
        let imageWidth: CGFloat = 129
        let imageHeight: CGFloat = 97
        
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
        let indentation: CGFloat = 8
        var elementsWidth: CGFloat = 0
        elements.forEach { elementsWidth += $0.frame.width }
        let newDistance = (screenWidth - indentation * 2 - elementsWidth) / CGFloat(elements.count)
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
    
    private func createBorders(to view: UIView, on position: BorderPosition) {
        let borderWidth = CGFloat(2.0)
        let marginX = CGFloat(10)
        var borderLength = CGFloat(UIScreen.main.bounds.width - marginX * 2)
        let borderColor = UIColor(rgb: 0xdbd6d6).cgColor
        let borderMargin: CGFloat = 1.0
        let noneMargin:CGFloat = 0
        
        if (view is UIScrollView) {
            borderLength = UIScreen.main.bounds.height - marginX * 2
        }
        
        switch position {
        case .top:
            let borderTop = CALayer()
            borderTop.borderColor = borderColor
            borderTop.frame = CGRect(x: marginX, y: noneMargin, width: borderLength, height: borderMargin)
            borderTop.borderWidth = borderWidth
            
            view.layer.addSublayer(borderTop)
            view.layer.masksToBounds = true
            break
        case .bottom:
            let borderBottom = CALayer()
            borderBottom.borderColor = borderColor
            borderBottom.frame = CGRect(x: marginX, y: view.frame.height - borderMargin, width: borderLength, height: view.frame.height - borderMargin)
            borderBottom.borderWidth = borderWidth
            
            view.layer.addSublayer(borderBottom)
            view.layer.masksToBounds = true
            break
        case .right:
            let borderRight = CALayer()
            borderRight.borderColor = borderColor
            borderRight.frame = CGRect(x: view.frame.width - borderMargin, y: noneMargin, width: borderMargin, height: view.frame.height)
            borderRight.borderWidth = borderWidth
            
            view.layer.addSublayer(borderRight)
            break
        case .left:
            let borderLeft = CALayer()
            borderLeft.borderColor = borderColor
            borderLeft.frame = CGRect(x: noneMargin, y: noneMargin, width: borderMargin, height: view.frame.height)
            
            view.layer.addSublayer(borderLeft)
            break
        }
    }
    
    private func createStyles() {
        createBorders(to: infoScrollView, on: .bottom)
        createBorders(to: infoScrollView, on: .top)
        createBorders(to: buttonsView, on: .top)
        createBorders(to: menuButtons[1], on: .right)
        createBorders(to: menuButtons[0], on: .right)
        
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
    
    private func setTitle(with button: UIButton, count: Int, declinationWord: DeclinationWord, attributes: [NSAttributedStringKey : Any]) {
        let title = EndingWord.getCorrectEnding(with: count, and: declinationWord)
        let attrString = NSAttributedString(string: "\(count)" + "\n" + title, attributes: attributes)
        button.setAttributedTitle(attrString, for: .normal)
    }
    
    private func setTitle(with button: UIButton, count: Int, word: String, attributes: [NSAttributedStringKey : Any]) {
        let attrString = NSAttributedString(string: "\(count)" + "\n" + word, attributes: attributes)
        button.setAttributedTitle(attrString, for: .normal)
    }
    
    @IBAction func onInfoClick(_ sender: UIButton) {
        if (count == 5) {
            user = generateUser()
            setLabels()
            count = 0
        } else {
            count += 1
        }
    }
    
    @objc private func onFollowersClick(sender: UIButton!) {
        performSegue(withIdentifier: followersIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == followersIdentifier) {
            let followerTVC = segue.destination as! FollowersTableViewController
            followerTVC.followers = user.followers
        } else if (segue.identifier == infoIdentifier) {
            let backItem = UIBarButtonItem()
            self.navigationItem.backBarButtonItem = backItem
            
            let infoTVC = segue.destination as! InfoTableViewController
            infoTVC.user = user
        }
        
    }
    
}










