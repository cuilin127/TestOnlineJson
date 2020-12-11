//
//  Student.swift
//  TestJson
//
//  Created by Lin Cui on 2020-11-13.
//

import Foundation

struct Student
{
    var firstName: String
    var lastName: String
    var groupName: String
    
    // initializer
    init() {
        firstName = ""
        lastName = ""
        groupName = ""
    }
    init(first:String,last:String,group:String){
        firstName = first
        lastName = last
        groupName = group
    }
}
