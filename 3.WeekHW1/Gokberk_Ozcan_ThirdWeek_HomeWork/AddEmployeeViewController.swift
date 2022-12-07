//
//  AddEmployeeViewController.swift
//  Gokberk_Ozcan_ThirdWeek_HomeWork
//
//  Created by Gokberk Ozcan on 16.11.2022.
//

import UIKit

protocol AddEmployeVCDelegate: AnyObject {
    func finishPassing(data: [String])
    func salaryPassed(data: [Int])
}

class AddEmployeeViewController: UIViewController {
   
    @IBOutlet weak var employeePicker: UIPickerView!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var ageTxtField: UITextField!
    @IBOutlet weak var addEmployeeButton: UIButton!
    
    var name: String = ""
    var age: Int = 0
    var baseSalary: Int = 5000
    var employeeType: Int?
    var typeArray: [EmployeeType] = [.junior,.mid, .senior]
    var employeeNameList = UserDefaults.standard.array(forKey: "empOArray") as? [String]
    var employeeSalary = UserDefaults.standard.array(forKey: "salaryArr") as? [Int]
    weak var delegate: AddEmployeVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeePicker.delegate = self
        employeePicker.dataSource = self
        addEmployeeButton.backgroundColor = .blue
        addEmployeeButton.layer.cornerRadius = 10
    }
    
    @IBAction func addEmployeeButton(_ sender: Any) {
        name = nameTxtField.text!
        age = Int(ageTxtField.text!)!
        addEmployee()
        delegate?.finishPassing(data: employeeNameList!)
        delegate?.salaryPassed(data: employeeSalary!)
        _ = navigationController?.popViewController(animated: true)
    }
    
    func addEmployee() {
        if employeeNameList == nil {
            let nameArr: [String] = [name]
            let salaryArr: [Int] = [baseSalary]
            UserDefaults.standard.set(nameArr, forKey: "empOArray")
            UserDefaults.standard.set(salaryArr, forKey: "salaryArr")
            print(nameArr)
        } else {
            employeeNameList?.append(name)
            employeeSalary?.append(baseSalary)
            UserDefaults.standard.set(employeeNameList, forKey: "empOArray")
            UserDefaults.standard.set(employeeSalary, forKey: "salaryArr")
        }
    }
}

extension AddEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        typeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.typeArray[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        employeeType = typeArray[row].rawValue
        print(employeeType!)
        if typeArray[row].rawValue == 1 {
            baseSalary = baseSalary * typeArray[row].rawValue  + 2500
            salaryLabel.text = String(baseSalary)
        }
        else if typeArray[row].rawValue == 2 {
            baseSalary = 5000
            baseSalary = baseSalary * typeArray[row].rawValue  + 4500
            salaryLabel.text = String(baseSalary)
        } else {
            baseSalary = 5000
            baseSalary = baseSalary * typeArray[row].rawValue + 6500
            salaryLabel.text = String(baseSalary)
        }
    }
}
