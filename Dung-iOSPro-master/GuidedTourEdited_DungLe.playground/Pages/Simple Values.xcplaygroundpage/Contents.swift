//: # A Swift Tour
//:
//: Tradition suggests that the first program in a new language should print the words “Hello, world!” on the screen. In Swift, this can be done in a single line:
//:
print("Hello, world!")

//: If you have written code in C or Objective-C, this syntax looks familiar to you—in Swift, this line of code is a complete program. You don’t need to import a separate library for functionality like input/output or string handling. Code written at global scope is used as the entry point for the program, so you don’t need a `main()` function. You also don’t need to write semicolons at the end of every statement.
//:
//: **Justin Note:** Please do not use a semicolon at the end of statements. You may use one to seperate multiple statements in a single line if you must, but be careful to maintain readability.
//:
//: This tour gives you enough information to start writing code in Swift by showing you how to accomplish a variety of programming tasks. Don’t worry if you don’t understand something—everything introduced in this tour is explained in detail in the rest of this book.
//:
//: ## Simple Values
//:
//: Use `let` to make a constant and `var` to make a variable. The value of a constant doesn’t need to be known at compile time, but you must assign it a value exactly once. This means you can use constants to name a value that you determine once but use in many places.
//:
//: **Justin Note:** Your constants and variables should have descriptive names written out in camelcase. Constants and variables should start with a lowercase letter.  It's preferred to use US English spelling for things to match the Apple APIs.
//:
//: **Justin Note #2:** If the value does not change, it is a constant.  Use `let` as much as you can, and `var` only when the value changes.

var myVariable = 42
myVariable = 50
let myConstant = 42

//: A constant or variable must have the same type as the value you want to assign to it. However, you don’t always have to write the type explicitly. Providing a value when you create a constant or variable lets the compiler infer its type. In the example above, the compiler infers that `myVariable` is an integer because its initial value is an integer.
//:
//: If the initial value doesn’t provide enough information (or if there is no initial value), specify the type by writing it after the variable, separated by a colon.
//:
//: **Justin Note:** Pay attention to spacing.  It's not important for the compiler, but for consistancy and readability.  A common Swift convention we will use in this class is to put a space after, but not before the colon when explicitly declaring the type.

let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70

let explicitFloat: Float = 4
//: > **Experiment**:
//: > Create a constant with an explicit type of `Float` and a value of `4`.
//:
//: Values are never implicitly converted to another type. If you need to convert a value to a different type, explicitly make an instance of the desired type.
//:
let label = "The width is "
let width = 94
let widthLabel = label + width

//Binary operator '+' cannot be applied to operands of type 'String' and 'Int'

//: > **Experiment**:
//: > Try removing the conversion to `String` from the last line. What error do you get?
//:
//: There’s an even simpler way to include values in strings: Write the value in parentheses, and write a backslash (`\`) before the parentheses. For example:
//:
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

let myName = "Dung"
let statement = "\(myName) has \(apples + oranges) pieces of fruit."

//: > **Experiment**:
//: > Use `\()` to include a floating-point calculation in a string and to include someone’s name in a greeting.
//:
//: Create arrays and dictionaries using brackets (`[]`), and access their elements by writing the index or key in brackets. A comma is allowed after the last element.
//:
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

//: **Justin Note:** For multiline enclosures (such as using [] or {}), open on the same line as the statment, and end on a new line.
var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"

//: To create an empty array or dictionary, use the initializer syntax.
//:
let emptyArray = [String]()
let emptyDictionary = [String: Float]()

//: If type information can be inferred, you can write an empty array as `[]` and an empty dictionary as `[:]`—for example, when you set a new value for a variable or pass an argument to a function.
//:
shoppingList = []
occupations = [:]



//: See [License](License) for this sample's licensing information.
//:
//: [Next](@next)
