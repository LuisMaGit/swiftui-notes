import Foundation
import NotesCore

public class NotesService: INotesService {
    let logger: LoggerService
    let sqlManagerService: ISqlManagerService
    let timeService: ITimeService
    let paginationService: IPaginationService
    let stringService: IStringManagerService

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

    public func getNotes(
        page: Int,
        itemsInPage: Int
    ) -> Result<Pagination<Note>> {
        let query = selectNotesPaginatedQuery(
            limit: itemsInPage,
            offset: paginationService.convertPageInSqlOffset(
                page: page,
                itemsInPage: itemsInPage
            )
        )
        let resultQuery = sqlManagerService.multipleRowsQuery(
            query: query,
            resultColumnMapper: [
                .integer, // row_id
                .text, // title
                .text, // content
                .text, // color
                .text, // date
            ]
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
                    // row_id: 0
                    let id = sourceValidated[0]?[rowIdx] as? Int ?? base.id
                    // title: 1
                    let title = sourceValidated[1]?[rowIdx] as? String ?? base.title
                    // content: 2
                    let content = sourceValidated[2]?[rowIdx] as? String ?? base.content
                    // color: 3
                    let color = sourceValidated[3]?[rowIdx] as? String ?? base.color
                    // color: 4
                    let creationDate = timeService.dateToDateVisualizer(
                        source: sourceValidated[4]?[rowIdx] as? String
                    )
                    let shortContent = stringService.getFirstChars(
                        of: title,
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
}
