//
//  AnimalViewController.swift
//  Gokberk_Ozcan_Third_Week_Q2
//
//  Created by Gokberk Ozcan on 20.11.2022.
//

import UIKit
protocol AnimalProtocol: AnyObject {
    func setAnimalArray(data: [Animal])
}
class AnimalViewController: UIViewController {
    
    @IBOutlet weak var animalPickerView: UIPickerView!
    
    var zooKeeperList:[Employee]!
    var emp : Employee?
    var animalTypeArr:[AnimalEnum] = [.Monkey,.Bird,.Lion,.Bear,.Snake]
    var waterTank: Int?
    var unownedArray: [Animal] = []
    var selectedAnimal: Animal?
    var zoo: Zoo?
    weak var delegate: AnimalProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animalPickerView.delegate = self
        animalPickerView.dataSource = self
        
    }
    
    
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        unownedArray.append(selectedAnimal!)
        delegate?.setAnimalArray(data: unownedArray)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
extension AnimalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return animalTypeArr.count
        } else {
            return zooKeeperList!.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return animalTypeArr[row].description
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedAnimal = Animal(voice: "hav hav", animalCanDrink: animalTypeArr[row].animalCanDrink, keeper: nil, name: animalTypeArr[row].description)
        
    }
}
