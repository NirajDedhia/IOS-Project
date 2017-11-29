

import Foundation
import UIKit

class CompaniesTableVC: UITableViewController{
    
    var fetchedCompanies = [Company]()
    
    var companies : [Company] {
        get {
            return self.fetchedCompanies
        }
        set(val) {
            self.fetchedCompanies = val
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        
    }
    
    @IBAction func SegmentedControl(sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex){
        case 0:
            companies.sort(by: {$0.cName < $1.cName})
            self.tableView.reloadData()
        case 1:
            companies.sort(by: {$0.cName > $1.cName})
            self.tableView.reloadData()
        case 2:
            print("-----------")
            
        default:
            break
        }
    }

    
    
    func parseData()
    {
        fetchedCompanies = []
        
        let url = "http://nirajdedhia.freevar.com/employers.php?method=getJobs&jsoncallback=?"
        
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
                        //let eachCountry = eachfetchedCountry as! [String : Any]
                        let eachCompany = eachfetchedCompany as! [String : Any]
                        
                        let companyName = eachCompany["NAME"] as! String
                        //let companyDescription = eachCompany["ADDRESS"] as! String
                        let companyDescription = eachCompany["DESCRIPTION"] as! String
                        let companyLink = eachCompany["WEBSITE"] as! String
                        
                        self.fetchedCompanies.append(Company(cName : companyName , cDescription : companyDescription, cLink : companyLink))
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
        return fetchedCompanies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companiesCell", for: indexPath)
        
        // Configure the cell...
        
        let company = fetchedCompanies[indexPath.row]
        cell.textLabel?.text = company.cName
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let company = fetchedCompanies[indexPath.row]
        let detailVC = CompanyDetailGroupedTableVC(style: .grouped)
        detailVC.title = company.cName
        detailVC.company = company
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

