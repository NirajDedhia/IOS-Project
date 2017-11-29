

import Foundation
import UIKit

class RecruitersTableVC: UITableViewController {
    
    var fetchedRecruiters = [Recruiter]()
    
    var recruiters : [Recruiter] { 
        get {
            return self.fetchedRecruiters
        }
        set(val) {
            self.fetchedRecruiters = val
        }
    }
    
    @IBAction func SegmentedControl1(sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex){
        case 0:
            recruiters.sort(by: {$0.rFName < $1.rFName})
            self.tableView.reloadData()
        case 1:
            recruiters.sort(by: {$0.rFName > $1.rFName})
            self.tableView.reloadData()
        case 2:
            print("-----------")
            
        default:
            break
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        
    }
    
    func parseData()
    {
        //fetchedCountry = []
        fetchedRecruiters = []
        
        //let url = "https://restcountries.eu/rest/v2/all"
        let url = "http://nirajdedhia.freevar.com/recruiters.php?method=getJobs&jsoncallback=?"
        
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
                    for eachfetchedRecruiter in fetchedData
                    {
                        //let eachCountry = eachfetchedCountry as! [String : Any]
                        let eachRecruiter = eachfetchedRecruiter as! [String : Any]
                        
                        //let country = eachCountry["name"] as! String
                        //let capital = eachCountry["capital"] as! String
                        let rId = eachRecruiter["ID"] as! String
                        //let jobDescription = eachJob["DESCRIPTION"] as! String
                        //let rFName = eachRecruiter["FIRSTNAME"] as! String
                        let rFName = eachRecruiter["FIRSTNAME"] as! String
                        let rLName = eachRecruiter["LASTNAME"] as! String
                        let rEmail = eachRecruiter["EMAIL"] as! String
                        let rEmployer = eachRecruiter["EMPLOYER"] as! String
                        
                        
                        self.fetchedRecruiters.append(Recruiter(rId : rId , rFName : rFName , rLName : rLName , rEmail : rEmail , rEmployer : rEmployer))
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedRecruiters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recruitersCell", for: indexPath)
        
        // Configure the cell...
        
        let recruiter = fetchedRecruiters[indexPath.row]
        cell.textLabel?.text = recruiter.rFName+" "+recruiter.rLName
        cell.detailTextLabel?.text = recruiter.rEmployer
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recruiter = fetchedRecruiters[indexPath.row]
        let detailVC = RecruiterDetailGroupedTableVC(style: .grouped)
        detailVC.title = recruiter.rFName
        detailVC.recruiter = recruiter
        //detailVC.mapVC = mapVC
        //detailVC.zoomDelegate = mapVC
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
