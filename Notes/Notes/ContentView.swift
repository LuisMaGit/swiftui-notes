import NotesCoreUI
import NotesFeatures
import SwiftUI

struct ContentView: View {
//    let notesVM: NotesVM
    let noteDetailsVM : NoteDetailsVM

    init() {
//        notesVM = NotesVM()
        noteDetailsVM = NoteDetailsVM(
            screenType: .edit,
            noteId: 19
        )
    }

    var body: some View {
//        Notes(
//            sendEvent: notesVM.sendEvent
//        )
//        .environmentObject(notesVM.state)
        NoteDetails(
            sendEvent: { _ in }
        )
        .environmentObject(noteDetailsVM.state)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
