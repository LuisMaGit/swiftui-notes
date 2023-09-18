import Foundation

public struct Pagination<T> {
    public let page: Int
    public let data: [T]

    public init(
        page: Int,
        data: [T]
    ) {
        self.page = page
        self.data = data
    }
}


