//
//  EpisodeTableViewCell.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 24.11.2022.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell{

    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(model: EpisodesModel) {
        episodeNameLabel.text = model.title
        seasonLabel.text = "\(model.season)x"
        episodeId.text = "\(model.id)"
        
        
    }
    
}
