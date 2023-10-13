import Foundation

public enum NoteDetailsEvents {
    case setColor(color: NoteColor)
    case setTitle(title: String)
    case setNote(note: String)
    case getNote(noteId: Int)
    case submit
}

public class NoteDetailsVM {
    // state
    public private(set) var state: NoteDetailsState
    // di
    private let notesSqlService: INotesService
    private let screenType: NoteDetailsType
    private let noteId: Int?
    
    public init(
        state: NoteDetailsState = .init(),
        screenType: NoteDetailsType = .create,
        noteId: Int? = nil,
        notesSqlService: INotesService = notesServiceProvider()
    ) {
        self.state = state
        self.screenType = screenType
        self.noteId = noteId
        self.notesSqlService = notesSqlService
        assert(
            noteId == nil || screenType == .edit,
            "noteId must be provided in edit mode"
        )
        initViewModel()
    }
    
    public func sendEvent(
        event: NoteDetailsEvents
    ) {
        switch event {
        case .setColor(color: _):
            print("")
        case .setTitle(title: _):
            print("")
        case .setNote(note: _):
            print("")
        case .submit:
            print("")
        case let .getNote(noteId: noteId):
            getNoteById(noteId: noteId)
        }
    }
    
    private func initViewModel() {
        switch screenType {
        case .edit:
            getNoteById(noteId: noteId!)
        case .create:
            state.screenState = .success
        }
    }
        
    private func getNoteById(noteId: Int) {
        state.screenState = .loading
            
        Task {
            let result = await notesSqlService.getNoteById(id: noteId)
            switch result {
            case let .success(data: data):
                    
                // error
                guard let nilNote = data,
                      let note = nilNote
                else {
                    state.screenState = .error
                    return
                }
                    
                // succes
                await MainActor.run {
                    state.title = note.title
                    state.note = note.content
                    state.color = note.color
                    state.screenState = .success
                }
            case .error(message: _):
                await MainActor.run {
                    state.screenState = .error
                }
            }
        }
    }
}
