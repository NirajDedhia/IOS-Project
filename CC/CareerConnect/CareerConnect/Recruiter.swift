//
//  Recruiter.swift
//  CareerConnect
//
//  Created by Niraj Dedhia (RIT Student) on 5/8/17.
//  Copyright © 2017 Niraj Dedhia (RIT Student). All rights reserved.
//

import Foundation


class Recruiter
{
    var rId : String
    var rFName : String
    var rLName : String
    var rEmail : String
    var rEmployer : String
    
    
    
    init(rId : String , rFName : String , rLName : String , rEmail : String , rEmployer : String)
    {
        self.rId = rId
        self.rFName = rFName
        self.rLName = rLName
        self.rEmail = rEmail
        self.rEmployer = rEmployer
    }
}
