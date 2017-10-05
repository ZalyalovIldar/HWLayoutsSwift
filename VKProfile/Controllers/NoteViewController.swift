//
//  NoteViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 02.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var createNewsDelegate: CreateNewsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor.white
        navigationBar.createBorders(on: .bottom, marginX: 0)
        newsTextView.delegate = self
    }

    @IBAction func onCancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDoneClick(_ sender: Any) {
        guard let mainText = newsTextView.text else { return }
        let news = News(text: mainText)
        
        createNewsDelegate?.createNews(from: news)
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
