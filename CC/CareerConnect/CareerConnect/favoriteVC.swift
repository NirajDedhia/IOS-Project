//
//  favoriteVC.swift
//  NPF-4
//
//  Created by Heta Gheewala on 5/2/17.
//  Copyright © 2017 Heta Gheewala. All rights reserved.
//

import UIKit

class favoriteVC: UITableViewController {
    
    var favorites : [Job] = []
    //var mapVC = MapVC()
    //var zoomDelegate: ZoomingProtocol?
    
    var favPark = UserDefaults.standard.array(forKey: "favorites") as? [String]

    var jobs : [Job] {
        get {
            return self.favorites
        }
        set(val){
            self.favorites = val
        }
    }
    
    @IBAction func favEdit(_ sender: UIBarButtonItem) {
        if sender.title == "Edit" {
            sender.title = "Done"
            self.tableView.isEditing = true
        }
        else {
            sender.title = "Edit"
            UserDefaults.standard.set(favPark, forKey:"favorites")
            self.tableView.isEditing = false
        }
    }
    
    @IBOutlet weak var favEdit: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favPark = UserDefaults.standard.array(forKey: "favorites") as? [String]
        tableView.reloadData()
    }
   
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (favPark?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favParkCell", for: indexPath)
        cell.textLabel?.text = favPark?[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            favPark?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
  
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveFavPark = favPark?[sourceIndexPath.row]
        favPark?.remove(at: sourceIndexPath.row)
        favPark?.insert(moveFavPark!, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for j in jobs {
            if(j.jTitle == favPark?[indexPath.row]) {
                let job = j
                let detailVC = JobDetailGroupedTableVC(style: .grouped)
                detailVC.title = job.jTitle
                detailVC.job = job
                //detailVC.zoomDelegate = mapVC
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}
