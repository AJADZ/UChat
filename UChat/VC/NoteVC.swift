//
//  NoteVC.swift
//  UChat
//
//  Created by Mohammed Almansoori on 31/01/2021.
//

import UIKit

class NoteVC: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var noteLabel: UITextView!
    
    public var noteTitle: String = ""
    public var note: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = noteTitle
        noteLabel.text = note
    }

}
