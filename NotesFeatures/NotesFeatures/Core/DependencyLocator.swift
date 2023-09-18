import Foundation
import NotesCore

public func notesServiceProvider() -> NotesService {
    return NotesService(
        sqlManagerService: sqlManagerServiceProvider(),
        timeService: timeServiceProvider(),
        paginationService: paginationServiceProvider()
    )
}
