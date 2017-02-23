//: ## Functions and Closures
//:
//: Use `func` to declare a function. Call a function by following its name with a list of arguments in parentheses. Use `->` to separate the parameter names and types from the function’s return type.
//:
//: **Justin Note:** Function and method names in Swift are camelcased and start with a lowercase letter.
//:

func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}
//: The above function would be called like this:
greet("Bob", day: "Tuesday")

//: > **Experiment**:
//: > Remove the `day` parameter. Add a parameter to include today’s lunch special in the greeting.
//:
//: Justin note #2: Swift will make the first parameter to a function unnamed, meaning that you don't need to write it in the arguments list.  All other parameters will be named.  You can name a parameter yourself like this:
//:
func moveTo(column column: Int, row: Int) {
    //moving code, not returning anything
}
//: The above function would be called like this:
moveTo(column: 1, row: 5)
//:
//: You can use this to name parameters differently than the variables that you use to represent them.  Use this to make your code more readable from both the calling and declaring perpectives.
//:
func timedPrint(afterDelay delay: Int, print stringToPrint: String) {
    //Wait for (delay) seconds
    //Print (stringToPrint)
}
//: The above function would be called like this:
timedPrint(afterDelay: 5, print: "That was a long wait!")
//: End Justin note

//: Use a tuple to make a compound value—for example, to return multiple values from a function. The elements of a tuple can be referred to either by name or by number.
//:
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}

let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)

//: Functions can also take a variable number of arguments, collecting them into an array.
//:
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}

sumOf()
sumOf(42, 597, 12)

func averageOf(numbers: Int...) -> Double {
    var total = 0
    var sum = 0
    for number in numbers {
        sum += number
        total++
    }
    return Double(sum/total)
}

averageOf(42, 597, 12)

//: > **Experiment**:
//: > Write a function that calculates the average of its arguments.
//:
//: Functions can be nested. Nested functions have access to variables that were declared in the outer function. You can use nested functions to organize the code in a function that is long or complex.
//:
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}

returnFifteen()

//: Functions are a first-class type. This means that a function can return another function as its value.
//:
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}

var increment = makeIncrementer()
increment(7)

//: A function can take another function as one of its arguments.
//:
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19, 7, 12]
hasAnyMatches(numbers, condition: lessThanTen)

//: Functions are actually a special case of closures: blocks of code that can be called later. The code in a closure has access to things like variables and functions that were available in the scope where the closure was created, even if the closure is in a different scope when it is executed—you saw an example of this already with nested functions. You can write a closure without a name by surrounding code with braces (`{}`). Use `in` to separate the arguments and return type from the body.
//:
numbers.map ({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})

numbers.map({
    (number: Int) -> Int in
    if number % 2 == 0 {
        return number
    } else {
        return 0
    }
})

//: > **Experiment**:
//: > Rewrite the closure to return zero for all odd numbers.
//:
//: You have several options for writing closures more concisely. When a closure’s type is already known, such as the callback for a delegate, you can omit the type of its parameters, its return type, or both. Single statement closures implicitly return the value of their only statement.
//:
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

//: You can refer to parameters by number instead of by name—this approach is especially useful in very short closures. A closure passed as the last argument to a function can appear immediately after the parentheses. When a closure is the only argument to a function, you can omit the parentheses entirely.
//:
//: **Justin Note:**  Whily you can do this, I would prefer you didn't.  I think it's a bit hard to understand, even if it's shorter.
let sortedNumbers = numbers.sort { $0 > $1 }
print(sortedNumbers)

//: Justin's preferred style:
let sortedNumbersBetter = numbers.sort { a, b in a > b }
print(sortedNumbersBetter)


//: [Previous](@previous) | [Next](@next)
