//
//  AllRecruitersViewController.swift
//  FinalProject
//
//  Created by Niraj Dedhia (RIT Student) on 4/27/17.
//  Copyright © 2017 Niraj Dedhia (RIT Student). All rights reserved.
//

import UIKit

class AllRecruitersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView2: UITableView!
    
    var fetchedRecruiters = [Recruiter]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView2.delegate = self
        tableView2.dataSource = self
        parseData()
    }
    
    
    func parseData()
    {
        fetchedRecruiters = []
        
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
                    
                    for eachfetchedRecruiter in fetchedData
                    {
                        let eachRecruiter = eachfetchedRecruiter as! [String : Any]
                        
                        let firstname = eachRecruiter["title"] as! String
                        let lastname = eachRecruiter["director"] as! String
                        
                        self.fetchedRecruiters.append(Recruiter(firstName: firstname, lastName: lastname, company: "", emailId: "", position: ""))
                        
                    }
                    self.tableView2.reloadData()
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
        return fetchedRecruiters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
        cell?.textLabel?.text = fetchedRecruiters[indexPath.row].firstName
        cell?.detailTextLabel?.text = fetchedRecruiters[indexPath.row].lastName
        
        return cell!
    }
    
    
    // Method is use to call the next screen using segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "segueAllRecruitersToRecruiterDescription", sender: fetchedRecruiters[indexPath.row])
    }
    
    // Method use to pass the value to the next screen using segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let guest = segue.destination as! RecruiterDescriptionViewController
        guest.demoRecruiter = sender as! Recruiter
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            fetchedRecruiters.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

class Recruiter
{
    var firstName : String
    var lastName : String
    var company : String
    var emailId : String
    var position : String
    
    init(firstName : String , lastName : String , company : String , emailId : String , position : String)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.emailId = emailId
        self.position = position
    }
}
