import NotesCoreUI
import NotesFeatures
import SwiftUI

struct ContentView: View {
    let notesVM: NotesVM

    init() {
        notesVM = NotesVM()
    }

    var body: some View {
        Notes(
            sendEvent: notesVM.sendEvent
        ).environmentObject(notesVM.state)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
