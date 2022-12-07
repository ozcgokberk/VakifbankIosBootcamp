//
//  EpisodeCastTableViewCell.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 27.11.2022.
//

import UIKit
class EpisodeCastTableViewCell: UITableViewCell, CellInterface {

    @IBOutlet weak var episodeCatLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

