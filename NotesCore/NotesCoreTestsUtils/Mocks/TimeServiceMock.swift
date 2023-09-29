// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























public class ITimeServiceMock: ITimeService {

    public init() {}



    //MARK: - stringToDate

    public var stringToDateSourceFormatCallsCount = 0
    public var stringToDateSourceFormatCalled: Bool {
        return stringToDateSourceFormatCallsCount > 0
    }
    public var stringToDateSourceFormatReceivedArguments: (source: String?, format: String)?
    public var stringToDateSourceFormatReceivedInvocations: [(source: String?, format: String)] = []
    public var stringToDateSourceFormatReturnValue: Date?
    public var stringToDateSourceFormatClosure: ((String?, String) -> Date?)?

    public func stringToDate(source: String?, format: String) -> Date? {
        stringToDateSourceFormatCallsCount += 1
        stringToDateSourceFormatReceivedArguments = (source: source, format: format)
        stringToDateSourceFormatReceivedInvocations.append((source: source, format: format))
        if let stringToDateSourceFormatClosure = stringToDateSourceFormatClosure {
            return stringToDateSourceFormatClosure(source, format)
        } else {
            return stringToDateSourceFormatReturnValue
        }
    }

    //MARK: - removeTimeForDateISO8601

    public var removeTimeForDateISO8601DateCallsCount = 0
    public var removeTimeForDateISO8601DateCalled: Bool {
        return removeTimeForDateISO8601DateCallsCount > 0
    }
    public var removeTimeForDateISO8601DateReceivedDate: (Date)?
    public var removeTimeForDateISO8601DateReceivedInvocations: [(Date)?] = []
    public var removeTimeForDateISO8601DateReturnValue: Date?
    public var removeTimeForDateISO8601DateClosure: ((Date?) -> Date?)?

    public func removeTimeForDateISO8601(date: Date?) -> Date? {
        removeTimeForDateISO8601DateCallsCount += 1
        removeTimeForDateISO8601DateReceivedDate = date
        removeTimeForDateISO8601DateReceivedInvocations.append(date)
        if let removeTimeForDateISO8601DateClosure = removeTimeForDateISO8601DateClosure {
            return removeTimeForDateISO8601DateClosure(date)
        } else {
            return removeTimeForDateISO8601DateReturnValue
        }
    }

    //MARK: - removeTimeForDateISO8601

    public var removeTimeForDateISO8601SourceCallsCount = 0
    public var removeTimeForDateISO8601SourceCalled: Bool {
        return removeTimeForDateISO8601SourceCallsCount > 0
    }
    public var removeTimeForDateISO8601SourceReceivedSource: (String)?
    public var removeTimeForDateISO8601SourceReceivedInvocations: [(String)?] = []
    public var removeTimeForDateISO8601SourceReturnValue: Date?
    public var removeTimeForDateISO8601SourceClosure: ((String?) -> Date?)?

    public func removeTimeForDateISO8601(source: String?) -> Date? {
        removeTimeForDateISO8601SourceCallsCount += 1
        removeTimeForDateISO8601SourceReceivedSource = source
        removeTimeForDateISO8601SourceReceivedInvocations.append(source)
        if let removeTimeForDateISO8601SourceClosure = removeTimeForDateISO8601SourceClosure {
            return removeTimeForDateISO8601SourceClosure(source)
        } else {
            return removeTimeForDateISO8601SourceReturnValue
        }
    }

    //MARK: - dateToDateVisualizer

    public var dateToDateVisualizerDateCallsCount = 0
    public var dateToDateVisualizerDateCalled: Bool {
        return dateToDateVisualizerDateCallsCount > 0
    }
    public var dateToDateVisualizerDateReceivedDate: (Date)?
    public var dateToDateVisualizerDateReceivedInvocations: [(Date)?] = []
    public var dateToDateVisualizerDateReturnValue: DateVisualizer?
    public var dateToDateVisualizerDateClosure: ((Date?) -> DateVisualizer?)?

    public func dateToDateVisualizer(date: Date?) -> DateVisualizer? {
        dateToDateVisualizerDateCallsCount += 1
        dateToDateVisualizerDateReceivedDate = date
        dateToDateVisualizerDateReceivedInvocations.append(date)
        if let dateToDateVisualizerDateClosure = dateToDateVisualizerDateClosure {
            return dateToDateVisualizerDateClosure(date)
        } else {
            return dateToDateVisualizerDateReturnValue
        }
    }

    //MARK: - dateToDateVisualizer

    public var dateToDateVisualizerSourceCallsCount = 0
    public var dateToDateVisualizerSourceCalled: Bool {
        return dateToDateVisualizerSourceCallsCount > 0
    }
    public var dateToDateVisualizerSourceReceivedSource: (String)?
    public var dateToDateVisualizerSourceReceivedInvocations: [(String)?] = []
    public var dateToDateVisualizerSourceReturnValue: DateVisualizer?
    public var dateToDateVisualizerSourceClosure: ((String?) -> DateVisualizer?)?

    public func dateToDateVisualizer(source: String?) -> DateVisualizer? {
        dateToDateVisualizerSourceCallsCount += 1
        dateToDateVisualizerSourceReceivedSource = source
        dateToDateVisualizerSourceReceivedInvocations.append(source)
        if let dateToDateVisualizerSourceClosure = dateToDateVisualizerSourceClosure {
            return dateToDateVisualizerSourceClosure(source)
        } else {
            return dateToDateVisualizerSourceReturnValue
        }
    }

    //MARK: - dateToDayVisualizerDay

    public var dateToDayVisualizerDayDateCallsCount = 0
    public var dateToDayVisualizerDayDateCalled: Bool {
        return dateToDayVisualizerDayDateCallsCount > 0
    }
    public var dateToDayVisualizerDayDateReceivedDate: (Date)?
    public var dateToDayVisualizerDayDateReceivedInvocations: [(Date)?] = []
    public var dateToDayVisualizerDayDateReturnValue: DateVisualizerDay!
    public var dateToDayVisualizerDayDateClosure: ((Date?) -> DateVisualizerDay)?

    public func dateToDayVisualizerDay(date: Date?) -> DateVisualizerDay {
        dateToDayVisualizerDayDateCallsCount += 1
        dateToDayVisualizerDayDateReceivedDate = date
        dateToDayVisualizerDayDateReceivedInvocations.append(date)
        if let dateToDayVisualizerDayDateClosure = dateToDayVisualizerDayDateClosure {
            return dateToDayVisualizerDayDateClosure(date)
        } else {
            return dateToDayVisualizerDayDateReturnValue
        }
    }

    //MARK: - dateToDayVisualizerDay

    public var dateToDayVisualizerDaySourceCallsCount = 0
    public var dateToDayVisualizerDaySourceCalled: Bool {
        return dateToDayVisualizerDaySourceCallsCount > 0
    }
    public var dateToDayVisualizerDaySourceReceivedSource: (String)?
    public var dateToDayVisualizerDaySourceReceivedInvocations: [(String)?] = []
    public var dateToDayVisualizerDaySourceReturnValue: DateVisualizerDay!
    public var dateToDayVisualizerDaySourceClosure: ((String?) -> DateVisualizerDay)?

    public func dateToDayVisualizerDay(source: String?) -> DateVisualizerDay {
        dateToDayVisualizerDaySourceCallsCount += 1
        dateToDayVisualizerDaySourceReceivedSource = source
        dateToDayVisualizerDaySourceReceivedInvocations.append(source)
        if let dateToDayVisualizerDaySourceClosure = dateToDayVisualizerDaySourceClosure {
            return dateToDayVisualizerDaySourceClosure(source)
        } else {
            return dateToDayVisualizerDaySourceReturnValue
        }
    }

}
