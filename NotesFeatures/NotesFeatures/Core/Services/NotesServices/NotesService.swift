import Foundation
import NotesCore

public class NotesService: INotesService {
    // di
    private let logger: LoggerService
    private let sqlManagerService: ISqlManagerService
    private let timeService: ITimeService
    private let paginationService: IPaginationService
    private let stringService: IStringManagerService
    // control
    private let noteSchema: [SqlManagerColumnTypeMapper] = [
        .integer, // rowid
        .text, // title
        .text, // content
        .text, // color
        .text, // date
    ]

    public init(
        logger: LoggerService = LoggerService(
            logFrom: "NotesSqlService"
        ),
        sqlManagerService: ISqlManagerService,
        timeService: ITimeService,
        paginationService: IPaginationService,
        stringService: IStringManagerService
    ) {
        self.logger = logger
        self.sqlManagerService = sqlManagerService
        self.timeService = timeService
        self.paginationService = paginationService
        self.stringService = stringService
    }

    private func queryNotes(
        page: Int,
        itemsInPage: Int,
        query: String
    ) async -> Result<Pagination<Note>> {
        let resultQuery = await sqlManagerService.multipleRowsQuery(
            query: query,
            resultColumnMapper: noteSchema
        )

        switch resultQuery {
        // error query
        case let .error(message: message):
            logger.error("query: \(query): \(String(describing: message))")
            return Result.error(message: message)
        // map query to object
        case let .success(data: source):
            // columns validation
            if let sourceValidated = source,
               !sourceValidated.isEmpty,
               !sourceValidated.values.isEmpty,
               !(sourceValidated.values.first?.isEmpty ?? true)
            {
                // map source map to [Note] model
                let rowCount = sourceValidated.first!.value.count
                var notes: [Note] = []
                for rowIdx in 0 ..< rowCount {
                    let base = Note()
                    // rowid: 0
                    let id = sourceValidated[0]?[rowIdx] as? Int ?? base.id
                    // title: 1
                    let title = sourceValidated[1]?[rowIdx] as? String ?? base.title
                    // content: 2
                    let content = sourceValidated[2]?[rowIdx] as? String ?? base.content
                    // color: 3
                    let color = NoteColor.getType(
                        raw: sourceValidated[3]?[rowIdx] as? String ?? base.color.rawValue
                    )
                    // date: 4
                    let creationDate = timeService.dateToDateVisualizer(
                        source: sourceValidated[4]?[rowIdx] as? String
                    )
                    let shortContent = stringService.getFirstChars(
                        of: content,
                        amount: FIRST_CHARS_DEFAULT
                    )
                    let note = Note(
                        id: id,
                        title: title,
                        content: content,
                        shortContent: shortContent,
                        color: color,
                        creationDate: creationDate
                    )
                    notes.append(note)
                }
                // data
                return Result.success(
                    data: Pagination(
                        page: page,
                        data: notes
                    )
                )
            }

            // data empty
            return Result.success(
                data: Pagination(
                    page: page,
                    data: []
                )
            )
        }
    }

    public func getNotes(
        page: Int,
        itemsInPage: Int,
        latest: Bool
    ) async -> Result<Pagination<Note>> {
        let offset = paginationService.convertPageInSqlOffset(
            page: page,
            itemsInPage: itemsInPage
        )
        let query = latest ?
            notesPaginatedQuery(
                limit: itemsInPage,
                offset: offset
            ) :
            notesOlderPaginatedQuery(
                limit: itemsInPage,
                offset: offset
            )
        return await queryNotes(
            page: page,
            itemsInPage: itemsInPage,
            query: query
        )
    }

    public func searchNotes(
        page: Int,
        itemsInPage: Int,
        search: String
    ) async -> Result<Pagination<Note>> {
        let query = searchNotesPaginatedQuery(
            search: search,
            limit: itemsInPage,
            offset: paginationService.convertPageInSqlOffset(
                page: page,
                itemsInPage: itemsInPage
            )
        )

        return await queryNotes(
            page: page,
            itemsInPage: itemsInPage,
            query: query
        )
    }

    public func deleteNotes(
        ids: [Int]
    ) async -> Result<Never> {
        let ids = stringService.splitWithCommasInParenthesis(of: ids)
        let result = await sqlManagerService.noResultQuery(
            query: deleteNotesQuery(ids: ids)
        )

        return result
    }

    public func notesByColor(
        page: Int,
        itemsInPage: Int,
        color: NoteColor
    ) async -> Result<Pagination<Note>> {
        let query = filterNotesByColor(
            color: color.rawValue,
            limit: itemsInPage,
            offset: paginationService.convertPageInSqlOffset(
                page: page,
                itemsInPage: itemsInPage
            )
        )

        return await queryNotes(
            page: page,
            itemsInPage: itemsInPage,
            query: query
        )
    }

    public func getNoteById(
        id: Int
    ) async -> Result<Note?> {
        let query = selectNoteById(id: id)

        let resultQuery = await sqlManagerService.singleRowQuery(
            query: query,
            resultColumnMapper: noteSchema
        )

        switch resultQuery {
        // error query
        case let .error(message: message):
            logger.error("query: \(query): \(String(describing: message))")
            return Result.error(message: message)

        // map query to object
        case let .success(data: source):
            if let sourceValidated = source,
               !sourceValidated.isEmpty
            {
                let base = Note()
                // rowid: 0
                let id = sourceValidated[0] as? Int ?? base.id
                // title: 1
                let title = sourceValidated[1] as? String ?? base.title
                // content: 2
                let content = sourceValidated[2] as? String ?? base.content
                // color: 3
                let color = NoteColor.getType(
                    raw: sourceValidated[3] as? String ?? base.color.rawValue
                )
                // date: 4
                let creationDate = timeService.dateToDateVisualizer(
                    source: sourceValidated[4] as? String
                )
                let shortContent = stringService.getFirstChars(
                    of: content,
                    amount: FIRST_CHARS_DEFAULT
                )
                let note = Note(
                    id: id,
                    title: title,
                    content: content,
                    shortContent: shortContent,
                    color: color,
                    creationDate: creationDate
                )

                return Result.success(data: note)

            } else {
                // data empty
                return Result.success()
            }
        }
    }
}
