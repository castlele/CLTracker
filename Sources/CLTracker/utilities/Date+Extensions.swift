import Foundation

public extension Date {
    func isEqualTo(_ date: Date) -> Bool {
        let calendar = Calendar.current

        let dateComponents = calendar.dateComponents([.day, .month, .year], from: self)
        let otherDateComponents = calendar.dateComponents([.day, .month, .year], from: date)
        
        let isDaysEqual = dateComponents.day == otherDateComponents.day
        let isMonthsEqual = dateComponents.month == otherDateComponents.month
        let isYearsEqual = dateComponents.year == otherDateComponents.year

        return isDaysEqual && isMonthsEqual && isYearsEqual
    }
}
