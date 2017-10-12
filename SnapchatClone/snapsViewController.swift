//
//  snapsViewController.swift
//  SnapchatClone
//
//  Created by William Schoettler on 10/7/17.
//  Copyright © 2017 William Schoettler. All rights reserved.
//

import UIKit
import Firebase

class snapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var snaps : [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            
            // Not sure why, but according to Google we have to do this to access the database entry info
            let snapshotValue = snapshot.value as? NSDictionary
            
            
            // Assign information from the database item to a user object
            let snap = Snap()
            snap.imageURL = snapshotValue!["imageURL"] as! String
            snap.descrip = snapshotValue!["description"] as! String
            snap.from = snapshotValue!["from"] as! String
            snap.uuid = snapshotValue!["uuid"] as! String
            snap.key = snapshot.key
            
            // Add the user to our array of users
            self.snaps.append(snap)
            
            // Reload the tableview to show the available users
            self.tableView.reloadData()
        })
        
        //If a snap has been removed, take action
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childRemoved, with: { (snapshot) in
            
            var index = 0
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            
            // Reload the tableview to show the available users
            self.tableView.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if snaps.count == 0 {
            return 1
        } else {
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if snaps.count == 0 {
            cell.textLabel?.text = "You have no snaps 😪"
            return cell
        } else {
            let snap = snaps[indexPath.row]
            
            cell.textLabel?.text = snap.from
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSnapSegue" {
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        //Dismisses the snapsViewController and returns us to the previous view controller (the Login Screen)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
