import Foundation

public func sqlManagerServiceProvider() -> ISqlManagerService {
    return SqlManagerService(
        fileManagerService: fileMangerServiceProvider()
    )
}

public func fileMangerServiceProvider() -> IFileManagerService {
    return FileManagerService()
}

public func timeServiceProvider() -> ITimeService {
    return TimeService(now: Date.now)
}

public func paginationServiceProvider() -> IPaginationService {
    return PaginationService()
}

public func stringManagerServiceProvider() -> IStringManagerService {
    return StringMangerService()
}
