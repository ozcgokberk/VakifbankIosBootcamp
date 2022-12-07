//
//  EpisodesViewController.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 24.11.2022.
//

import UIKit

final class EpisodesViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    //MARK: Properties
    private var episodes: [EpisodesModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    var episodeView: EpisodeView?
    var castArray: [String] = []
    var value: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        configureTableView()
        Client.getEpisodes { [weak self] episodes, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription) {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            self.episodes = episodes
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    private func addEpisodeView() {
        guard let episodeView = UINib(nibName: "EpisodeView", bundle: nil).instantiate(withOwner: nil,options: nil).first as? EpisodeView else { return }
        self.episodeView = episodeView
        self.episodeView?.frame = self.tableView.bounds
        episodeView.myTableView.addSubview(self.episodeView ?? UIView())
        self.episodeView?.incomingArray = castArray
        //Unfortunately could not load data to tableView.
        tableView.isHidden = true
    }
    private func closeButtonFunc() {
        print("close button tapped.")
    }
    
}
extension EpisodesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EpisodeTableViewCell, let model = episodes?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configureCell(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        value = episodes?[indexPath.row].id
        castArray = (episodes?[indexPath.row].characters)!
        addEpisodeView()
    }
}
extension EpisodesViewController: EpisodeViewProtocol {
    func closeButtonPressed() {
        closeButtonFunc()
    }
}
