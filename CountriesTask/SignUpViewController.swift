//
//  SignUpViewController.swift
//  CountriesTask
//
//  Created by mohamed ali on 10/15/18.
//  Copyright © 2018 soleek. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var tfConfirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func btbSignup(_ sender: Any) {
        
        
        
        // prepare json data
        let json: [String: Any] = [
            "email": "\(self.tfEmail.text!)",
            "password": "\(self.tfPassword.text!)",
            "returnSecureToken": "false"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request to register
        let url = URL(string: "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyAedWERPXcz2581HnSOInaLnJ_bqrN1yac")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                if httpResponse?.statusCode == 200 {
                    DispatchQueue.main.async {
                        // show alert when successfull
                        let alert =  UIAlertController.init(title: "Success", message: "You've successfully registered", preferredStyle: .alert)
                        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        
        task.resume()
       
    }
    
}
