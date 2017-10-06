//
//  NoteViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 02/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var noteTextView: UITextView!
    
    var dataTransferDelagete: DataTransferProtocol?
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        guard let note = noteTextView.text else { return }
        
        dataTransferDelagete?.didPressDone(with: note)
        
        dismiss(animated: true, completion: nil)
    }
}
