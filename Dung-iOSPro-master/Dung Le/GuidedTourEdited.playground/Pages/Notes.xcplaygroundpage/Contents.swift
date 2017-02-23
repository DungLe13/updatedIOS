//: [Previous](@previous)

//: ### A **Justin Note** on notes:
//: Comments should be used to defend why a line of code exists.  Don't use it to explain what each line does.  If your variables/methods/functions/classes/structs are named descriptively, the code should be easy enough to read. This is referred to as 'self-documenting' code.
//: 
//: Comments that you do use need to be updated with the code.  Any legacy comments should be deleted.
//:
//: ### Classes vs Structs
//: This was borrowed from raywenderlich.com, because it's a pretty great explanation:
//: * Structs have value semantics. Use structs for things that do not have an identity. An array that contains [a, b, c] is really the same as another array that contains [a, b, c] and they are completely interchangeable. It doesn't matter whether you use the first array or the second, because they represent the exact same thing. That's why arrays are structs.
//: * Classes have reference semantics. Use classes for things that do have an identity or a specific life cycle. You would model a person as a class because two person objects are two different things. Just because two people have the same name and birthdate, doesn't mean they are the same person. But the person's birthdate would be a struct because a date of 3 March 1950 is the same as any other date object for 3 March 1950. The date itself doesn't have an identity.
//:

//: [Next](@next)
