//
//  CharacterDeailViewController.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 24.11.2022.
//

import UIKit

final class CharacterDeailViewController: BaseViewController {
    //MARK: Outlets
    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var charNameLabel: UILabel!
    @IBOutlet weak var charNicknameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    //MARK: Properties
    var charName: String?
    var charNickName: String?
    var status: String?
    var charImg:String?
    var id: Int?
    private var castDetail: [CastModel]?
    private var cast: [CastModel]?
    var detail: CastModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        charImage.loadFrom(URLAddress: charImg!)
        print(charName!)
        
    }
    
    private func viewSetup() {
        charNameLabel.text = charName
        charNicknameLabel.text = charNickName
        statusLabel.text = status
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let charQuotes = segue.destination as? QuotesViewController else { return }
        charQuotes.quotesAuthor = charName
    }
    
    @IBAction func getQuotesPressed(_ sender: Any) {
        
    }
    
}
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
