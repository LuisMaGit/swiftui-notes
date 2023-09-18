
import Foundation

public enum Result<T> {
    case success(data: T? = nil)
    case error(message: String?)
}
