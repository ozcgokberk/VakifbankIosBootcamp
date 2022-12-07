//
//  ListOfZooContentTableViewCell.swift
//  Gokberk_Ozcan_Third_Week_Q2
//
//  Created by Gokberk Ozcan on 20.11.2022.
//

import UIKit

class ListOfZooContentTableViewCell: UITableViewCell {

    @IBOutlet weak var keeperName: UILabel!
    @IBOutlet weak var animalName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
