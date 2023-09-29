import NotesCore
@testable import NotesFeatures
import XCTest

final class NotesServiceTest: XCTestCase {
    var sqlManagerService: ISqlManagerServiceMock!
    var timeServiceMock: ITimeServiceMock!
    var paginationService: IPaginationServiceMock!
    var stringService: IStringManagerServiceMock!

    private func getAndRegisterNotesService() -> NotesService {
        return NotesService(
            sqlManagerService: sqlManagerService,
            timeService: timeServiceMock,
            paginationService: paginationService,
            stringService: stringService
        )
    }

    override func setUpWithError() throws {
        sqlManagerService = ISqlManagerServiceMock()
        timeServiceMock = ITimeServiceMock()
        paginationService = IPaginationServiceMock()
        stringService = IStringManagerServiceMock()
    }

    override func tearDownWithError() throws {
        sqlManagerService = nil
        timeServiceMock = nil
        paginationService = nil
        stringService = nil
    }

    func test_getNotes_empty_rows_and_column_result() {
        // setup
        let page = 1
        sqlManagerService.openDBReturnValue = Result.success()
        sqlManagerService
            .multipleRowsQueryQueryResultColumnMapperReturnValue = AnyResult.success(
                data: [0: []]
            )
        paginationService.convertPageInSqlOffsetPageItemsInPageReturnValue = 1
        let expected = Result.success(
            data: Pagination<Note>(
                page: page,
                data: [Note]()
            )
        )
        let notesService = getAndRegisterNotesService()

        // act
        let result = notesService.getNotes(
            page: page,
            itemsInPage: 1
        )

        // assert
        XCTAssertEqual(
            sqlManagerService.multipleRowsQueryQueryResultColumnMapperCallsCount,
            1
        )

        XCTAssertEqual(expected, result)
    }

    func test_getNotes_empty_rows_result() {
        // setup
        let page = 1
        sqlManagerService.openDBReturnValue = Result.success()
        sqlManagerService
            .multipleRowsQueryQueryResultColumnMapperReturnValue = AnyResult.success(
                data: [
                    0: [],
                    1: [],
                    2: [],
                    3: [],
                    4: [],
                ]
            )
        paginationService.convertPageInSqlOffsetPageItemsInPageReturnValue = 1
        let expected = Result.success(
            data: Pagination<Note>(
                page: page,
                data: [Note]()
            )
        )
        let notesService = getAndRegisterNotesService()

        // act
        let result = notesService.getNotes(
            page: page,
            itemsInPage: 1
        )

        // assert
        XCTAssertEqual(
            sqlManagerService.multipleRowsQueryQueryResultColumnMapperCallsCount,
            1
        )

        XCTAssertEqual(expected, result)
    }

    func test_getNotes_with_data_result() {
        // setup
        let page = 1
        let shortContent = "first chars"
        let queryResult: [Int: [Any]] = [
            0: [1, 2, 3],
            1: ["Title 1", "Title 2", "Title 3"],
            2: ["Content 1", "Content 2", "Content 3"],
            3: ["Color 1", "Color 2", "Color 3"],
            4: ["nil", "nil", "nil"],
        ]
        let expected = Result.success(
            data: Pagination<Note>(
                page: page,
                data: [
                    Note(
                        id: 1,
                        title: "Title 1",
                        content: "Content 1",
                        shortContent: shortContent,
                        color: "Color 1",
                        creationDate: nil
                    ),
                    Note(
                        id: 2,
                        title: "Title 2",
                        content: "Content 2",
                        shortContent: shortContent,
                        color: "Color 2",
                        creationDate: nil
                    ),
                    Note(
                        id: 3,
                        title: "Title 3",
                        content: "Content 3",
                        shortContent: shortContent,
                        color: "Color 3",
                        creationDate: nil
                    ),
                ]
            )
        )
        stringService.getFirstCharsOfAmountReturnValue = shortContent
        sqlManagerService.openDBReturnValue = Result.success()
        sqlManagerService
            .multipleRowsQueryQueryResultColumnMapperReturnValue = AnyResult.success(
                data: queryResult
            )
        paginationService.convertPageInSqlOffsetPageItemsInPageReturnValue = 1
        let notesService = getAndRegisterNotesService()

        // act
        let result = notesService.getNotes(
            page: page,
            itemsInPage: 1
        )
        XCTAssertEqual(
            sqlManagerService.multipleRowsQueryQueryResultColumnMapperCallsCount,
            1
        )
        XCTAssertEqual(expected, result)
    }
}
