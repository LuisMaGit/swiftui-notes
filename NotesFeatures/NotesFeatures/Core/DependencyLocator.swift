import Foundation
import NotesCore

public func notesServiceProvider() -> INotesService {
    return NotesService(
        sqlManagerService: sqlManagerServiceProvider(),
        timeService: timeServiceProvider(),
        paginationService: paginationServiceProvider(),
        stringService: stringManagerServiceProvider()
    )
}
