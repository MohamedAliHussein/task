//
//  CountriesViewController.swift
//  CountriesTask
//
//  Created by mohamed ali on 10/17/18.
//  Copyright © 2018 soleek. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    

    @IBOutlet weak var countriesTableView: UITableView!
    
    var countriesArray : [[String:Any]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        // set the delegate and datasource to self
        self.countriesTableView.delegate = self
        self.countriesTableView.dataSource = self
        
        self.getCountries()

        // Do any additional setup after loading the view.
    }
 
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countriesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        
        let country = self.countriesArray?[indexPath.row]
        cell.textLabel?.text = country?["name"] as? String ?? "mafeesh"
        return cell
        
        
    }
    
    func getCountries() {
        // call countries api to get the countries
        let headers = [
            "cache-control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://restcountries.eu/rest/v2/all")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                do {
                    // parse response to an array
                    let countriesArray = try JSONSerialization.jsonObject(with: data!, options:[])
                    
                    self.countriesArray = countriesArray as? [[String:Any]]
                    
                    // perform changes on UI on MAIN thread
                    DispatchQueue.main.async {
                        
                     // reload dtable view to call delegate functions again
                        self.countriesTableView.reloadData()

                    }
                } catch let parseError as NSError {
                    print("Error with Json: \(parseError)")
                }
            }
        })
        
        dataTask.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
