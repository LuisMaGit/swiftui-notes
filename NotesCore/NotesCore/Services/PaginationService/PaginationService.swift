
import Foundation

class PaginationService : IPaginationService {
    func convertPageInSqlOffset(
        page: Int,
        itemsInPage: Int
    ) -> Int {
        return (page - 1) * itemsInPage
    }

    func shouldGetOtherPage(
        allItems: Int,
        page: Int,
        expectedItemsInPage: Int
    ) -> Bool {
        let expectedItems = page * expectedItemsInPage
        return allItems == expectedItems
    }
}
