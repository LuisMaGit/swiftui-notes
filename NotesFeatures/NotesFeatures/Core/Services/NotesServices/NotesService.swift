import Foundation
import NotesCore

public class NotesService {
    let logger: LoggerService
    let sqlManagerService: SqlManagerService
    let timeService: TimeService
    let paginationService: PaginationService

    public init(
        logger: LoggerService = LoggerService(logFrom: "NotesSqlService"),
        sqlManagerService: SqlManagerService,
        timeService: TimeService,
        paginationService: PaginationService
    ) {
        self.logger = logger
        self.sqlManagerService = sqlManagerService
        self.timeService = timeService
        self.paginationService = paginationService
        connectionResult = sqlManagerService.openDB()
    }

    public private(set) var connectionResult = Result<Never>.error(
        message: ""
    )

    public func getNotes(page: Int) -> Result<Pagination<Note>> {
        // error db connection
        if case .error(message: let message) = connectionResult {
            return Result.error(message: message)
        }

        // query
        let resultQuery = sqlManagerService.multipleRowsQuery(
            query: selectNotesPaginatedQuery(
                limit: paginationService.itemsInPage,
                offset: paginationService.convertPageInSqlOffset(page)
            ),
            resultColumnMapper: [
                .integer, // row_id
                .text, // title
                .text, // content
                .text, // color
                .text // date
            ]
        )

        switch resultQuery {
            // error query
            case .error(message: let message):
                return Result.error(message: message)
            // map query to object
            case .success(data: let source):

                // columns validation
                if let sourceValidated = source,
                   sourceValidated.isEmpty,
                   sourceValidated.values.isEmpty,
                   sourceValidated.values.first?.isEmpty ?? true
                {
                    return Result.success(
                        data: Pagination(
                            page: page,
                            data: []
                        )
                    )
                }

                // map source map to [Note] model
                let rowCount = source!.first!.value.count
                var notes: [Note] = []
                for rowIdx in 0 ..< rowCount {
                    var note = Note()
                    // row_id: 0
                    note.id = source?[0]?[rowIdx] as? Int ?? note.id
                    // title: 1
                    note.title = source?[1]?[rowIdx] as? String ?? note.title
                    // content: 2
                    note.content = source?[2]?[rowIdx] as? String ?? note.content
                    // color: 3
                    note.color = source?[3]?[rowIdx] as? String ?? note.color
                    // color: 4
                    note.dateCreation = timeService.convertStringToDate(
                        source: source?[4]?[rowIdx] as? String
                    )
                    notes.append(note)
                }

                return Result.success(
                    data: Pagination(
                        page: page,
                        data: notes
                    )
                )
        }
    }
}
