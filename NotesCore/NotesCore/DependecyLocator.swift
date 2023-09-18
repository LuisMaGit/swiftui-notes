import Foundation

public func sqlManagerServiceProvider() -> SqlManagerService {
    return SqlManagerService(
        fileManagerService: fileMangerServiceProvider()
    )
}

public func fileMangerServiceProvider() -> FileManagerService {
    return FileManagerService()
}

public func timeServiceProvider() -> TimeService {
    return TimeService()
}

public func paginationServiceProvider() -> PaginationService {
    return PaginationService()
}


