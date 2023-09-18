
import Foundation


public class PaginationService {

    public let itemsInPage : Int

    init(
        itemsInPage: Int = 10
    ) {
        self.itemsInPage = itemsInPage
    }


    public func convertPageInSqlOffset(_ page: Int) -> Int {
        return page * itemsInPage
    }

    




}
