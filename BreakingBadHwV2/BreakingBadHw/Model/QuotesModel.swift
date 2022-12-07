//
//  QuotesModel.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 25.11.2022.
//

import Foundation

struct QuotesModel: Codable {
    
    let id: Int
    let quote: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case id = "quote_id"
        case quote = "quote"
        case author = "author"
    }
}
