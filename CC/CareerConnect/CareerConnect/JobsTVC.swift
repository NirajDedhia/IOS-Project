

import Foundation
import UIKit

class JobsTableVC: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    
    var fetchedJobs = [Job]()
    
    var jobs : [Job] {
        get {
            return self.fetchedJobs
        }
        set(val) {
            self.fetchedJobs = val
        }
    }
    
    func search()
    {
        let sb:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        sb.delegate = self
        sb.showsScopeBar = true
        sb.tintColor = UIColor.lightGray
        sb.scopeButtonTitles = ["Title","Type"]
        self.tableView.tableHeaderView = sb
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText == ""
        {
            parseData()
        }
        else
        {
            if searchBar.selectedScopeButtonIndex == 0
            {
                fetchedJobs = fetchedJobs.filter({ (job)  -> Bool in
                    return job.jTitle.lowercased().contains(searchText.lowercased())
                })
            }
            else
            {
                fetchedJobs = fetchedJobs.filter({ (job)  -> Bool in
                    return job.jType.lowercased().contains(searchText.lowercased())
                })
            }
        }
        self.tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        search()
        self.hideKeyboardWhenTappedAround() 
        
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
                        
                        let jobTitle = eachJob["TITLE"] as! String
                        let jobDescription = eachJob["DESCRIPTION"] as! String
                        //let jobDescription = "Desc"
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
        return fetchedJobs.count
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobsCell", for: indexPath)
        
        // Configure the cell...
        
        let job = fetchedJobs[indexPath.row]
        cell.textLabel?.text = job.jTitle
        cell.detailTextLabel?.text = job.jType
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let job = fetchedJobs[indexPath.row]
        let detailVC = JobDetailGroupedTableVC(style: .grouped)
        detailVC.title = job.jTitle
        detailVC.job = job
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

