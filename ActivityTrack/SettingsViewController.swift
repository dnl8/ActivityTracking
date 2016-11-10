//
//  SettingsViewController.swift
//  ActivityTrack
//
//  Created by Student on 03/11/16.
//  Copyright © 2016 Daniel Holzmann. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var userLoggedIn: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //comment
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userLoggedIn.text = "logged in as " + AppState.sharedInstance.displayName!
    }

    @IBAction func userLoggedOut(_ sender: UIButton) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            AppState.sharedInstance.signedIn = false
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
