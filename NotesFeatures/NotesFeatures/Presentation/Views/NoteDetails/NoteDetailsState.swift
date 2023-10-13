import Foundation
import NotesCore

public class NoteDetailsState: ObservableObject {
    @Published var color: NoteColor
    @Published var title: String
    @Published var note: String
    @Published var screenState: BasicScreenState

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

public enum NoteDetailsType {
    case edit
    case create
}
