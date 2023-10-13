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
    public var openDBClosure: (() async -> Result<Never>)?

    public func openDB() async -> Result<Never> {
        openDBCallsCount += 1
        if let openDBClosure = openDBClosure {
            return await openDBClosure()
        } else {
            return openDBReturnValue
        }
    }

    //MARK: - closeDb

    public var closeDbCallsCount = 0
    public var closeDbCalled: Bool {
        return closeDbCallsCount > 0
    }
    public var closeDbClosure: (() async -> Void)?

    public func closeDb() async {
        closeDbCallsCount += 1
        await closeDbClosure?()
    }

    //MARK: - multipleRowsQuery

    public var multipleRowsQueryQueryResultColumnMapperCallsCount = 0
    public var multipleRowsQueryQueryResultColumnMapperCalled: Bool {
        return multipleRowsQueryQueryResultColumnMapperCallsCount > 0
    }
    public var multipleRowsQueryQueryResultColumnMapperReceivedArguments: (query: String, resultColumnMapper: [SqlManagerColumnTypeMapper])?
    public var multipleRowsQueryQueryResultColumnMapperReceivedInvocations: [(query: String, resultColumnMapper: [SqlManagerColumnTypeMapper])] = []
    public var multipleRowsQueryQueryResultColumnMapperReturnValue: AnyResult<[Int: [Any]]>!
    public var multipleRowsQueryQueryResultColumnMapperClosure: ((String, [SqlManagerColumnTypeMapper]) async -> AnyResult<[Int: [Any]]>)?

    public func multipleRowsQuery(query: String, resultColumnMapper: [SqlManagerColumnTypeMapper]) async -> AnyResult<[Int: [Any]]> {
        multipleRowsQueryQueryResultColumnMapperCallsCount += 1
        multipleRowsQueryQueryResultColumnMapperReceivedArguments = (query: query, resultColumnMapper: resultColumnMapper)
        multipleRowsQueryQueryResultColumnMapperReceivedInvocations.append((query: query, resultColumnMapper: resultColumnMapper))
        if let multipleRowsQueryQueryResultColumnMapperClosure = multipleRowsQueryQueryResultColumnMapperClosure {
            return await multipleRowsQueryQueryResultColumnMapperClosure(query, resultColumnMapper)
        } else {
            return multipleRowsQueryQueryResultColumnMapperReturnValue
        }
    }

    //MARK: - noResultQuery

    public var noResultQueryQueryCallsCount = 0
    public var noResultQueryQueryCalled: Bool {
        return noResultQueryQueryCallsCount > 0
    }
    public var noResultQueryQueryReceivedQuery: (String)?
    public var noResultQueryQueryReceivedInvocations: [(String)] = []
    public var noResultQueryQueryReturnValue: Result<Never>!
    public var noResultQueryQueryClosure: ((String) async -> Result<Never>)?

    public func noResultQuery(query: String) async -> Result<Never> {
        noResultQueryQueryCallsCount += 1
        noResultQueryQueryReceivedQuery = query
        noResultQueryQueryReceivedInvocations.append(query)
        if let noResultQueryQueryClosure = noResultQueryQueryClosure {
            return await noResultQueryQueryClosure(query)
        } else {
            return noResultQueryQueryReturnValue
        }
    }

    //MARK: - singleRowQuery

    public var singleRowQueryQueryResultColumnMapperCallsCount = 0
    public var singleRowQueryQueryResultColumnMapperCalled: Bool {
        return singleRowQueryQueryResultColumnMapperCallsCount > 0
    }
    public var singleRowQueryQueryResultColumnMapperReceivedArguments: (query: String, resultColumnMapper: [SqlManagerColumnTypeMapper])?
    public var singleRowQueryQueryResultColumnMapperReceivedInvocations: [(query: String, resultColumnMapper: [SqlManagerColumnTypeMapper])] = []
    public var singleRowQueryQueryResultColumnMapperReturnValue: AnyResult<[Int: Any]>!
    public var singleRowQueryQueryResultColumnMapperClosure: ((String, [SqlManagerColumnTypeMapper]) async -> AnyResult<[Int: Any]>)?

    public func singleRowQuery(query: String, resultColumnMapper: [SqlManagerColumnTypeMapper]) async -> AnyResult<[Int: Any]> {
        singleRowQueryQueryResultColumnMapperCallsCount += 1
        singleRowQueryQueryResultColumnMapperReceivedArguments = (query: query, resultColumnMapper: resultColumnMapper)
        singleRowQueryQueryResultColumnMapperReceivedInvocations.append((query: query, resultColumnMapper: resultColumnMapper))
        if let singleRowQueryQueryResultColumnMapperClosure = singleRowQueryQueryResultColumnMapperClosure {
            return await singleRowQueryQueryResultColumnMapperClosure(query, resultColumnMapper)
        } else {
            return singleRowQueryQueryResultColumnMapperReturnValue
        }
    }

}
