//
//  ViewController.swift
//  CountriesTask
//
//  Created by mohamed ali on 10/15/18.
//  Copyright © 2018 soleek. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    
    
    @IBOutlet weak var tfPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    @IBAction func btnLoginPressed(_ sender: Any) {
       // check if textField is empty if empty show alert
        
        if tfEmail.text == "" {
            
            let alert =  UIAlertController.init(title: "Missing Fiels", message: "Please enter an email", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
          
            return
            
        }
        if !self.isValidEmail(str: self.tfEmail.text!) {
            
            let alert =  UIAlertController.init(title: "Invalid Email", message: "Please enter a valid email", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
            
        }
        // check if textField is empty if empty show alert

        if tfPassword.text == "" {
            
            let alert =  UIAlertController.init(title: "Missing Fiels", message: "Please enter a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
            
        }
        // from firebase documentation this is the way to to use login
        Auth.auth().signIn(withEmail: self.tfEmail.text!, password: self.tfPassword.text!) { (user, error) in
            // ...
            if error == nil {
                // go to countries screen
                self.performSegue(withIdentifier: "toCountries", sender: nil)
            }
            else {
                // show alert when fail
                let alert =  UIAlertController.init(title: "Failed", message: "please enter a valid email/password", preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func btnSignupPressed(_ sender: Any) {
    }
    
    func isValidEmail(str:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: str)
    }
}


