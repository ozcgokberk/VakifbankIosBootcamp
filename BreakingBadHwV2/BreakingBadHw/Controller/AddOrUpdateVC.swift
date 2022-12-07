//
//  AddOrUpdateVC.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 1.12.2022.
//

import UIKit

protocol AddOrUpdateVCProtocol: AnyObject {
    func refresh()
}
class AddOrUpdateVC: UIViewController {
    
    
    @IBOutlet weak var seasonTxtField: UITextField!
    @IBOutlet weak var episodeTxtField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    weak var delegate: AddOrUpdateVCProtocol?
    var selectedNote: Note?
    var noteArray: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seasonTxtField.placeholder = "Enter a season"
        episodeTxtField.placeholder = "Enter a episode"
        noteTextView.text = "Write a note..."
        setupView()
    }
    
    func setupView() {
        seasonTxtField.text = selectedNote?.season
        episodeTxtField.text = selectedNote?.episode
        noteTextView.text = selectedNote?.noteText
        noteTextView!.layer.borderWidth = 1
        noteTextView.layer.borderColor = UIColor.systemGray5.cgColor
        noteTextView.layer.cornerRadius = 10
        seasonTxtField.delegate = self
        episodeTxtField.delegate = self
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if seasonTxtField.text == "" || episodeTxtField.text == ""  || noteTextView.text == "" {
            let alert = UIAlertController(title: "Error!", message: "Fields cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            if selectedNote == nil {
                noteArray.append(CoreDataManager.shared.saveNote(id: UUID().uuidString ,episodeInfo: episodeTxtField.text!, text: noteTextView.text!, seasonInfo: seasonTxtField.text!)!)
            } else {
                CoreDataManager.shared.notGuncelle(id: (selectedNote?.id)!, episodeInfo: episodeTxtField.text!, text: noteTextView.text!, seasonInfo: seasonTxtField.text!)
            }
            delegate?.refresh()
            dismiss(animated: true)
        }
    }
}
extension AddOrUpdateVC: UITextFieldDelegate  {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 6
        
    }
}
