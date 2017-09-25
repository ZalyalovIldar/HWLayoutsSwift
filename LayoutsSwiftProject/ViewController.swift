//
//  ViewController.swift
//  LayoutsSwiftProject
//
//  Created by Ildar Zalyalov on 25.09.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var showUserGeolocationButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var showUserGeolocationWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if view.bounds.width < 600 {
            
            showUserGeolocationWidthConstraint.constant = 50
        }
        
//        let totalWidth = blueView.frame.size.width * 2
//        scrollView.contentSize = CGSize(width: totalWidth, height: scrollView.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - My methods
    
    
    /// Что то делает
    ///
    /// - Parameters:
    ///   - int: тут что то
    ///   - double: и тут
    func someFunc(with int: Int, and double: Double) {
        
    }
    
    
    //MARK: - UITableViewDatasource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        
        
        return cell
        
    }
}

