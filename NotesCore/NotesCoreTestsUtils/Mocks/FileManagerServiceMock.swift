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
























public class IFileManagerServiceMock: IFileManagerService {

    public init() {}



    //MARK: - documentsPath

    public var documentsPathCallsCount = 0
    public var documentsPathCalled: Bool {
        return documentsPathCallsCount > 0
    }
    public var documentsPathReturnValue: URL!
    public var documentsPathClosure: (() -> URL)?

    public func documentsPath() -> URL {
        documentsPathCallsCount += 1
        if let documentsPathClosure = documentsPathClosure {
            return documentsPathClosure()
        } else {
            return documentsPathReturnValue
        }
    }

    //MARK: - existsFileInDocumments

    public var existsFileInDocummentsFileCallsCount = 0
    public var existsFileInDocummentsFileCalled: Bool {
        return existsFileInDocummentsFileCallsCount > 0
    }
    public var existsFileInDocummentsFileReceivedFile: (String)?
    public var existsFileInDocummentsFileReceivedInvocations: [(String)] = []
    public var existsFileInDocummentsFileReturnValue: Bool!
    public var existsFileInDocummentsFileClosure: ((String) -> Bool)?

    public func existsFileInDocumments(file: String) -> Bool {
        existsFileInDocummentsFileCallsCount += 1
        existsFileInDocummentsFileReceivedFile = file
        existsFileInDocummentsFileReceivedInvocations.append(file)
        if let existsFileInDocummentsFileClosure = existsFileInDocummentsFileClosure {
            return existsFileInDocummentsFileClosure(file)
        } else {
            return existsFileInDocummentsFileReturnValue
        }
    }

}
