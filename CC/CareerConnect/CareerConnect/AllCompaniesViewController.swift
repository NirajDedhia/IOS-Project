//
//  AllCompaniesViewController.swift
//  FinalProject
//
//  Created by Niraj Dedhia (RIT Student) on 4/27/17.
//  Copyright © 2017 Niraj Dedhia (RIT Student). All rights reserved.
//

import UIKit

class AllCompaniesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView3: UITableView!
    
    var fetchedCompanies = [Company]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView3.delegate = self
        tableView3.dataSource = self
        parseData()
    }
    
    
    func parseData()
    {
        fetchedCompanies = []
        
        let url = "http://nirajdedhia.freevar.com/api.php?method=getJobs&jsoncallback=?"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil
            {
                print("Error")
            }
            else
            {
                do
                {
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    
                    for eachfetchedCompany in fetchedData
                    {
                        let eachCompany = eachfetchedCompany as! [String : Any]
                        
                        let name = eachCompany["title"] as! String
                        let description = eachCompany["director"] as! String
                        
                        self.fetchedCompanies.append(Company(name: name, description: description, website: "", industry: ""))
                        
                    }
                    self.tableView3.reloadData()
                }
                catch
                {
                    print("Error 2")
                }
            } // End of Else
            
        } // end of task
        task.resume();
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return fetchedCompanies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3")
        cell?.textLabel?.text = fetchedCompanies[indexPath.row].name
        cell?.detailTextLabel?.text = fetchedCompanies[indexPath.row].description
        
        return cell!
    }
    
    
    // Method is use to call the next screen using segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "segueAllcompaniesToCompanyDescription", sender: fetchedCompanies[indexPath.row])
    }
    
    // Method use to pass the value to the next screen using segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let guest = segue.destination as! CompanyDescriptionViewController
        guest.demoCompany = sender as! Company
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            fetchedCompanies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

class Company
{
    var name : String
    var description : String
    var website : String
    var industry : String
    
    init(name : String , description : String , website : String , industry : String)
    {
        self.name = name
        self.description = description
        self.website = website
        self.industry = industry
    }
}
