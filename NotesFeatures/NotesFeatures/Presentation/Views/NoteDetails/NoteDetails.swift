import NotesCore
import NotesCoreUI
import SwiftUI

public struct NoteDetails: View {
    @StateObject var viewmodel = NoteDetailsVM()
    let screenType: FormScreenType
    let noteId: Int?

    public init(
        screenType: FormScreenType,
        noteId: Int?
    ) {
        self.screenType = screenType
        self.noteId = noteId
    }

    public var body: some View {
        Group {
            switch viewmodel.state.screenState {
                case .loading:
                    NoteLoading()
                case .error:
                    NoteError()
                case .success:
                    NoteSuccess()
                default:
                    Rectangle()
            }
        }
        .environmentObject(viewmodel)
        .onAppear {
            viewmodel.sendEvent(
                .onAppear(
                    noteId: noteId,
                    screenType: screenType
                )
            )
        }
    }
}

struct NoteDetails_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetails(
            screenType: .create,
            noteId: 1
        )
        .environmentObject(NotesVM())
    }
}
