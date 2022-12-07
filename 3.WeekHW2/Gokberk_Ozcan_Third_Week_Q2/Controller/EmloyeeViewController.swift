//
//  EmloyeeViewController.swift
//  Gokberk_Ozcan_Third_Week_Q2
//
//  Created by Gokberk Ozcan on 20.11.2022.
//

import UIKit
protocol EmployeeProtocol: AnyObject {
    func passKeeperAnimals(data: [Animal])
    func passKeeperList(data:[Employee])
}
class EmloyeeViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var ageTxtField: UITextField!
    @IBOutlet weak var experiencePickerView: UIPickerView!
    @IBOutlet weak var animalPickerView: UIPickerView!
    @IBOutlet weak var addEmployeeButton: UIButton!
    
    var zooKeeper: Employee?
    var experience: [Experience] = [.TwoYear,.FourYear,.OverFiveYear]
    var animalArr: [Animal] = []
    var unownedAnimalArr: [Animal] = []
    var keepersAnimal: [Animal] = []
    var zooKeeperList: [Employee] = []
    var zoo: Zoo?
    var animal: Animal?
    weak var delegate: EmployeeProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        experiencePickerView.delegate = self
        experiencePickerView.dataSource = self
        animalPickerView.delegate = self
        animalPickerView.dataSource = self
        
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        addEmployee()
        navigationController?.popViewController(animated: true)
    }
    private func addAnimalToKeeper(animal: String) {
        //        zooKeeper?.animalsOfKeeper?.append(animal)
    }
    private func addEmployee() {
        zooKeeper = Employee(name: nameTxtField.text, age: Int(ageTxtField.text!), animalsOfKeeper: keepersAnimal)
        zooKeeperList.append(zooKeeper!)
        animal?.keeper = zooKeeper?.name
        keepersAnimal.append(animal!)
        animalArr.append(keepersAnimal[0])
        delegate?.passKeeperAnimals(data: animalArr)
        delegate?.passKeeperList(data: zooKeeperList)
    }
    
    
}
extension EmloyeeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return experience.count
        case 1:
            return unownedAnimalArr.count
        default:
            return 1
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return self.experience[row].description
        }
        else if pickerView.tag == 1 {
            return unownedAnimalArr[row].name
        } else {
            return "no"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        
        switch pickerView.tag {
        case 0:
            for i in 0..<zooKeeperList.count {
                if experience[row].rawValue == 1 {
                    zooKeeperList[i].salary = zooKeeperList[i].salary * keepersAnimal.count
                }
                else if experience[row].rawValue == 2 {
                    zooKeeperList[i].salary = zooKeeperList[i].salary * experience[row].rawValue * keepersAnimal.count
                } else {
                    zooKeeperList[i].salary = zooKeeperList[i].salary * experience[row].rawValue * keepersAnimal.count
                }
        }
        case 1:
            animal = unownedAnimalArr[row]
        default:
            break
        }
        
    }
}
