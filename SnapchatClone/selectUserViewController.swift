//
//  selectUserViewController.swift
//  SnapchatClone
//
//  Created by William Schoettler on 10/8/17.
//  Copyright © 2017 William Schoettler. All rights reserved.
//

import UIKit
import Firebase

class selectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    var imageURL = ""
    var descrip = ""
    var uuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            
            // Not sure why, but according to Google we have to do this to access the database entry info
            let snapshotValue = snapshot.value as? NSDictionary
            
            // Assign information from the database item to a user object
            let user = User()
            user.email = snapshotValue!["email"] as! String
            user.uid = snapshot.key
            
            // Add the user to our array of users
            self.users.append(user)
            
            // Reload the tableview to show the available users
            self.tableView.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get user that was selected
        let user = users[indexPath.row]
        
        let snap = ["from":Auth.auth().currentUser?.email!, "description":descrip, "imageURL":imageURL, "uuid":uuid]
        print("##########################################")
        print("Snap contents:")
        print(snap)
        print("##########################################")
        
        // Create a new snap assigned to the user specified by the user id (uid)
        // childByAutoId() makes sure that you create a new item and don't just overwrite an existing one
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        // Pop back to original (root) view controller - the screen after sign-in, where the navigation controller points (List of snaps received)
        navigationController!.popToRootViewController(animated: true)
    }
    
}
