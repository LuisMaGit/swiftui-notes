@testable import NotesCore
import XCTest

final class TimeServiceTest: XCTestCase {
    var timeServiceDef: ITimeService = timeServiceProvider()

    func test_stringToDate_format() {
        let stub = "2017-01-27 18:36:36"
        let expected = "\(stub) +0000"
        let date = timeServiceDef.stringToDate(
            source: stub,
            format: DATE_FORMAT_ISO8601
        )!
        XCTAssertEqual(date.description, expected)
    }

    func test_removeTimeFromDate() {
        let stub = "2017-01-27 18:36:36"
        let expected = "2017-01-27 00:00:00 +0000"
        let result = timeServiceDef.removeTimeForDateISO8601(source: stub)

        XCTAssertEqual(result?.description, expected)
    }

    func test_dateToDayVisualizerDay() {
        // arrange
        let now = "2023-01-27 06:00:00"
        let nowDate = timeServiceDef.stringToDate(
            source: now,
            format: DATE_FORMAT_ISO8601
        )!
        let timeService = TimeService(now: nowDate)

        // today
        let sameAsNowDate = "2023-01-27 07:00:00"
        let todayResult = timeService.dateToDayVisualizerDay(
            source: sameAsNowDate
        )
        XCTAssertEqual(todayResult, .today)

        // after today
        let afterToday = "2023-01-28 06:00:00"
        let afterTodayResult = timeService.dateToDayVisualizerDay(
            source: afterToday
        )
        XCTAssertEqual(afterTodayResult, .afterToday)

        // yesterday
        let yesterdayDate = "2023-01-26 07:00:00"
        let yesterdayResult = timeService.dateToDayVisualizerDay(
            source: yesterdayDate
        )
        XCTAssertEqual(yesterdayResult, .yesterday)

        // before yesterday
        let beforeYesterday = "2022-12-31 07:00:00"
        let beforeYesterdayResult = timeService.dateToDayVisualizerDay(
            source: beforeYesterday
        )
        XCTAssertEqual(beforeYesterdayResult, .beforeYesterday)
    }

    func test_dateToDateVisualizer() {
        let now = "2024-01-27 06:00:00"
        let nowDate = timeServiceDef.stringToDate(
            source: now,
            format: DATE_FORMAT_ISO8601
        )!
        let timeService = TimeService(now: nowDate)
        let stub = "2024-01-26 13:34:45"
        let expected = DateVisualizer(
            dayVisualizer: .yesterday,
            dayOfMonth: 26,
            dayOfWeek: 6,
            month: 1,
            year: 2024,
            hour: 13,
            min: 34,
            sec: 45
        )

        let result = timeService.dateToDateVisualizer(source: stub)
        XCTAssertEqual(expected, result)
    }
}
