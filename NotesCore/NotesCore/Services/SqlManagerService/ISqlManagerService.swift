import Foundation

//sourcery: AutoMockable
public protocol ISqlManagerService {
    func openDB() -> Result<Never>
    
    func multipleRowsQuery(
        query: String,
        resultColumnMapper: [SqlManagerColumnTypeMapper]
    ) -> AnyResult<[Int: [Any]]>
    
    func closeDb()
}
