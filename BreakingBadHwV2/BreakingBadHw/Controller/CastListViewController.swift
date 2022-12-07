//
//  CastListViewController.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 24.11.2022.
//

import UIKit

final class CastListViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Properties
    private var cast: [CastModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var idNum: Int?
    var name:String?
    var nickname:String?
    var status:String?
    var image:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        indicator.startAnimating()
        Client.getCast { [weak self] cast, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription) {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            self.cast = cast
        }
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "castCell")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let charDetails = segue.destination as? CharacterDeailViewController else { return }
        charDetails.charName = cast?[idNum! - 1].name
        charDetails.charNickName = cast?[idNum! - 1].nickname
        charDetails.status = cast?[idNum! - 1].status
        charDetails.charImg = cast?[idNum! - 1].img
        charDetails.id = idNum! - 1
        
    }
}

extension CastListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as? CastCollectionViewCell, let model = cast?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configureCell(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        idNum = cast![indexPath.row].id
        performSegue(withIdentifier: "showCharDetail", sender: self)
    }
}
