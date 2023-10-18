import Foundation
import NotesCore

public struct NoteDetailsState {
    var color: NoteColor
    var title: String
    var note: String
    var screenState: BasicScreenState

    public init(
        color: NoteColor = Note.DEFAULT_COLOR,
        title: String = "",
        note: String = "",
        screenState: BasicScreenState = .loading
    ) {
        self.color = color
        self.title = title
        self.note = note
        self.screenState = screenState
    }
}
