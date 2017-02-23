//: # Clock App Playground:
//: # About Dates and Times
//:
//: Apple handles dates using three main classes: `NSDate`, `NSCalendar`, and `NSDateComponents`.  All are included in `Foundation`

import Foundation

//: ## Dates
//: `NSDate` holds a single point in time, down to the nanosecond

let now = NSDate()

//: ## Calendars, Date Components, and Calendar Units
//: `NSCalendar` is the interface into date calculations.  It allows access to the different components of the `NSDate`, such as hour, minute, day, etc, represented as `NSDateComponents`.  You can use `currentCalendar()` to get access to the calendar local to the device, and `dateFromComponents(_:)` to build a date from `NSDateComponents`

let currentCalendar = NSCalendar.currentCalendar()


let dateComponents = NSDateComponents()
dateComponents.month = 11
dateComponents.day = 2
dateComponents.year = 2020
dateComponents.hour = 15
dateComponents.minute = 31
dateComponents.second = 55

let dateFromComponents = currentCalendar.dateFromComponents(dateComponents)

let birthdayCalendar = NSCalendar.currentCalendar()

let birthdayComponents = NSDateComponents()
birthdayComponents.month = 10
birthdayComponents.day = 13
birthdayComponents.year = 1996
birthdayComponents.hour = 1
birthdayComponents.minute = 27
birthdayComponents.second = 15

let birthday = birthdayCalendar.dateFromComponents(birthdayComponents)

/*: 
> **Experiment:** Use `NSDateComponents` and the current calendar to make an `NSDate` object that holds your birthday

Different types of calendar objects can be created using `NSCalendarIdentifiers`.  Here's how to make the Japanese calendar
*/

let japaneseCalendar = NSCalendar(identifier: NSCalendarIdentifierJapanese)

//: This init function returns an `NSCalendar?`
//: We need to unwrap it before we can use it
//japaneseCalendar is a NSCalendar? so we need to unwrap with "if let"
if let japaneseCalendar = japaneseCalendar {
    let queryComponents : NSCalendarUnit = [.Month, .Day, .Era, .Year]
    let dateComponents = japaneseCalendar.components(queryComponents, fromDate: now)

    japaneseCalendar.eraSymbols[dateComponents.era]
    dateComponents.year
    dateComponents.month
    dateComponents.day
    
    let birthdayComponents = japaneseCalendar.components(queryComponents, fromDate: birthday!)
    japaneseCalendar.eraSymbols[birthdayComponents.era]
    birthdayComponents.year
}

/*:
> **Experiment:** What is the era and year of your birthday in the Japanese calendar?

**Hint:** `NSCalendar.dateFromComponents(_:)` returns a `NSDate?`. You can chain unwrap by seperating the components with a comma.

 ## Performing Date and Time Calculations

You can also use `NSDateComponents` to add or subtract units of time from an `NSDate` using `dateByAddingComponents(_:toDate:options:)`
*/

let dateComponentsToAdd = NSDateComponents()
dateComponentsToAdd.hour = 3
dateComponentsToAdd.minute = 30

let futureTime = currentCalendar.dateByAddingComponents(dateComponentsToAdd, toDate: now, options: .WrapComponents)

/*: 
If the components are negative, then you will go backwards in time 
*/

let daysFromStartOfWeek = currentCalendar.component(.Weekday, fromDate: now)
let dateComponentsToSubtract = NSDateComponents()
dateComponentsToSubtract.day = -daysFromStartOfWeek

let startOfWeek = currentCalendar.dateByAddingComponents(dateComponentsToSubtract, toDate: now, options: .WrapComponents)

/*:
To get the time between dates, you can use `components(_:fromDate:toDate:)`
*/

if let dateFromComponents = dateFromComponents {
    let rangeDateComponents = currentCalendar.components(.Day, fromDate: now, toDate: dateFromComponents, options: .WrapComponents)
    rangeDateComponents.day
}

if let birthdayFromComponents = dateFromComponents {
    let birthRangeDateComponents = currentCalendar.components([.Year, .Month, .Day], fromDate: birthday!, toDate: now, options: .WrapComponents)
    birthRangeDateComponents.year
    birthRangeDateComponents.month
    birthRangeDateComponents.day
}
/*:
> **Experiment** How old are you in years, months, and days?

## Working with Time Zones

`NSTimeZone` allows us to translate between different timezones, including daylight savings time.
You can find a timezone using it's name or an abbreviation
*/

let eastCoastTimeZone = NSTimeZone(name: "America/New_York")
let greenwichMeanTime = NSTimeZone(abbreviation: "GMT")
let japanTimeZone = NSTimeZone(name: "Japan")

if let eastCoastTimeZone = eastCoastTimeZone, greenwichMeanTime = greenwichMeanTime, japanTimeZone = japanTimeZone {
    currentCalendar.timeZone = eastCoastTimeZone
    currentCalendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: now)
    currentCalendar.timeZone = greenwichMeanTime
    currentCalendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: now)
    currentCalendar.timeZone = japanTimeZone
    currentCalendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: now)
}

/*:
> **Experiment** What time is it in Japan?
*/

//: ## Time Formatting
//: It's useful to know some string tricks to make your time look nice. You can use NSDateFormatter to turn your dates into strings.  Specify a dateStyle and a timeStyle from the following options:
//: * .NoStyle - Specifies no style.
//: * .ShortStyle - Specifies a short style, typically numeric only, such as “11/23/37” or “3:30 PM”.
//: * .MediumStyle - Specifies a medium style, typically with abbreviated text, such as “Nov 23, 1937” or “3:30:32 PM”.
//: * .LongStyle - Specifies a long style, typically with full text, such as “November 23, 1937” or “3:30:32 PM PST”.
//: * .FullStyle - Specifies a full style with complete details, such as “Tuesday, April 12, 1952 AD” or “3:30:42 PM Pacific Standard Time”.

let dateFormatter = NSDateFormatter()
dateFormatter.dateStyle = .ShortStyle
dateFormatter.timeStyle = .LongStyle

dateFormatter.stringFromDate(NSDate())
/*:
> **Practice** Write a function that takes a time zone name (as a String) and return the current time (as a formatted String).  You may use 24 hour time, or 12 hour time (don't forget the AM/PM if using 12 hour time)
>
> **Practice** Write a function that takes a time zone name (as a String) and returns if the time zone is in the current day, one day in the future, or one day in the past.
>
> **Practice** Write a function that takes a time zone name (as a String) and returns the time difference from the current time zone.  Be careful of timezones that maybe a day ahead.  For example, Tokyo should be 14 hours ahead of the East Coast no matter what time of day you check.
*/

func currentTime(timeZoneName: String) -> String {    
    let dateFormat = NSDateFormatter()
    dateFormat.dateStyle = .LongStyle
    dateFormat.timeStyle = .ShortStyle
    dateFormat.timeZone = NSTimeZone(name:timeZoneName)!
      
    return dateFormat.stringFromDate(NSDate())
}

currentTime("Japan")
currentTime("Asia/Ho_Chi_Minh")

    
func whatDay(timeZoneName: String) -> Int {
    currentCalendar.timeZone = NSTimeZone(name: timeZoneName)!
    let otherTimeZoneComponents = currentCalendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: now)
    
    let otherTimeZoneCalendar = NSCalendar.currentCalendar()
    let otherTimeZone = otherTimeZoneCalendar.dateFromComponents(otherTimeZoneComponents)
    
    let defaultTimeZone = now
    
    let rangeDateComponents = currentCalendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: defaultTimeZone, toDate: otherTimeZone!, options: .WrapComponents)
    
    return rangeDateComponents.day
    
    /*if rangeDateComponents.day == 0 {
        return "Today"
    }
    else if rangeDateComponents.day == 1 {
        return "Tomorrow"
    } else {
        return "Yesterday"
    }*/

}

whatDay("Asia/Ho_Chi_Minh")


func timeZoneDifference(timeZoneName: String) -> Int {
    currentCalendar.timeZone = NSTimeZone(name: timeZoneName)!
    let otherTimeZoneComponents = currentCalendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: now)
    
    let otherTimeZoneCalendar = NSCalendar.currentCalendar()
    let otherTimeZone = otherTimeZoneCalendar.dateFromComponents(otherTimeZoneComponents)
    
    let defaultTimeZone = now
    
    let rangeDateComponents = currentCalendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: defaultTimeZone, toDate: otherTimeZone!, options: .WrapComponents)
    
    if (rangeDateComponents.hour > 0) {
        return rangeDateComponents.hour + 1
    } else {
        return rangeDateComponents.hour
    }
}

timeZoneDifference("Japan")
timeZoneDifference("Asia/Ho_Chi_Minh")
timeZoneDifference("America/Los_Angeles")
//: For more in depth information check out [About Dates and Times](http://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/DatesAndTimes/DatesAndTimes.html) in the Apple documentation
