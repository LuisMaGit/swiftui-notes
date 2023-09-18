import Foundation

public class StringMangerService {
    public init() {}

    public func getFirstChars(
        of: String,
        amount: Int = 100
    ) -> String {
        if of.count <= amount {
            return of
        }

        return String(of.prefix(amount))
    }
}
