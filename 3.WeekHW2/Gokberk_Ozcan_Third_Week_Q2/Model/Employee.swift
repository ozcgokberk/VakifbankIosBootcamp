//
//  EmployeeMode.swift
//  Gokberk_Ozcan_Third_Week_Q2
//
//  Created by Gokberk Ozcan on 20.11.2022.
//

import Foundation

struct Employee {
    
    let name: String?
    let age: Int?
    var salary: Int = 5000
    var animalsOfKeeper: [Animal]?
    var calculatedSalary: Int?
   
    init(name: String?, age: Int?, animalsOfKeeper: [Animal]?, calculatedSalary: Int? = nil) {
        self.name = name
        self.age = age
        self.animalsOfKeeper = animalsOfKeeper
        self.calculatedSalary = calculatedSalary
    }
}
