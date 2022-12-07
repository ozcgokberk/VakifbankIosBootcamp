//
//  EpisodesModel.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 24.11.2022.
//

import Foundation

struct EpisodesModel: Codable {
    
    let id: Int
    let title: String
    let season: String
    let airDate: String
    let episode: String
    let characters: [String]

    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title = "title"
        case season = "season"
        case airDate = "air_date"
        case episode = "episode"
        case characters = "characters"
    }
}
