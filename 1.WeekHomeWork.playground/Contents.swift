import Foundation
//Xcode 14.0.1 ile çalışıldı.
print("---------------Question 1: ---------------")
func isPalindrome(word: String) {
    
    let reversedString = String(word.reversed())
    let reversedv2 = reversedString.replacingOccurrences(of: " ", with: "")
    print(reversedv2)
    if(word != "" && word.lowercased() == reversedv2.lowercased()) {
        print("The \(word) is Palindrome")
    } else {
        print("The \(word) is not a Palindrome")
    }
}
isPalindrome(word: "taco cat taco cat".replacingOccurrences(of: " ", with: ""))
print("---------------Question 2: ---------------")

func freqOfAnArray<T: Equatable>(arr: [T]) -> Dictionary<T, Int> {
    
    let mappedItems = arr.map { ($0, 1) }
    let counts = Dictionary(mappedItems, uniquingKeysWith: +)
    return counts
}

print(freqOfAnArray(arr: [0,1,2,3,3,3,3,3]))

print("---------------Question 3: ---------------")
func makeAPyramid(level: Int) {
    for star in 1...level {
        for _ in 1...star {
            print("* ", terminator: "")
        }
        print("")
    }
}
makeAPyramid(level: 3)

print("---------------Question 4: ---------------")

func makeAEqualPyramid(level: Int){
    
    var space = level
    for i in 1...level {
        
        for _ in 1..<space{
            print(" ", terminator: "")
            
        }
        
        for _ in 0..<i{
            print("* ", terminator: "")
        }
        space -= 1
        print("")
    }
}
makeAEqualPyramid(level: 5)
print("---------------Question 5: ---------------")

print("----5.1:----")
var isGoingToSum: [Int] = []
var sum = 0
for i in 0...1000 {
    
    if i % 3 == 0  || i % 5 == 0{
        isGoingToSum.append(i)
        sum = isGoingToSum.reduce(0, +)
    }
}
print(sum)
print("----5.2:----")
    let myNumber: Int = 2
    func myFun() -> Int {
        
        var start = 0
        var num = 1
        var sum = 0
        
        while num < 4_000_000 {
            let x = start + num
            start = num
            num = x
            
            if num % 2 == 0 {
                sum += num
            }
        }
        return sum
    }
print(myFun())

print("----5.3----:")
// tekrar bak.
let number: Int = 3

func findLargestPrimeFactor() -> Int {
    
    var n = 600851475143
    var quotient = 2
    
    while quotient <= n {
        if n % quotient == 0 {
            n  = n / quotient
        } else {
            quotient += 1
        }
    }
    return quotient
}
print(findLargestPrimeFactor())
