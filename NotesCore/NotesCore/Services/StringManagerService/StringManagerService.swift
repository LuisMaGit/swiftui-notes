import Foundation

class StringMangerService: IStringManagerService {
    init() {}

    public func getFirstChars(
        of: String,
        amount: Int 
    ) -> String {
        if of.count <= amount {
            return of
        }

        return String(of.prefix(amount))
    }
}
