//
//  InitialViewController.swift
//  CareerConnect
//
//  Created by Student on 5/9/17.
//  Copyright © 2017 Niraj Dedhia (RIT Student). All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        img.animationImages = [
        
            UIImage(named: "linkedin.png")!,
            UIImage(named: "indeed.png")!,
            UIImage(named: "rit.jpg")!,
   
        ]
        img.animationDuration = 3
        img.startAnimating()

    }

    
 

}
