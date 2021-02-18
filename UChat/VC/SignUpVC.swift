//
//  SignUpVC.swift
//  UChat
//
//

import UIKit
import CLTypingLabel
import Firebase
class SignUpVC: UIViewController {
    
    @IBOutlet weak var textLabel: CLTypingLabel!
//TextFields for email, password, age and name.
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = "UChat"
    }
    //Register Button
    @IBAction func registerButton(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            //Refferring to Apendix 1.11
//----------------------------------------------------------------------------------------
            //Create a new account by passing the new user's email address and password to the database
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            //If the new account was successfully created, the user is signed in, and you can get the user's account data from the result object that's passed to the callback method.
//----------------------------------------------------------------------------------------

        
            //let e error
            if let e = error{
            //  if the characters are less than 6 send an error
                print(e)
            } else {
            // if the character more than 6 navigate to the ChatVC
                self.performSegue(withIdentifier: "RegisterToChat", sender: self)
            }
        }

            }
    }
    

}

