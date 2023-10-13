import Foundation

import Foundation
import NotesCore

public protocol INotesService {
    func getNotes(
        page: Int,
        itemsInPage: Int,
        latest: Bool
    ) async -> Result<Pagination<Note>>
    
    func searchNotes(
        page: Int,
        itemsInPage: Int,
        search: String
    ) async -> Result<Pagination<Note>>
    
    func deleteNotes(
        ids: [Int]
    ) async -> Result<Never>
    
    func notesByColor(
        page: Int,
        itemsInPage: Int,
        color: NoteColor
    ) async -> Result<Pagination<Note>>
    
    func getNoteById(
        id: Int
    ) async -> Result<Note?>
}
