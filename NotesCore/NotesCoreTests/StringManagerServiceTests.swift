@testable import NotesCore
import XCTest

final class StringManagerServiceTests: XCTestCase {
    func test_getFirstChars_with_less_or_equal_than_amount() {
        let service = StringMangerService()
        let stub = "Luisma"
        XCTAssertEqual(
            stub,
            service.getFirstChars(
                of: stub,
                amount: stub.count
            )
        )
    }

    func test_getFirstChars_amount_in_big_texts() {
        let service = StringMangerService()
        let stub = """
        Laboris dolor consequat sunt mollit labore sit sunt est occaecat laborum
        reprehenderit voluptate. Ullamco magna exercitation magna exercitation proident
        commodo occaecat veniam ex in ad eu. Pariatur non do fugiat sunt enim voluptate
        enim anim veniam cupidatat. Anim anim est ipsum cupidatat ea deserunt do laborum
        cupidatat ad nostrud. In consectetur non non commodo commodo sunt occaecat dolor.
        Dolor sint voluptate in incididunt eu proident officia labore fugiat sunt.
        Nulla non sit culpa exercitation deserunt culpa ex laboris eiusmod in nisi fugiat quis Lorem.
        """
        let expected = """
        Laboris dolor consequat sunt mollit labore sit sunt est occaecat laborum
        reprehenderit voluptate. Ul
        """
        XCTAssertEqual(
            expected,
            service.getFirstChars(
                of: stub,
                amount: 100
            )
        )
    }

    func test_splitWithCommasInParenthesis() {
        let service = StringMangerService()
        let resultMulti = service.splitWithCommasInParenthesis(
            of: [1, 2, 3]
        )
        XCTAssertEqual(resultMulti, "(1, 2, 3)")
        
        let resultSingle = service.splitWithCommasInParenthesis(
            of: [1]
        )
        XCTAssertEqual(resultSingle, "(1)")
        
        let resultEmtpy = service.splitWithCommasInParenthesis(
            of: []
        )
        XCTAssertEqual(resultEmtpy, "()")
    }
}
