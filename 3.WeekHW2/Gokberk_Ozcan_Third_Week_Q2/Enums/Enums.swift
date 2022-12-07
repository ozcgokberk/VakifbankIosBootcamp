//
//  Enums.swift
//  Gokberk_Ozcan_Third_Week_Q2
//
//  Created by Gokberk Ozcan on 20.11.2022.
//

import Foundation
enum Experience: Int {
    
    case TwoYear = 1
    case FourYear = 2
    case OverFiveYear = 3
    
    var description: String {
        switch self {
        case .TwoYear:
            return "2 Year"
        case .FourYear:
            return "4 Year"
        case .OverFiveYear:
            return "5+ Year"
        }
    }
}
enum AnimalEnum: Int {
    
    case Monkey = 0
    case Lion = 1
    case Bear = 2
    case Snake = 3
    case Bird = 4
    
    var description: String {
        switch self {
        case .Monkey:
            return "Monkey"
        case .Bear:
            return "Bear"
        case .Lion:
            return "Lion"
        case .Snake:
            return "Snake"
        case .Bird:
            return "Bird"

        }
    }
    var animalCanDrink: Int {
        switch self {
        case .Monkey:
            return 10
        case .Lion:
            return 50
        case .Bear:
            return 100
        case .Snake:
            return 6
        case .Bird:
            return 3
        }
    }
}
