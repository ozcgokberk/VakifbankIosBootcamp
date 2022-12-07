import Foundation

protocol CompanyProtocol {
    mutating func addEmployee(emp: Employee?) -> [Employee?]
    mutating func paySalary(closure: () -> Void) -> Double
    mutating func companyExpense(expense: Double) -> Double
    mutating func addIncome(income: Double) -> Double
    
    var companyName: String { get set }
    var foundationYear: Int { get set }
    var budget: Double { get set }
}

protocol EmployeeProtocol {
    var calculatedSalary: Int { get }
}

enum MaritalStatus {
    
    case single
    case married
    
    var descripton: String {
        switch self {
        case .single:
            return "single"
        case .married:
            return "married"
        }
    }
}

enum TypeOfEmployee: Int {
    case junior = 1
    case mid = 2
    case senior = 3
}


struct Company : CompanyProtocol {
    
    var companyName: String = ""
    var foundationYear: Int
    var budget: Double
    var employee: Employee?
    var employeeList: [Employee] = []
    
    mutating func addIncome(income: Double) -> Double {
        
        budget += income
        return budget
    }
    
    mutating func companyExpense(expense: Double) -> Double {
        budget -= expense
        return budget
    }
    
    mutating func addEmployee(emp: Employee?) -> [Employee?] {
        
        for  employee in [emp] {
            employeeList.append(employee!)
        }
        return employeeList
    }
    //MARK: -Here is where i use CLOSURE
    func paySalary(closure: () -> Void) -> Double {
        
        var newBudget: Double = 0.0
        for i in employeeList {
            if budget > 0 {
                newBudget = budget - i.baseSalary
            } else {
                print("Payment is  unsuccessful. Budget is under 0")
            }
        }
        closure()
        return newBudget
    }
}

struct Employee  {
    
    var name: String
    var age: Int
    var maritalStatus: MaritalStatus?
    var baseSalary: Double = 5000.0
    var experience: TypeOfEmployee?
    
    var calculatedSalary: Double {
        mutating get {
            switch experience {
                
            case .junior:
                baseSalary = baseSalary * Double(TypeOfEmployee.junior.rawValue) + 1500
                return baseSalary
                
            case .mid:
                baseSalary = baseSalary * Double(TypeOfEmployee.mid.rawValue) + 3000
                return baseSalary
                
            case .senior:
                baseSalary = baseSalary * Double(TypeOfEmployee.senior.rawValue) + 5000
                return baseSalary
            case .none:
                return 0.0
            }
        }
    }
    
    init(name: String, age: Int,maritalStatus: MaritalStatus?, experience: TypeOfEmployee?) {
        
        self.name = name
        self.age = age
        self.maritalStatus = maritalStatus
        self.experience = experience
    }
    
    
}
var company = Company(companyName: "Apple", foundationYear: 1998, budget: 100000)
company.addIncome(income: 10000.0)
company.companyExpense(expense: 50000.0)
print("A new budget after the income and expense balance is calculated:  \(company.budget)")
company.addEmployee(emp: Employee(name: "Gökberk", age: 24, maritalStatus: .single, experience: .junior))
company.addEmployee(emp: Employee(name: "Sinem", age: 24, maritalStatus: .married, experience: .mid))
company.employeeList[0].calculatedSalary
company.employeeList[1].calculatedSalary
company.employeeList
company.paySalary {
    print("You can do whatever you want here.")
}


print("------------------------------------------------Question 2 ------------------------------------------------")

protocol ZooProtocol {
    var dailyWaterLimit: Int! { get set }
    var zooBudget: Int! { get set }
    mutating func addKeeper(zooKeeper: ZooKeeper?) -> [ZooKeeper?]
}

protocol ZooKeeperProtocol {
    var baseSalary: Int { get set }
    var responsibleOfAnimals: [Animal] { get set }
}

protocol AnimalProtofcol {
    var voice: String! { get set }
    var animalCanDrink: Int! { get set }
}

class Zoo: ZooProtocol {
    
    var dailyWaterLimit: Int!
    var zooBudget: Int!
    var zooKeeperList: [ZooKeeper] = []
    var animalList: [Animal]?
    var newBudget: Int = 0
    
    init(dailyWaterLimit: Int, zooBudget: Int) {
        self.dailyWaterLimit = dailyWaterLimit
        self.zooBudget = zooBudget
    }
    
    func addBudget (income: Int) -> Int {
        
        zooBudget! += income
        return zooBudget!
    }
    
    func decreaseBudget (expense: Int) -> Int {
        
        if zooBudget > 0 {
            zooBudget! -= expense
        } else {
            "There is no money left in zoo vault."
        }
        
        return zooBudget!
    }
    
    func addWaterLimit (addWaterLimit: Int) -> Int {
        
        dailyWaterLimit! += addWaterLimit
        return dailyWaterLimit!
    }
    
    func decreaseWaterLimit (decreaseWaterLimit: Int) -> Int {
        if dailyWaterLimit > 0 {
            dailyWaterLimit! -= decreaseWaterLimit
        } else {
            "There is no water in tank."
        }
        
        return dailyWaterLimit!
    }
    
    //MARK: -Here is where i use CLOSURE
    
    let newZooBudget: (Int, Int) -> Int = { (value1, value2) in
        return value1 - value2
    }
    
    func calculateTotalSalary() -> Int {
        
        for keeper in zooKeeperList {
            
            newBudget += keeper.baseSalary
        }
        return newBudget
    }
    
    
    func calculateNewWaterLimit() {
        
        for animal in animalList! {
            decreaseWaterLimit(decreaseWaterLimit: animal.animalCanDrink)
        }
    }
    
    func addKeeper(zooKeeper: ZooKeeper?) -> [ZooKeeper?] {
        
        for  keeper in [zooKeeper] {
            zooKeeperList.append(keeper!)
        }
        return zooKeeperList
    }
    
}

class ZooKeeper: ZooKeeperProtocol {
    
    var baseSalary: Int = 3000
    var responsibleOfAnimals: [Animal]
    var keeperName: String!
    var zoo: Zoo?
    init(keeperName: String, responsibleOfAnimals: [Animal] ) {
        
        self.keeperName = keeperName
        self.responsibleOfAnimals = responsibleOfAnimals
    }
    //MARK: - Computed Property
    var calculatedSalary: Int {
        baseSalary += responsibleOfAnimals.count * 5000
        return baseSalary
    }
    
    func addAnimalToKeeper(animal: Animal) {
        
        responsibleOfAnimals.append(animal)
    }
    
    func keeperAnimals() {
        if responsibleOfAnimals.count > 0 {
            for i in 0..<responsibleOfAnimals.count {
                print ("animals that \(keeperName!) is responsible:  \(responsibleOfAnimals[i].name!)"  )
            }
        } else {
            "There is no animal that this keeper responsible of."
        }
    }
    
    func lengthOfLastWord(_ s: String) -> Int {
        if let lastWord = s.components(separatedBy: " ").filter({ $0 != "" }).last {
            return lastWord.count
        } else {
            return 0
        }
    }
    
}

class Animal {
    var voice: String!
    var animalCanDrink: Int!
    var keeper: ZooKeeper
    var name: String!
    init(voice: String, animalCanDrink: Int, keeper: ZooKeeper, name:String) {
        
        self.voice = voice
        self.animalCanDrink = animalCanDrink
        self.keeper = keeper
        self.name = name
    }
    
    func makeNoise() -> String {
        
        return voice
    }
    
    func whoIsMyKeeper() -> String {
        return ("Keeper name is: \(keeper.keeperName!)")
    }
    
    func animalDrunkWater() {
        
        if zoo.dailyWaterLimit > 0 {
            zoo.dailyWaterLimit -= animalCanDrink
        } else {
            print("There is no water left in water tank.")
        }
    }
    
}

class Bird : Animal {
    
}
class Leo : Animal {
    
}
class Dog : Animal {
    
}

let zoo = Zoo(dailyWaterLimit: 5000, zooBudget: 100000)
zoo.dailyWaterLimit
var keeperOneAnimalArr: [Animal] = []
var keeperTwoAnimalArr: [Animal] = []
let keeperOne = ZooKeeper( keeperName: "Gökberk", responsibleOfAnimals: keeperOneAnimalArr)

let keeperTwo = ZooKeeper(keeperName: "Dogukan", responsibleOfAnimals: keeperTwoAnimalArr)
zoo.addKeeper(zooKeeper: keeperOne)
zoo.addKeeper(zooKeeper: keeperTwo)
zoo.zooKeeperList
let bird = Bird(voice: "Cik cik", animalCanDrink: 500, keeper: keeperOne, name:"Kartal")
let lion = Leo(voice: "Roar", animalCanDrink: 200, keeper: keeperOne, name: "Aslan")
let dog = Dog(voice: "hav hav", animalCanDrink: 400, keeper: keeperTwo, name: "Terrier")
keeperOne.addAnimalToKeeper(animal: bird)
keeperOne.addAnimalToKeeper(animal: lion)
keeperTwo.addAnimalToKeeper(animal: dog)
keeperOne.calculatedSalary
keeperTwo.calculatedSalary
zoo.zooKeeperList
keeperOne.lengthOfLastWord("Hello world")
keeperOne.keeperAnimals()
bird.animalDrunkWater()
zoo.dailyWaterLimit
zoo.addWaterLimit(addWaterLimit: 5000)

lion.whoIsMyKeeper()
lion.makeNoise()

dog.whoIsMyKeeper()
dog.makeNoise()

keeperTwo.keeperAnimals()
zoo.calculateTotalSalary()
zoo.newZooBudget(zoo.zooBudget,zoo.newBudget)

