//
//  WelcomeScreenViewController.swift
//  RegisterAndLoginTask
//
//  Created by Shuja Hasan on 25/10/2016.
//  Copyright © 2016 Shuja Hasan. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    @IBOutlet var accessTokenLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let prefs:UserDefaults = UserDefaults.standard
        let accessToken:NSString = prefs.value(forKey: "accessToken") as! NSString
        
        if(accessToken.length > 0) {
            // Set it in the label
            accessTokenLabel.text = accessToken as String
        }
        else {
            accessTokenLabel.text = "No access token available!"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
