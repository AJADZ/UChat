//
//  EntryVC.swift
//  UChat
//
//  Created by Mohammed Almansoori on 31/01/2021.
//

import UIKit

class EntryVC: UIViewController {
    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    
    public var completion: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }

    @objc func didTapSave() {
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            completion?(text, noteField.text)
        }
    }

}
