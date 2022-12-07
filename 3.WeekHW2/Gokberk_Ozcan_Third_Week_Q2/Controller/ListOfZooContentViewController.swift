//
//  ListOfZooContentViewController.swift
//  Gokberk_Ozcan_Third_Week_Q2
//
//  Created by Gokberk Ozcan on 20.11.2022.
//

import UIKit

class ListOfZooContentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var zooContentList: [Animal]?
    var keeperName:[String] = []
    var animalName:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ListOfZooContentTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        forloop()
        // Do any additional setup after loading the view.
    }
    
    private func forloop() {
        for i in 0..<zooContentList!.count {
            keeperName.append(zooContentList![i].keeper!)
            animalName.append(zooContentList![i].name!)
        }
    }
}

extension ListOfZooContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keeperName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListOfZooContentTableViewCell {
          
            cell.animalName.text = keeperName[indexPath.row]
            cell.keeperName.text = animalName[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    
}
