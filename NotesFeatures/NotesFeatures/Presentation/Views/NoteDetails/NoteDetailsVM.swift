import Foundation
import NotesCore

public enum NoteDetailsEvents {
    case onAppear(noteId: Int?, screenType: FormScreenType)
    case goBack
    case setColor(color: NoteColor)
    case setTitle(title: String)
    case setNote(note: String)
    case getNote(noteId: Int)
    case submit
}

public class NoteDetailsVM: ObservableObject {
    // state
    @Published public private(set) var state: NoteDetailsState
    // di
    private let notesSqlService: INotesService
    // control
    private let snackbarService = SnackbarService.instance
    private let navigationService = NavigationService.instance
    private var screenType: FormScreenType = .create
    private var noteId: Int?
    
    public init(
        state: NoteDetailsState = .init(),
        notesSqlService: INotesService = notesServiceProvider()
    ) {
        self.state = state
        self.notesSqlService = notesSqlService
    }
    
    public func sendEvent(
        _ event: NoteDetailsEvents
    ) {
        switch event {
        case let .onAppear(noteId: noteId, screenType: screenType):
            onAppear(screenType: screenType, noteId: noteId)
        case .goBack:
            goBack()
        case let .setColor(color: color):
            setColor(color: color)
        case let .setTitle(title: title):
            setTitle(value: title)
        case let .setNote(note: note):
            setNote(note: note)
        case .submit:
            submit()
        case let .getNote(noteId: noteId):
            getNoteById(noteId: noteId)
        }
    }
    
    private func goBack() {
        navigationService.goTo(notesRoute: .notes)
    }
    
    private func onAppear(
        screenType: FormScreenType,
        noteId: Int?
    ) {
        assert(
            noteId == nil || screenType == .edit,
            "noteId must be provided in edit mode"
        )
        self.screenType = screenType
        self.noteId = noteId
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
    
    private func setColor(color: NoteColor) {
        if state.color == color {
            return
        }
        
        state.color = color
    }
    
    private func setTitle(value: String) {
        state.title = value
    }
    
    private func setNote(note: String) {
        state.note = note
    }
    
    private func submit() {
        switch screenType {
        case .edit:
            Task {
                let result = await notesSqlService.updateNote(
                    note: Note(
                        id: noteId!,
                        title: state.title,
                        content: state.note,
                        color: state.color
                    )
                )
                
                if case .error(message: _) = result {
                    snackbarService.showSnackbar(.error)
                    return
                }
                
                snackbarService.showSnackbar(.noteEdited)
                goBack()
            }
        case .create:
            Task {
                let result = await notesSqlService.createNote(
                    note: Note(
                        title: state.title,
                        content: state.note,
                        color: state.color
                    )
                )
                
                if case .error(message: _) = result {
                    snackbarService.showSnackbar(.error)
                    return
                }
                
                snackbarService.showSnackbar(.noteAdded)
                goBack()
            }
        }
    }
}
