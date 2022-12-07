//
//  NotesViewController.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 30.11.2022.
//

import UIKit
import CoreData
class NotesViewController: UIViewController {
    
    //MARK: Outlets:
    @IBOutlet weak var noteListTableView: UITableView!
    private var notes: [Note] = []
    var managedContext: NSManagedObjectContext!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedIndexPath: IndexPath?
    let floatingButton = UIButton()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDataManager.shared.getNotes()
        managedContext = appDelegate.persistentContainer.viewContext
        configureTableView()
        setupButton()
    }
    
    private func configureTableView() {
        noteListTableView.delegate = self
        noteListTableView.dataSource = self
        noteListTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        noteListTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func setupButton() {
        floatingButton.setTitle("Add", for: .normal)
        floatingButton.backgroundColor = .black
        floatingButton.layer.cornerRadius = 25
        view.addSubview(floatingButton)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        floatingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        floatingButton.addTarget(self,action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {

        if let noteView = UIStoryboard.addOrUpdateVC() {
            noteView.delegate = self
            let nav = UINavigationController(rootViewController: noteView)
            self.present(nav, animated: true)
        }
    }
   
    private func editSelectedNote(index: Int) {
        selectedIndexPath = IndexPath(row: index, section: 0)
        let note = notes[index]
        if let newNoteVC = UIStoryboard.addOrUpdateVC() {
            newNoteVC.selectedNote = note
            newNoteVC.delegate = self
            let nav = UINavigationController(rootViewController: newNoteVC)
            self.present(nav, animated: true)
        }
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NotesTableViewCell else { return UITableViewCell() }
        cell.configureCell(model: notes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = notes[indexPath.row]
            managedContext.delete(commit)
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            appDelegate.saveContext()
        } 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        editSelectedNote(index: indexPath.row)
    }
    
}
extension NotesViewController: AddOrUpdateVCProtocol {
    func refresh() {
        notes = CoreDataManager.shared.getNotes()
        noteListTableView.reloadData()
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }

  class func addOrUpdateVC() -> AddOrUpdateVC? {
      return mainStoryboard().instantiateViewController(withIdentifier: "addOrUpdateVC") as? AddOrUpdateVC
  }
}
