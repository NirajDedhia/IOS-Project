//
//  AllJobsViewController.swift
//  FinalProject
//
//  Created by Niraj Dedhia (RIT Student) on 4/23/17.
//  Copyright © 2017 Niraj Dedhia (RIT Student). All rights reserved.
//

import UIKit

class AllJobsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    //var fetchedCountry = [Country]()
    var fetchedJobs = [Job]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        parseData()
    }


    func parseData()
    {
        //fetchedCountry = []
        fetchedJobs = []
        
        //let url = "https://restcountries.eu/rest/v2/all"
        let url = "http://nirajdedhia.freevar.com/jobs.php?method=getJobs&jsoncallback=?"
        
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
                
                //for eachfetchedCountry in fetchedData
                for eachfetchedJob in fetchedData
                {
                    //let eachCountry = eachfetchedCountry as! [String : Any]
                    let eachJob = eachfetchedJob as! [String : Any]
                    
                    //let country = eachCountry["name"] as! String
                    //let capital = eachCountry["capital"] as! String
                    let jobTitle = eachJob["TITLE"] as! String
                    //let jobDescription = eachJob["DESCRIPTION"] as! String
                    let jobDescription = "Desc"
                    let jobType = eachJob["TYPE"] as! String
                    let jobEmployer = eachJob["EMPLOYER NAME"] as! String
                    let jobLink = eachJob["LINK"] as! String
                    let jobAddress = eachJob["ADDRESS"] as! String
                    let jobContact = eachJob["CONTACT"] as! String
                    
                    self.fetchedJobs.append(Job(jTitle : jobTitle , jDescription : jobDescription , jType : jobType , jEmployer : jobEmployer , jLink : jobLink , jAddress : jobAddress , jContact : jobContact ))
                }
                //print(fetchedData)
                self.tableView.reloadData()
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
        return fetchedJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobscell")

        cell?.textLabel?.text = fetchedJobs[indexPath.row].jTitle
        cell?.detailTextLabel?.text = fetchedJobs[indexPath.row].jType

        return cell!
    }
 
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            fetchedJobs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    

}
