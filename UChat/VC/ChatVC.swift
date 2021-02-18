//
//  ChatVC.swift
//  UChat
//
//

import UIKit
import Firebase
class ChatVC: UIViewController {
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    let db = Firestore.firestore()
    
    //Data type of message
    var messages: [Message] = [
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //it will look on the chatVC and trager the deleget method 'extension' in order to get the data it needs
        tableView.dataSource = self
        
        navigationItem.hidesBackButton = true
        title = "UChat"
        
        //registering the tableview cell to the ChatVC page.
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    func loadMessages(){
        // It will tap into my database to be able to retrieve the data from database
            //The addSnapshotListener is going to listien for changes in the collectionName, when ever a new item is added it will gonna trigger all of the code inside this closure.
        
        db.collection(K.FStore.collectionName)
            //This will make the messages in there correct order based on the dates that the message were published.
            //Refferring to Apendix 1.12
//----------------------------------------------------------------------------------------
            .order(by: K.FStore.dateField)
//----------------------------------------------------------------------------------------
            .addSnapshotListener { (querySnapshot, error) in
            //messages array will be empty arrat so I can clear it out.
            //Whenever a new item is added to our collection, it will empty out the user messages array, and add the new messages into it, without reprinting all the messages again.
            self.messages = []
            if let e = error{
                print("There was an issue retrieving data from Firebase.\(e)")
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField]as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                
                                //will allow the user to scroll through the messages.
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        //It will be the constants that will store the message body
                                                //if their is a current user message, then it going to get a hold of their email and save it inside the messageSender property.
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField: messageSender,
            K.FStore.bodyField: messageBody,
            //It will give the number of seconds sine January the 1st at zero hour in 1970, as this will make the texts that are added in there correct placement not mixed up based on the date.
            K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error{
                    print("There was an issue saving data to firestore,\(e)")
                }else{
                    print("Successfully saved data.")
                    //The message text field will empthy out after sending a message
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
        //if we have a current user, then we're going to get a hold of their email and save it inside the messageSender property.
    }
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        //Refferring to Apendix 1.11
        //--------------------------------------------------------------------------------
    //To sign out a user.
    do {
        try Auth.auth().signOut()
        navigationController?.popViewController(animated: true)
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
      //----------------------------------------------------------------------------------
    }
    

}
//extened the chatVC to be able to adobt the UITableViewDataSource
extension ChatVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //it will print the messages on the page depended on how much messages the users have sent to communicate with each other.
        return messages.count
    }
    
    //This method is asking for a UITableViewCell that it should display in each and every row of our table view in chatVC.
    //I should create a cell and return it to the tableView.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        //Create an cell that will be equal to tableView.dequeueReusableCell.
        //This could return a reusable cell object for the specified reuse identifier and adds it to the tableView.
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        //if the sender is the same as the current user.
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        //This is a message from another sender
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        //It will be edit the textLabel property and that will correspond to the main label in the cell
                            //when the tableView is requesting the data for the 0 row, then this is going to equal to zero and it's going to pull out the message at position 0 on messages, and only print the body.
        cell.label.text = messages[indexPath.row].body
        return cell
    }
}
