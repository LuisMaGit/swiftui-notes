import Foundation

public struct Pagination<T: Equatable>: Equatable {
    public let page: Int
    public let data: [T]
    public var nextPage: Int { page + 1 }

    public init(
        page: Int,
        data: [T]
    ) {
        self.page = page
        self.data = data
    }

    public static func initial() -> Pagination {
        return Pagination(
            page: 0,
            data: []
        )
    }

    public func addPage(newData: [T]) -> Pagination {
        var updatedData = data.map { value in value }
        updatedData.append(contentsOf: newData)
        return Pagination(
            page: nextPage,
            data: updatedData
        )
    }

    public static func == (lhs: Pagination, rhs: Pagination) -> Bool {
        return lhs.page == rhs.page &&
            lhs.data == rhs.data
    }
}
