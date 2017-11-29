//
//  CompanyDetailGroupedTableVC.swift
//  FavoritePlaces
//
//  Created by Niraj Dedhia (RIT Student) on 5/5/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit

class CompanyDetailGroupedTableVC: UITableViewController {
    
    var company:Company!
    
    
    let COMPANY_NAME = 0
    let COMPANY_DESCRIPTION = 1
    let COMPANY_WEBSITE = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // we are not using story board so no need
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        
        if !(cell != nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        
        let COMPANY_NAME = 0
        let COMPANY_DESCRIPTION = 1
        let COMPANY_WEBSITE = 2

        switch indexPath.section{
        case COMPANY_NAME:
            cell?.textLabel?.text = company.cName
            cell!.textLabel?.textAlignment = .center
        case COMPANY_DESCRIPTION:
            cell?.textLabel?.text = company.cDescription
            cell!.textLabel?.textAlignment = .center
        case COMPANY_WEBSITE:
            cell?.textLabel?.text = "Click Here to visit Website"
            cell!.textLabel?.textAlignment = .center
        default:
            break;
        }
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == COMPANY_DESCRIPTION {
            return 188.0
        }
        else { return 44.0 }
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var msg = ""
        switch indexPath.section{
        case COMPANY_NAME:
            msg = "Company Name tapped"
        case COMPANY_DESCRIPTION:
            msg = "Company Description tapped"
        case COMPANY_WEBSITE:
            if let url = URL(string: company.cLink)
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            msg = "Company Website tapped"
        default:
            break;
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
