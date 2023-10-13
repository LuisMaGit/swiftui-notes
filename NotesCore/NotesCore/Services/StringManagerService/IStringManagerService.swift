import Foundation

//sourcery: AutoMockable
public protocol IStringManagerService {
    func getFirstChars(
        of: String,
        amount: Int
    ) -> String
    
    func splitWithCommasInParenthesis(
        of: [Int]
    ) -> String
}
