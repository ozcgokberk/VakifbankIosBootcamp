//
//  CastModel.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 24.11.2022.
//

import Foundation
struct CastModel: Codable {
   
    let id: Int
    let name: String
    let birthday: String
    let img: String
    let nickname: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name = "name"
        case birthday = "birthday"
        case img = "img"
        case nickname = "nickname"
        case status = "status"

    }
}
