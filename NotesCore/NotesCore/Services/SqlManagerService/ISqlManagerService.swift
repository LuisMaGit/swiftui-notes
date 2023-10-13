import Foundation

// sourcery: AutoMockable
public protocol ISqlManagerService {
    func openDB() async -> Result<Never>

    func closeDb() async -> Void

    func multipleRowsQuery(
        query: String,
        resultColumnMapper: [SqlManagerColumnTypeMapper]
    ) async -> AnyResult<[Int: [Any]]>

    func noResultQuery(
        query: String
    ) async -> Result<Never>

    func singleRowQuery(
        query: String,
        resultColumnMapper: [SqlManagerColumnTypeMapper]
    ) async -> AnyResult<[Int: Any]>
}
