//
//  Animal.swift
//  Gokberk_Ozcan_Third_Week_Q2
//
//  Created by Gokberk Ozcan on 20.11.2022.
//

import Foundation
struct Animal {
    
    var voice: String!
    var animalCanDrink: Int!
    var keeper: String?
    var name: String!
    init(voice: String!, animalCanDrink: Int!, keeper: String?, name: String!) {
        self.voice = voice
        self.animalCanDrink = animalCanDrink
        self.keeper = keeper
        self.name = name
    }
}
