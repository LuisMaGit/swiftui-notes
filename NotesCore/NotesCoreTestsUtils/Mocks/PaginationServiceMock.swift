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
























public class IPaginationServiceMock: IPaginationService {

    public init() {}



    //MARK: - convertPageInSqlOffset

    public var convertPageInSqlOffsetPageItemsInPageCallsCount = 0
    public var convertPageInSqlOffsetPageItemsInPageCalled: Bool {
        return convertPageInSqlOffsetPageItemsInPageCallsCount > 0
    }
    public var convertPageInSqlOffsetPageItemsInPageReceivedArguments: (page: Int, itemsInPage: Int)?
    public var convertPageInSqlOffsetPageItemsInPageReceivedInvocations: [(page: Int, itemsInPage: Int)] = []
    public var convertPageInSqlOffsetPageItemsInPageReturnValue: Int!
    public var convertPageInSqlOffsetPageItemsInPageClosure: ((Int, Int) -> Int)?

    public func convertPageInSqlOffset(page: Int, itemsInPage: Int) -> Int {
        convertPageInSqlOffsetPageItemsInPageCallsCount += 1
        convertPageInSqlOffsetPageItemsInPageReceivedArguments = (page: page, itemsInPage: itemsInPage)
        convertPageInSqlOffsetPageItemsInPageReceivedInvocations.append((page: page, itemsInPage: itemsInPage))
        if let convertPageInSqlOffsetPageItemsInPageClosure = convertPageInSqlOffsetPageItemsInPageClosure {
            return convertPageInSqlOffsetPageItemsInPageClosure(page, itemsInPage)
        } else {
            return convertPageInSqlOffsetPageItemsInPageReturnValue
        }
    }

    //MARK: - shouldGetOtherPage

    public var shouldGetOtherPageAllItemsPageExpectedItemsInPageCallsCount = 0
    public var shouldGetOtherPageAllItemsPageExpectedItemsInPageCalled: Bool {
        return shouldGetOtherPageAllItemsPageExpectedItemsInPageCallsCount > 0
    }
    public var shouldGetOtherPageAllItemsPageExpectedItemsInPageReceivedArguments: (allItems: Int, page: Int, expectedItemsInPage: Int)?
    public var shouldGetOtherPageAllItemsPageExpectedItemsInPageReceivedInvocations: [(allItems: Int, page: Int, expectedItemsInPage: Int)] = []
    public var shouldGetOtherPageAllItemsPageExpectedItemsInPageReturnValue: Bool!
    public var shouldGetOtherPageAllItemsPageExpectedItemsInPageClosure: ((Int, Int, Int) -> Bool)?

    public func shouldGetOtherPage(allItems: Int, page: Int, expectedItemsInPage: Int) -> Bool {
        shouldGetOtherPageAllItemsPageExpectedItemsInPageCallsCount += 1
        shouldGetOtherPageAllItemsPageExpectedItemsInPageReceivedArguments = (allItems: allItems, page: page, expectedItemsInPage: expectedItemsInPage)
        shouldGetOtherPageAllItemsPageExpectedItemsInPageReceivedInvocations.append((allItems: allItems, page: page, expectedItemsInPage: expectedItemsInPage))
        if let shouldGetOtherPageAllItemsPageExpectedItemsInPageClosure = shouldGetOtherPageAllItemsPageExpectedItemsInPageClosure {
            return shouldGetOtherPageAllItemsPageExpectedItemsInPageClosure(allItems, page, expectedItemsInPage)
        } else {
            return shouldGetOtherPageAllItemsPageExpectedItemsInPageReturnValue
        }
    }

}
