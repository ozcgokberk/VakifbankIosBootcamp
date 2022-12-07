//
//  Enums.swift
//  Gokberk_Ozcan_ThirdWeek_HomeWork
//
//  Created by Gokberk Ozcan on 16.11.2022.
//

import Foundation

enum EmployeeType: Int {
    case junior = 1
    case mid = 2
    case senior = 3
    
    var description: String {
        switch self {
        case .junior:
            return "Junior Developer"
        case .mid:
            return "Mid Developer"
        case .senior:
            return "Senior developer"
        }
    }
}
