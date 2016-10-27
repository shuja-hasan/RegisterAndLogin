//
//  RegisterViewController.swift
//  RegisterAndLoginTask
//
//  Created by Shuja Hasan on 25/10/2016.
//  Copyright © 2016 Shuja Hasan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailAddressTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var registeringUserLabel : UILabel!
    @IBOutlet var registerButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func resetUI() {
        registerButton.isHidden = false
        emailAddressTextField.isHidden = false
        passwordTextField.isHidden = false
        registeringUserLabel.isHidden = true
        
        if(emailAddressTextField.isFirstResponder) {
            emailAddressTextField.resignFirstResponder()
        }
        if(passwordTextField.isFirstResponder) {
            passwordTextField.resignFirstResponder()
        }
    }
    
    func updateUIToShowProgress() {
        registerButton.isHidden = true
        emailAddressTextField.isHidden = true
        passwordTextField.isHidden = true
        registeringUserLabel.isHidden = false
        
        if(emailAddressTextField.isFirstResponder) {
            emailAddressTextField.resignFirstResponder()
        }
        if(passwordTextField.isFirstResponder) {
            passwordTextField.resignFirstResponder()
        }
    }
    
    @IBAction func registerButtonPressed() {
        postSampleDataToBackendServer()
    }
    
    func postSampleDataToBackendServer() {
        
        let email: String = emailAddressTextField.text!
        let password: String = passwordTextField.text!
        let prefs:UserDefaults = UserDefaults.standard
        
        if ( email.isEqual("") || password.isEqual("") ) {
            self.resetUI()
            self.showAlert("Registration Failed!", "Please enter Email and Password")
        }
        else if(!GenericUtility.sharedInstance.isValidEmail(emailAddress: email as String)) {
            self.resetUI()
            self.showAlert("Registration Failed!", "Please enter correct Email Address")
        }
        else {
            let params = ["email":email as String, "password":password as String] as Dictionary<String, String>
            
            self.updateUIToShowProgress()
            
            RestApiManager.sharedInstance.initializeNetworkRequest(params, "register") { json in
                
                if(json.count > 0) {
                    let accessToken:NSString = json.value(forKey: "accessToken") as! NSString
                    
                    if(accessToken.length > 0)
                    {
                        prefs.set(accessToken, forKey: "accessToken")
                        self.moveToWelcomeScreenOnSuccessfullRegistration()
                    }
                    else {
                        self.showAlert("Register Failed!", "")
                    }
                }
                else {
                    self.showAlert("Register Failed!", "")
                }
            }
        }
    }
    
    func showAlert(_ title: NSString, _ message: NSString) {
        let alertController = UIAlertController(title: title as String, message: message as String, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        // Make sure view is presented on main thread
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func moveToWelcomeScreenOnSuccessfullRegistration() {
        // Make sure segue is performed on main thread
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "moveToWelcomeScreen", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
