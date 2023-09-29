import Foundation

//sourcery: AutoMockable
public protocol ITimeService {
    func stringToDate(
        source: String?,
        format: String
    ) -> Date?

    func removeTimeForDateISO8601(
        date: Date?
    ) -> Date?

    func removeTimeForDateISO8601(
        source: String?
    ) -> Date?

    func dateToDateVisualizer(
        date: Date?
    ) -> DateVisualizer?

    func dateToDateVisualizer(
        source: String?
    ) -> DateVisualizer?

    func dateToDayVisualizerDay(
        date: Date?
    ) -> DateVisualizerDay

    func dateToDayVisualizerDay(
        source: String?
    ) -> DateVisualizerDay
}
