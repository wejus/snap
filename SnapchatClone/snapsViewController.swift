//
//  snapsViewController.swift
//  SnapchatClone
//
//  Created by William Schoettler on 10/7/17.
//  Copyright © 2017 William Schoettler. All rights reserved.
//

import UIKit

class snapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        //Dismisses the snapsViewController and returns us to the previous view controller (the Login Screen)
        dismiss(animated: true, completion: nil)
    }

    

}
