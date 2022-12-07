//
//  QuotesViewController.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 25.11.2022.
//

import UIKit

class QuotesViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var quotesTableView: UITableView!
    
    //MARK: Properties
    var selectedQuotes: QuotesModel?
    var quotesAuthor: String?
    private var quotes: [QuotesModel]? {
        didSet {
            quotesTableView.reloadData()
        }
    }
    var replacedAuthor:String?
    
    override func viewDidLoad() {
        replacedAuthor = quotesAuthor!.replacingOccurrences(of: " ", with: "+")
        navigationItem.title = ("\(quotesAuthor!) Quotes")
        super.viewDidLoad()
        indicator.startAnimating()
        Client.getQuotes(author: replacedAuthor!) { [weak self] quotes, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription) {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            self.quotes = quotes
        }
        quotesTableView.delegate = self
        quotesTableView.dataSource = self
    }
}
extension QuotesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        quotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = quotes?[indexPath.row].quote
        return cell
    }
}
