import Foundation

public struct DateVisualizer: Equatable {
    public let dayVisualizer: DateVisualizerDay
    public let dayOfMonth: Int
    public let dayOfWeek: Int // sunday is 1
    public let month: Int
    public let year: Int
    public let hour: Int
    public let min: Int
    public let sec: Int

    public init(
        dayVisualizer: DateVisualizerDay,
        dayOfMonth: Int,
        dayOfWeek: Int,
        month: Int,
        year: Int,
        hour: Int,
        min: Int,
        sec: Int
    ) {
        self.dayVisualizer = dayVisualizer
        self.dayOfMonth = dayOfMonth
        self.dayOfWeek = dayOfWeek
        self.month = month
        self.year = year
        self.hour = hour
        self.min = min
        self.sec = sec
    }
}

public enum DateVisualizerDay {
    case today
    case yesterday
    case afterToday
    case beforeYesterday
}
