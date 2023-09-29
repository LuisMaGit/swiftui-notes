import Foundation

import Foundation
import NotesCore

public protocol INotesService {
    func getNotes(
        page: Int,
        itemsInPage: Int
    ) -> Result<Pagination<Note>>
}
