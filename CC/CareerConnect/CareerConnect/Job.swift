//
//  Job.swift
//  CareerConnect
//
//  Created by Niraj Dedhia (RIT Student) on 5/8/17.
//  Copyright © 2017 Niraj Dedhia (RIT Student). All rights reserved.
//

import Foundation

class Job
{
    var jTitle : String
    var jDescription : String
    var jType : String
    var jEmployer : String
    var jLink : String
    var jAddress : String
    var jContact : String
    
    
    init(jTitle : String , jDescription : String , jType : String , jEmployer : String , jLink : String , jAddress : String , jContact : String )
    {
        self.jTitle = jTitle
        self.jDescription = jDescription
        self.jType = jType
        self.jEmployer = jEmployer
        self.jLink = jLink
        self.jAddress = jAddress
        self.jContact = jContact
    }
}


