import Foundation

public enum Result<T: Equatable>: Equatable {
    case success(data: T? = nil)
    case error(message: String?)
}

public enum AnyResult<T> {
    case success(data: T? = nil)
    case error(message: String?)
}

public enum BasicScreenState {
    case loading
    case success
    case error
    case empty
}

public enum FormScreenType {
    case edit
    case create
}
