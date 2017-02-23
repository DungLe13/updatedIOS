import Foundation


extension NSCalendar {
    override public var description: String {
        if let abbreviation = timeZone.abbreviation {
            return calendarIdentifier + " calendar in " + abbreviation
        } else {
            return calendarIdentifier + " calendar in " + timeZone.name
        }
    }
}

extension NSDateComponents {
    override public var description: String {
        if let date = date {
            return date.description
        } else {
            let date = NSCalendar.currentCalendar().dateFromComponents(self)
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            dateFormatter.timeStyle = .MediumStyle
            if let date = date {
                return dateFormatter.stringFromDate(date)
            }
            return ""
        }
    }
}
