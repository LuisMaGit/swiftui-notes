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
























public class IStringManagerServiceMock: IStringManagerService {

    public init() {}



    //MARK: - getFirstChars

    public var getFirstCharsOfAmountCallsCount = 0
    public var getFirstCharsOfAmountCalled: Bool {
        return getFirstCharsOfAmountCallsCount > 0
    }
    public var getFirstCharsOfAmountReceivedArguments: (of: String, amount: Int)?
    public var getFirstCharsOfAmountReceivedInvocations: [(of: String, amount: Int)] = []
    public var getFirstCharsOfAmountReturnValue: String!
    public var getFirstCharsOfAmountClosure: ((String, Int) -> String)?

    public func getFirstChars(of: String, amount: Int) -> String {
        getFirstCharsOfAmountCallsCount += 1
        getFirstCharsOfAmountReceivedArguments = (of: of, amount: amount)
        getFirstCharsOfAmountReceivedInvocations.append((of: of, amount: amount))
        if let getFirstCharsOfAmountClosure = getFirstCharsOfAmountClosure {
            return getFirstCharsOfAmountClosure(of, amount)
        } else {
            return getFirstCharsOfAmountReturnValue
        }
    }

    //MARK: - splitWithCommasInParenthesis

    public var splitWithCommasInParenthesisOfCallsCount = 0
    public var splitWithCommasInParenthesisOfCalled: Bool {
        return splitWithCommasInParenthesisOfCallsCount > 0
    }
    public var splitWithCommasInParenthesisOfReceivedOf: ([Int])?
    public var splitWithCommasInParenthesisOfReceivedInvocations: [([Int])] = []
    public var splitWithCommasInParenthesisOfReturnValue: String!
    public var splitWithCommasInParenthesisOfClosure: (([Int]) -> String)?

    public func splitWithCommasInParenthesis(of: [Int]) -> String {
        splitWithCommasInParenthesisOfCallsCount += 1
        splitWithCommasInParenthesisOfReceivedOf = of
        splitWithCommasInParenthesisOfReceivedInvocations.append(of)
        if let splitWithCommasInParenthesisOfClosure = splitWithCommasInParenthesisOfClosure {
            return splitWithCommasInParenthesisOfClosure(of)
        } else {
            return splitWithCommasInParenthesisOfReturnValue
        }
    }

}
