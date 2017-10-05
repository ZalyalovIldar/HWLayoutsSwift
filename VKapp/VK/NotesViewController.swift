//
//  NotesViewController.swift
//  VK
//
//  Created by Elina on 02/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var postTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
        
        setupNavigationBar()

    }

    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupTextView() {
        postTextView.delegate = self
        postTextView.text = "Новая запись..."
        postTextView.textColor = UIColor.lightGray
    }
    
    //MARK: UITextViewDelegate
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if postTextView.textColor == UIColor.lightGray {
            postTextView.text = ""
            postTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if postTextView.text == "" {
            
            postTextView.text = "Новая запись..."
            postTextView.textColor = UIColor.lightGray
        }
    }
    



}
