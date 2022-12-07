//
//  ViewController.swift
//  ServiceCall
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    var quotesArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Client.getSpells { spells, error in
            for i in spells! {
                self.quotesArray.append(i.en!)
                
            }
            self.quoteLabel.text = "\(self.quotesArray.randomElement()!)"
        }

    }
    

    @IBAction func getRandomQuotes(_ sender: Any) {
            self.quoteLabel.text = "\(self.quotesArray.randomElement()!)"
        }
    }


