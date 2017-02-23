//: ## Protocols and Extensions
//:
//: Use `protocol` to declare a protocol.
//:
protocol ExampleProtocol {
     var simpleDescription: String { get }
     mutating func adjust()
}

//: Classes, enumerations, and structs can all adopt protocols.
//:
class SimpleClass: ExampleProtocol {
     var simpleDescription: String = "A very simple class."
     var anotherProperty: Int = 69105
    
     func adjust() {
          simpleDescription += "  Now 100% adjusted."
     }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
     var simpleDescription: String = "A simple structure"
    
     mutating func adjust() {
          simpleDescription += " (adjusted)"
     }
}

var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

enum simpleEnumeration: ExampleProtocol {
    case A, B, C

    var simpleDescription: String {
        get {
            switch self {
                case .A:
                    return "A simple enumeration A"
                case .B:
                    return "A simple enumeration B"
                case .C:
                    return "A simple enumeration C"
            }
        }
    }
    
    mutating func adjust() {
        switch self {
        case .A:
            self = A
        case .B:
            self = B
        case .C:
            self = C
        }
    }
}

var c = simpleEnumeration.B
c.adjust()
c.simpleDescription


//: > **Experiment**:
//: > Write an enumeration that conforms to this protocol.
//:
//: Notice the use of the `mutating` keyword in the declaration of `SimpleStructure` to mark a method that modifies the structure. The declaration of `SimpleClass` doesn’t need any of its methods marked as mutating because methods on a class can always modify the class.
//:
//: Use `extension` to add functionality to an existing type, such as new methods and computed properties. You can use an extension to add protocol conformance to a type that is declared elsewhere, or even to a type that you imported from a library or framework.
//:
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 42
    }
 }
print(7.simpleDescription)

extension Double {
    var absValue: Double {
        if self >= 0.0 {
            return self
        } else {
            return -1 * self
        }
    }
}
print((-7.5).absValue)


//: > **Experiment**:
//: > Write an extension for the `Double` type that adds an `absoluteValue` property.
//:
//: You can use a protocol name just like any other named type—for example, to create a collection of objects that have different types but that all conform to a single protocol. When you work with values whose type is a protocol type, methods outside the protocol definition are not available.
//:
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// print(protocolValue.anotherProperty)  // Uncomment to see the error

//: Even though the variable `protocolValue` has a runtime type of `SimpleClass`, the compiler treats it as the given type of `ExampleProtocol`. This means that you can’t accidentally access methods or properties that the class implements in addition to its protocol conformance.
//:
//: **Justin Note:**  We will be using protocols often, and many times we want a single class to conform to multiple protocols.  While it is possible to list them seperated by commas like this:
protocol SecondExampleProtocol {
    mutating func anotherMethod()
}

class MyClass: ExampleProtocol, SecondExampleProtocol {
    var simpleDescription: String = "My example class"
    
    func adjust() {
        simpleDescription += " is now adjusted"
    }
    
    func anotherMethod() {
    }
}
//: A better Justin preferred way to implement this is:

class MyBetterClass: ExampleProtocol {
    var simpleDescription: String = "My preferred example class"
    
    func adjust() {
        simpleDescription += " is now adjusted"
    }
}

extension MyBetterClass: SecondExampleProtocol {
    func anotherMethod() {
    }
}

//: [Previous](@previous) | [Next](@next)
