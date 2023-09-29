import Foundation

//sourcery: AutoMockable
public protocol IPaginationService {
    func convertPageInSqlOffset(
        page: Int,
        itemsInPage: Int
    ) -> Int
    
    func shouldGetOtherPage(
        allItems: Int,
        page: Int,
        expectedItemsInPage: Int
    ) -> Bool
}
