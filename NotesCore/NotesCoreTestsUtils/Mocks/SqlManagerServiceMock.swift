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
























public class ISqlManagerServiceMock: ISqlManagerService {

    public init() {}



    //MARK: - openDB

    public var openDBCallsCount = 0
    public var openDBCalled: Bool {
        return openDBCallsCount > 0
    }
    public var openDBReturnValue: Result<Never>!
    public var openDBClosure: (() -> Result<Never>)?

    public func openDB() -> Result<Never> {
        openDBCallsCount += 1
        if let openDBClosure = openDBClosure {
            return openDBClosure()
        } else {
            return openDBReturnValue
        }
    }

    //MARK: - multipleRowsQuery

    public var multipleRowsQueryQueryResultColumnMapperCallsCount = 0
    public var multipleRowsQueryQueryResultColumnMapperCalled: Bool {
        return multipleRowsQueryQueryResultColumnMapperCallsCount > 0
    }
    public var multipleRowsQueryQueryResultColumnMapperReceivedArguments: (query: String, resultColumnMapper: [SqlManagerColumnTypeMapper])?
    public var multipleRowsQueryQueryResultColumnMapperReceivedInvocations: [(query: String, resultColumnMapper: [SqlManagerColumnTypeMapper])] = []
    public var multipleRowsQueryQueryResultColumnMapperReturnValue: AnyResult<[Int: [Any]]>!
    public var multipleRowsQueryQueryResultColumnMapperClosure: ((String, [SqlManagerColumnTypeMapper]) -> AnyResult<[Int: [Any]]>)?

    public func multipleRowsQuery(query: String, resultColumnMapper: [SqlManagerColumnTypeMapper]) -> AnyResult<[Int: [Any]]> {
        multipleRowsQueryQueryResultColumnMapperCallsCount += 1
        multipleRowsQueryQueryResultColumnMapperReceivedArguments = (query: query, resultColumnMapper: resultColumnMapper)
        multipleRowsQueryQueryResultColumnMapperReceivedInvocations.append((query: query, resultColumnMapper: resultColumnMapper))
        if let multipleRowsQueryQueryResultColumnMapperClosure = multipleRowsQueryQueryResultColumnMapperClosure {
            return multipleRowsQueryQueryResultColumnMapperClosure(query, resultColumnMapper)
        } else {
            return multipleRowsQueryQueryResultColumnMapperReturnValue
        }
    }

    //MARK: - closeDb

    public var closeDbCallsCount = 0
    public var closeDbCalled: Bool {
        return closeDbCallsCount > 0
    }
    public var closeDbClosure: (() -> Void)?

    public func closeDb() {
        closeDbCallsCount += 1
        closeDbClosure?()
    }

}
