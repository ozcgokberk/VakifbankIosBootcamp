//
//  NotesTableViTableViewCell.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 30.11.2022.
//

import UIKit

final class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    func configureCell(model: Note) {
        noteLabel.text = model.noteText
        seasonLabel.text = ("Season: \(model.season ?? "")")
        episodeLabel.text = ("Episode: \(model.episode ??  "")")
    }
    
}
