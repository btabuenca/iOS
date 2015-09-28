//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// This var accepts nil as values because of th question mark
var optionalName: String? = "John Appleseed"


var counter = 0 // This line would not be necessary

for counter in 0..<10 {
    
    // This is like an IF
    // It skips the iteration when the counter is 2
    // and consequently th 2 would not be printed
    
    guard counter != 2 else{continue}
    
    if counter != 5 {
        print(counter)
    }
    
}


//
// Working with arrays
//
var animals = [ "chickens", "ducks", "geese" ]
animals[1]
//animals[1] = "geese"

// Creating a hash array
var hAnimals = [
    "chickens" : "somewhat",
    "ducks" : "cute",
    "geese": "scary"
]

hAnimals["ducks"]

for animal in animals {
    hAnimals[animal]
}

//
// Working with functions
//

func obtieneDevuelveCadena(entrada: String) -> String {
    
    entrada
    
    return "devuelto"
}

func obtieneCadenaDevuelveEntero(entrada: String) -> Int {
    
    entrada
    
    // In Swift you can make swich over strings
    switch entrada{
        case "duck": return 0
        case "human": return 1
        default : return -1

    }
    
    
}


// The second parameter would NOT be necessary as 0 would be the default value
func obtieneDosParamsDevuelveEntero(entrada1: String, entrada2: Int = 0) -> Int {
    
    entrada1
    
    // In Swift you can make swich over strings
    switch entrada1{
        case "duck": return 10 + entrada2
        case "human": return 100 + entrada2
        default : return -1
        
    }
    
    
}


obtieneDevuelveCadena("entradilla")

obtieneCadenaDevuelveEntero("duck")
obtieneCadenaDevuelveEntero("human")
obtieneCadenaDevuelveEntero("supercoco")



obtieneDosParamsDevuelveEntero("duck")
// From the second parameter on, it is necessary to indicate the name of it.
// See this... obtieneDosParamsDevuelveEntero("duck", 1) would be an error
obtieneDosParamsDevuelveEntero("duck", entrada2: 1)
obtieneDosParamsDevuelveEntero("human", entrada2: 1)



// You might still want to include the name of the first parameter whenver
// you would define the function like this
// Here bicho would be the outside name, entrada 1 would be the internal name

func obtieneDosParamsConNombreDevuelveEntero(bicho entrada1: String, entrada2: Int = 0) -> Int {
    
    entrada1
    
    // In Swift you can make swich over strings
    switch entrada1{
        case "duck": return 10 + entrada2
        case "human": return 100 + entrada2
    
        default : return -1
        
    }
    
    
}

obtieneDosParamsConNombreDevuelveEntero(bicho: "duck", entrada2: 33)


//
// Create a 2D array to manipulate an image
//

// Note that the rows do not need to have the same size
var beautifulImage = [
    [2, 15, 3],
    [26, 3, 4, 1],
    [14, 8, 22]
]


beautifulImage




// Let us create a function for that
// inout: the variable will be modified. Otherwise it would be copy of the variable
func raiseLowerNumbers(inout inImage image:[[Int]], to number:Int){
    
    for i in 0..<image.count {
        for j in 0..<image[i].count{
            
            if image[i][j] < number {
                image[i][j] = number
            }
        }
    }
    
}

raiseLowerNumbers(inImage: &beautifulImage, to: 3)



//
// enum data samples
//

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue
ace.simpleDescription()


let two = Rank.Two
two.simpleDescription()


enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}

let hearts = Suit.Hearts

let heartsDescription = hearts.simpleDescription()



// 
// Optionals
//

var maybeString: String? = "Hello, playground" // might be null

// Check whether it is null
if maybeString != nil {
    // You have to avoid using the character !
    // It explicitly says: It is not null!!! Cogelo que tiene cosas!!
    // Pero como no las tenga ... ostion
    maybeString!.characters.count
}

// Here is an alternative to make save chekcings
if let deinitelyString = maybeString{
    deinitelyString.characters.count
} else{
    print("It is nil ")
}

// These are used to return a value from Objective C, in which
// most of the variables are pointers, and consequently might be nul
var mostLikelyString: String! = "Hey"
mostLikelyString.characters.count



//
// Functions
//

class CupHolder {
    var cups:[String]? = nil
}


class Car {
    var cupHolders:CupHolder? = nil
}


let niceCar = Car()
niceCar.cupHolders = CupHolder()


// These are soem ways to check the optionals

// Traditional checking ...
if let cupHolder = niceCar.cupHolders{
    
    // If the container is not null
    if var cups = cupHolder.cups {
        // The container is not nil, append a new one
        cups.append("Coke")
    }else{
        // The container is nil, create first
        cupHolder.cups = ["Coke"]
    }
    
}

// This is an alternative in Swift with Optional chaining
niceCar.cupHolders?.cups = []
niceCar.cupHolders?.cups?.append("Coke")


// Traditinal chekcing ...
if let cupHolder = niceCar.cupHolders {
    if let cups = cupHolder.cups{
        if(cups[0] == "Coke"){
            print("Yeahhhh")
        }else{
            print("Awwww")
        }
    }
}


// Swift lets makes these easier with "Optinal chaining...
let firstCup = niceCar.cupHolders?.cups?[0]














