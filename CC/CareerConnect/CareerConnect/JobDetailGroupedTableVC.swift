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

let JOB_TITLE = 0
let JOB_TYPE = 1
let JOB_DESCRIPTION = 2
let JOB_LINK = 3
let FAVOURITE = 4
let SendFriend = 5

class JobDetailGroupedTableVC: UITableViewController, MFMailComposeViewControllerDelegate  {
    
    var job:Job!
    
    var favouriteArray:[String] = []
    
    
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
        return 6
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
        case JOB_TITLE:
            cell?.textLabel?.text = job.jTitle
            cell!.textLabel?.textAlignment = .center
        case JOB_TYPE:
            cell?.textLabel?.text = "Type : "+job.jType + "\n" + "Employer : "+job.jEmployer + "\n" + "Contact : "+job.jContact + "\n" + "Location : "+job.jAddress
            cell!.textLabel?.textAlignment = .center
        case JOB_DESCRIPTION:
            cell?.textLabel?.text = "Description : "+job.jDescription
            cell!.textLabel?.textAlignment = .center
            
        case JOB_LINK:
            cell?.textLabel?.text = "Apply Here!"
            cell!.textLabel?.textAlignment = .center
        case FAVOURITE:
            cell?.textLabel?.text = "Added to Favourites!"
            cell!.textLabel?.textAlignment = .center
        case SendFriend:
            cell?.textLabel?.text = "Send To Friend!"
            cell!.textLabel?.textAlignment = .center
        default:
            break;
        }
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == JOB_DESCRIPTION {
            return 188.0
        }
        else if indexPath.section == JOB_TYPE {
            return 100.0
        }

        else {
            return 44.0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var msg = ""
        switch indexPath.section{
        case JOB_TITLE:
            msg = "You Tapped Title"
        case JOB_TYPE:
            msg = "You Tapped Type"
        case JOB_DESCRIPTION:
            msg = "You Tapped Description"
        case JOB_LINK:
            if let url = URL(string: job.jLink)
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            msg = "You Tapped Link"
        case FAVOURITE:
            var favPark = UserDefaults.standard.array(forKey: "favorites") as? [String]
            if favPark != nil {
                if !favPark!.contains(job.jTitle) {
                    favPark!.append(job.jTitle)
                    
                    //alert
                    let favAlert = UIAlertController(title:"Favorites", message:"\(job.jTitle) added to Favorites", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    favAlert.addAction(okAction)
                    present(favAlert, animated: true, completion: nil)
                }
                else {
                    let favAlert = UIAlertController(title:"Job Already Exist", message:"\(job.jTitle) already added to Favorites", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    favAlert.addAction(okAction)
                    present(favAlert, animated: true, completion: nil)
                }
            } else {
                favPark = [job.jTitle]
                
                let favAlert = UIAlertController(title:"Favorites", message:"\(job.jTitle) added to Favorites", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                favAlert.addAction(okAction)
                present(favAlert, animated: true, completion: nil)
            }
            UserDefaults.standard.set(favPark, forKey:"favorites")
            
        case SendFriend:
            msg = "Tapped send friend"
            let mcvc = configuredMailComposeViewController(id:job.jLink)
            
            if MFMailComposeViewController.canSendMail()
            {
                self.present(mcvc,animated: true, completion: nil)
            }
            else
            {
                self.showSendMailErrorAlert()
            }

        default:
            break;
        }
        
    }
 
    
    func configuredMailComposeViewController(id: String) -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject(id)
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
