//  NotesFirstPageVC.swift
//  UChat
import UIKit
class NotesFirstPageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    //Varible
    var models: [(title: String, note: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //This allows when a user create an new meeting to send messages to meeting page.
        table.delegate = self
        
        table.dataSource = self
        title = "Meeting"
    }
    @IBAction func didTapNewNote(){
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? EntryVC else {
            return}
        vc.title = "New Meeting"
        vc.navigationItem.largeTitleDisplayMode = .never
        
        vc.completion = { noteTitle, note in
            //navigate to EntryVC
            self.navigationController?.popToRootViewController(animated: true)
            self.models.append((title: noteTitle, note: note))
            
            //hide the label
            self.label.isHidden = true
            
            //Dont hide the table
            self.table.isHidden = false
            
            //refuse the table to check if there is new data have been sent to be stored.
            self.table.reloadData()}
        
        navigationController?.pushViewController(vc, animated: true)}
    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //it will print the messages on the page depended on how many meeting were created by the users.
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create an cell that will be equal to tableView.dequeueReusableCell.
        //This could return a reusable cell object for the specified reuse identifier and adds it to the tableView.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]

        // Show note controller
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteVC else {
            return
        }
        
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
        vc.noteTitle = model.title
        vc.note = model.note
        
        //navigate to NoteVC
        navigationController?.pushViewController(vc, animated: true)
    }
}
