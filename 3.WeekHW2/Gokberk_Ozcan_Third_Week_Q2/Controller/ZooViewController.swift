//
//  ViewController.swift
//  Gokberk_Ozcan_Third_Week_Q2
//
//  Created by Gokberk Ozcan on 19.11.2022.
//

import UIKit

class ZooViewController: UIViewController, AnimalProtocol, EmployeeProtocol {
    
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var zooBudgetLabel: UILabel!
    @IBOutlet weak var currentCapacityOfTank: UILabel!
    
    @IBOutlet weak var listContent: UIButton!
    
    @IBOutlet weak var addEmployee: UIButton!
    
    var zoo = Zoo()
    var animalArray: [Animal]?
    var unownedArray: [Animal] = []
    var keeperList: [Employee]?
    var totalSalary: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        addEmployee.isHidden = true
        listContent.isHidden = true
    }
   
    @IBAction func incomePressed(_ sender: Any) {
        if let incomeValue = budgetTextField.text {
            if let newBudgetIncome = Int(incomeValue) {
                zoo.zooBudget += newBudgetIncome
                budgetTextField.text = ""
                zooBudgetLabel.text = "\(zoo.zooBudget)"
            }
        }
    }
    
    @IBAction func expensePressed(_ sender: Any) {
        if let expenseValue = budgetTextField.text {
            if let newBudgetIncome = Int(expenseValue) {
                zoo.zooBudget -= newBudgetIncome
                budgetTextField.text = ""
                zooBudgetLabel.text = "\(zoo.zooBudget)"
            }
        }
    }
    
    @IBAction func addWaterPressed(_ sender: Any) {
        zoo.waterTank += 10_000
        currentCapacityOfTank.text = "\(zoo.waterTank) L"
    }
    
    
    @IBAction func paySalariesPressed(_ sender: Any) {
        calculateTotalSalary()
    }
    
    @IBAction func addZooKeeperPressed(_ sender: Any) {
        
    }
    
    @IBAction func addAnimalPressed(_ sender: Any) {
    }
    
    @IBAction func listEmpandAnimalPressed(_ sender: Any) {
        
    }
    
    func setAnimalArray(data: [Animal]) {
        unownedArray.append(contentsOf: data)
        unownedArray.forEach({ animal in
            print("foo: \(animal.name)")
        })
    }
    
    func passKeeperAnimals(data: [Animal]) {
        animalArray = data
    }
    
    func passKeeperList(data: [Employee]) {
        keeperList = data
    }
    
    func calculateTotalSalary() {
        print("before Func \(zoo.zooBudget)")
        for i in 0..<keeperList!.count {
            totalSalary += keeperList![i].salary
            
        }
        zoo.zooBudget -= totalSalary
        print("After Func \(zoo.zooBudget)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "employeeAddScreen" {
            guard let addEmployeeVC = segue.destination as? EmloyeeViewController else { return }
            addEmployeeVC.unownedAnimalArr = unownedArray
            addEmployeeVC.delegate = self
            
            
        }
        else if segue.identifier == "animalVC" {
            guard let animalVC = segue.destination as? AnimalViewController else { return }
            animalVC.zooKeeperList = zoo.zooKeeperList
            animalVC.waterTank = zoo.waterTank
            animalVC.delegate = self
            addEmployee.isHidden = false
            listContent.isHidden = false
        }
        else {
            guard let zooContentVC = segue.destination as? ListOfZooContentViewController else { return }
            zooContentVC.zooContentList = animalArray
        }
    }
}

