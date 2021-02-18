//
//  ViewController.swift
//  UChat
//
//

import UIKit
import CLTypingLabel
import Firebase
class ViewController: UIViewController {
    //Text
    @IBOutlet weak var textLabel: CLTypingLabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //This will make the UChat string be like a keyboard typing format
        textLabel.text = "UChat"

    }
    @IBAction func loginButton(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            //Referring to Apendix 1.11
        // -------------------------------------------------------------------------------
        //When a user log in to the app, pass the user's email address and password to signInWithEmail:email:password:completion: in the database.
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            //If the user successfully signs in, you can get the user's account data from the result object that's passed to the database.
        // -------------------------------------------------------------------------------
            
            if let e = error{
                print(e)
            }else{
                //else navigate everything to the LoginToChat Segue
                self?.performSegue(withIdentifier: "LoginToChat", sender: self)
            }
        }
        }
    }
    

}

