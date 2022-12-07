//
//  CastCollectionViewCell.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 24.11.2022.
//

import UIKit

final class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    func configureCell(model: CastModel) {
        nameLabel.text = "Name: \(model.name)"
        birthdayLabel.text = "Birthday: \(model.birthday)"
        nicknameLabel.text = "Nickname: \(model.nickname)"
    }
}

