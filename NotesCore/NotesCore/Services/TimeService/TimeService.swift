import Foundation

class TimeService: ITimeService {
    let now: Date
    public init(now: Date) {
        self.now = now
    }

    var timeZone: TimeZone {
        return TimeZone(abbreviation: "UTC")!
    }

    func stringToDate(
        source: String?,
        format: String
    ) -> Date? {
        if let source {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.timeZone = timeZone
            return dateFormatter.date(from: source)
        }

        return nil
    }

    func removeTimeForDateISO8601(
        date: Date?
    ) -> Date? {
        if let date {
            let str = date.formatted(
                .iso8601
                    .year()
                    .month()
                    .day()
                    .dateSeparator(.dash)
            )
            return stringToDate(
                source: str,
                format: "yyyy-MM-dd"
            )
        }

        return nil
    }

    func removeTimeForDateISO8601(
        source: String?
    ) -> Date? {
        return removeTimeForDateISO8601(
            date: stringToDate(
                source: source,
                format: DATE_FORMAT_ISO8601
            )
        )
    }

    func dateToDateVisualizer(
        date: Date?
    ) -> DateVisualizer? {
        if let date {
            var calendar = Calendar.current
            calendar.timeZone = timeZone
            return DateVisualizer(
                dayVisualizer: dateToDayVisualizerDay(date: date),
                dayOfMonth: calendar.component(.day, from: date),
                dayOfWeek: calendar.component(.weekday, from: date),
                month: calendar.component(.month, from: date),
                year: calendar.component(.year, from: date),
                hour: calendar.component(.hour, from: date),
                min: calendar.component(.minute, from: date),
                sec: calendar.component(.second, from: date)
            )
        }
        return nil
    }

    func dateToDateVisualizer(
        source: String?
    ) -> DateVisualizer? {
        return dateToDateVisualizer(
            date: stringToDate(
                source: source,
                format: DATE_FORMAT_ISO8601
            )
        )
    }

    func dateToDayVisualizerDay(
        date: Date?
    ) -> DateVisualizerDay {
        if let date,
           let nowNT = removeTimeForDateISO8601(
               date: now
           ),
           let dateNT = removeTimeForDateISO8601(
               date: date
           )
        {
            let difference = nowNT.timeIntervalSince(dateNT)

            if difference == 0 {
                return .today
            }

            if difference.sign == .minus {
                return .afterToday
            }

            if Int(difference) == SECONDS_IN_A_DAY {
                return .yesterday
            }

            return .beforeYesterday
        }

        return DateVisualizerDay.beforeYesterday
    }

    func dateToDayVisualizerDay(
        source: String?
    ) -> DateVisualizerDay {
        return dateToDayVisualizerDay(
            date: stringToDate(
                source: source,
                format: DATE_FORMAT_ISO8601
            )
        )
    }
}
