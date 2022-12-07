//
//  ViewController.swift
//  Gokberk_Ozcan_ThirdWeek_HomeWork
//
//  Created by Gokberk Ozcan on 16.11.2022.
//

import UIKit

class ViewController: UIViewController, AddEmployeVCDelegate {
    
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyBudget: UILabel!
    @IBOutlet weak var incomeTxtField: UITextField!
    @IBOutlet weak var expenseTxtField: UITextField!
    @IBOutlet weak var employeeListButton: UIButton!
    @IBOutlet weak var paySalaryButton: UIButton!
    var incomingEmployeeDetails: [String]?
    var incomingEmployeeSalary: [Int]?
    var budget = 300000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyBudget.text = String("\(budget)")
        employeeListButton.isHidden = true
        paySalaryButton.isHidden = true
    }
    
    @IBAction func getIncomeButton(_ sender: Any) {
        if let incomeValue = incomeTxtField.text {
            if let newBudgetIncome = Int(incomeValue) {
                budget += newBudgetIncome
                incomeTxtField.text = ""
                companyBudget.text = "\(budget)"
            }
        }
    }
    
    @IBAction func getExpenseButton(_ sender: Any) {
        if let expenseValue = incomeTxtField.text {
            if let newBudgetExpense = Int(expenseValue) {
                budget -= newBudgetExpense
                expenseTxtField.text = ""
                companyBudget.text = "\(budget)"
            }
        }
    }
    
    @IBAction func paySalaryButton(_ sender: Any) {
        
        for i in incomingEmployeeSalary! {
            if budget > 0, i <= budget {
                budget -= i
                companyBudget.text = String(budget)
            } else {
                companyBudget.text = ("There is not enough budget to pay the salaries")
            }
        }
    }
    
    @IBAction func addEmployeeButton(_ sender: Any) {
        performSegue(withIdentifier: "employeeAddScreen", sender: nil)
        employeeListButton.isHidden = false
        paySalaryButton.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "employeeAddScreen" {
            guard let addEmployeeVC = segue.destination as? AddEmployeeViewController else { return }
            addEmployeeVC.delegate = self
            
        } else {
            guard let employeeListVC = segue.destination as? EmployeeListViewController else { return }
            employeeListVC.employeeListArray = incomingEmployeeDetails
        }
    }
    
    @IBAction func showEmployeeListButton(_ sender: Any) {
        performSegue(withIdentifier: "employeeListScreen", sender: nil)
    }
    
    func finishPassing(data: [String]) {
        incomingEmployeeDetails = data
    }
    
    func salaryPassed(data: [Int]) {
        incomingEmployeeSalary = data
    }
}

