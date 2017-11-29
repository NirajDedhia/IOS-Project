//
//  ParkDetailGroupedTableVC.swift
//  FavoritePlaces
//
//  Created by Niraj Dedhia (RIT Student) on 5/5/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class RecruiterDetailGroupedTableVC: UITableViewController, MFMailComposeViewControllerDelegate {
    
    var recruiter:Recruiter!
    
    
    let RECRUITER_NAME = 0
    let RECRUITER_EMAIL = 1
    let RECRUITER_EMPLOYER = 2

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // Configure the cell...
        
        switch indexPath.section{
        case RECRUITER_NAME:
            cell?.textLabel?.text = "Name : "+recruiter.rFName+" "+recruiter.rLName
            cell!.textLabel?.textAlignment = .center
        case RECRUITER_EMAIL:
            cell?.textLabel?.text = "Email : "+recruiter.rEmail
            cell!.textLabel?.textAlignment = .center
        case RECRUITER_EMPLOYER:
            cell?.textLabel?.text = "Employer : "+recruiter.rEmployer
            cell!.textLabel?.textAlignment = .center
        default:
            break;
        }
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var msg = ""
        switch indexPath.section{
            case RECRUITER_NAME:
                msg = "You Tapped Name"
            case RECRUITER_EMAIL:
                let mcvc = configuredMailComposeViewController(id:recruiter.rEmail)
                
                if MFMailComposeViewController.canSendMail()
                {
                    self.present(mcvc,animated: true, completion: nil)
                }
                else
                {
                    self.showSendMailErrorAlert()
                }
                msg = "You Tapped Email"
            case RECRUITER_EMPLOYER:
                msg = "You Tapped Employer"
            default:
                break;
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configuredMailComposeViewController(id: String) -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([id])
        mailComposerVC.setSubject("Connect!!!")
        mailComposerVC.setMessageBody("Could you please review my profile for any opportunity at your end?", isHTML: false)
        
        return mailComposerVC;
    }
    
    func showSendMailErrorAlert()
    {
        //let errorAlert = UIAlertView(title:"Could not send email", message:"Check Email Configuration.", delegate: self, cancelButtonTitle: "OK")
        //errorAlert.show()
        
        let alert = UIAlertController(title: "Could not send email", message: "Check Email Configuration.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "A thing", style: .default) { action in
            
        })
    }
    
    
    
}
