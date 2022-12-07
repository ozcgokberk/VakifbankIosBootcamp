//
//  EpisodeView.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 25.11.2022.
//

import UIKit
protocol EpisodeViewProtocol: AnyObject {
    func closeButtonPressed()
}
class EpisodeView: UIView, UITableViewDelegate, UITableViewDataSource {
        
    
    
    @IBOutlet weak var myTableView: UITableView!
    weak var delegate: EpisodeViewProtocol?
    var incomingArray:[String] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    //func is on EpisodeViewController line 52.
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.delegate?.closeButtonPressed()
    }
    private func setup() {

        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(EpisodeCastTableViewCell.cellNib, forCellReuseIdentifier:EpisodeCastTableViewCell.id )
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let episodeCell = tableView.dequeueReusableCell(withIdentifier: EpisodeCastTableViewCell.id, for: indexPath) as? EpisodeCastTableViewCell else { return UITableViewCell() }
        episodeCell.episodeCatLabel.text = incomingArray[indexPath.row]
        return episodeCell
        
    }

  
}

