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

    func test_getNotes_empty_rows_and_column_result() async {
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
        let result = await notesService.getNotes(
            page: page,
            itemsInPage: 1,
            latest: true
        )

        // assert
        XCTAssertEqual(
            sqlManagerService.multipleRowsQueryQueryResultColumnMapperCallsCount,
            1
        )

        XCTAssertEqual(expected, result)
    }

    func test_getNotes_empty_rows_result() async {
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
        let result = await notesService.getNotes(
            page: page,
            itemsInPage: 1,
            latest: true
        )

        // assert
        XCTAssertEqual(
            sqlManagerService.multipleRowsQueryQueryResultColumnMapperCallsCount,
            1
        )

        XCTAssertEqual(expected, result)
    }

    func test_getNotes_with_data_result() async {
        // setup
        let page = 1
        let shortContent = "first chars"
        let queryResult: [Int: [Any]] = [
            0: [1, 2, 3],
            1: ["Title 1", "Title 2", "Title 3"],
            2: ["Content 1", "Content 2", "Content 3"],
            3: ["light_green", "Color 2", "red_pink"],
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
                        color: NoteColor.lightGreen,
                        creationDate: nil
                    ),
                    Note(
                        id: 2,
                        title: "Title 2",
                        content: "Content 2",
                        shortContent: shortContent,
                        color: Note.DEFAULT_COLOR,
                        creationDate: nil
                    ),
                    Note(
                        id: 3,
                        title: "Title 3",
                        content: "Content 3",
                        shortContent: shortContent,
                        color: NoteColor.redPink,
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
        let result = await notesService.getNotes(
            page: page,
            itemsInPage: 1,
            latest: true
        )

        // assert
        XCTAssertEqual(
            sqlManagerService.multipleRowsQueryQueryResultColumnMapperCallsCount,
            1
        )
        XCTAssertEqual(expected, result)
    }

    func test_getNoteByID_data_result() async {
        // setup
        let queryResult: [Int: Any] = [
            0: 1,
            1: "Title 1",
            2: "Content 1",
            3: "red_pink",
            4: "nil",
        ]

        let shortContent = "first chars"

        let expected: Result<Note?> = Result.success(
            data: Note(
                id: 1,
                title: "Title 1",
                content: "Content 1",
                shortContent: shortContent,
                color: NoteColor.redPink
            )
        )

        stringService.getFirstCharsOfAmountReturnValue = shortContent
        sqlManagerService.openDBReturnValue = Result.success()
        sqlManagerService.singleRowQueryQueryResultColumnMapperReturnValue = AnyResult.success(
            data: queryResult
        )

        let notesService = getAndRegisterNotesService()

        // act
        let result = await notesService.getNoteById(id: 1)

        // assert
        XCTAssertEqual(
            sqlManagerService.singleRowQueryQueryResultColumnMapperCallsCount,
            1
        )
        XCTAssertEqual(expected, result)
    }
}
