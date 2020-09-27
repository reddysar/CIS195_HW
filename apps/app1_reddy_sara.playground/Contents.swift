import UIKit

/*
 Sara Reddy
 reddysar
 App 1
 Final projectt!
 */

//Exercise 1
let foo = 42
var fooStr: String? = String(foo)

//force wrapping
if (fooStr != nil) {
    print("My number is \(fooStr)")
}

//optitonal binding
if let str = fooStr {
    print("My number is \(str)")
}

//nil coalescing
print("My number is \(fooStr ?? "43")")


//Exercise 2
var charArr = Array("cis195 is fun")
var characters = String(charArr)
characters.append("!")
print(characters)

let peopleDict: [String: Int] = ["Charles": 19, "Aiesha": 21, "Rohan": 20]
print(dump(peopleDict))

let myInfo = ("Sara Reddy", 2022)
print(myInfo)

//Exercise 3
for (name, age) in peopleDict {
    if (age < 21) {
        print("My friend \(name) is under 21")
    } else {
        print("My friend \(name) is not under 21")
    }
}

for index in 1..<11 {
    print(index)
}

let str = "cis195"
for s in str {
    print(s)
}

//Exercise 4
func sumAndDiff(_ one: Int, _ two: Int) -> (Int, Int) {
    let sum = one + two
    let diff = one - two
    return (sum, diff)
}

typealias Course = String
typealias PennId = Int

func enroll(in course: Course, using pennId: PennId) {
    print("Enrolled \(pennId) in \(course)")
}

let newCourse = "cis195"
let myPennId = 36028266
enroll(in: newCourse, using: myPennId)

//Exercises 5 and 6
struct Rectangle {
    var length = 0
    var width = 0
    var area: Int {
        get{
            return length * width
        }
    }
    var description: String? {
        didSet {
            if (description != nil) {
                print("\(description)")
            }
        }
    }
    
}

var myRect = Rectangle(length: 2, width: 3)

class Student {
    typealias School = String
    typealias Major = String
    var name: String = ""
    var major: Major = "undeclared"
    var school: School?
    
    init(name: String, school: School, major: Major) {
        self.name = name
        self.major = major
        self.school = school
    }
    
    init(name: String) {
        self.name = name
    }
}

let me  = Student(name: "Sara", school: "SEAS", major: "Computer Engineer")
let babyQuaker = Student(name: "sara")
let majors: [Student.Major] = ["CMPE", "CIS", "EE"]
babyQuaker.major = majors.randomElement() ?? "undeclared"

myRect.description = "This is my rectangle"
print(myRect.area)



