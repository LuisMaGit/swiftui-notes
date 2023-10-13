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

    //MARK: - existsFileInDocuments

    public var existsFileInDocumentsFileCallsCount = 0
    public var existsFileInDocumentsFileCalled: Bool {
        return existsFileInDocumentsFileCallsCount > 0
    }
    public var existsFileInDocumentsFileReceivedFile: (String)?
    public var existsFileInDocumentsFileReceivedInvocations: [(String)] = []
    public var existsFileInDocumentsFileReturnValue: Bool!
    public var existsFileInDocumentsFileClosure: ((String) -> Bool)?

    public func existsFileInDocuments(file: String) -> Bool {
        existsFileInDocumentsFileCallsCount += 1
        existsFileInDocumentsFileReceivedFile = file
        existsFileInDocumentsFileReceivedInvocations.append(file)
        if let existsFileInDocumentsFileClosure = existsFileInDocumentsFileClosure {
            return existsFileInDocumentsFileClosure(file)
        } else {
            return existsFileInDocumentsFileReturnValue
        }
    }

}
