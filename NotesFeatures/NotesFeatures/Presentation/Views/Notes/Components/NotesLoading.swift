
import NotesCoreUI
import SwiftUI

struct NotesLoading: View {
    @EnvironmentObject var state: NotesState
    let sendEvent: (_ event: NotesVMEvents) -> Void
    
    var body: some View {
        VStack {
            NotesHeader(
                sendEvent: sendEvent
            )
            Spacer()
            NLoader()
            Spacer()
        }
    }
}

struct NotesLoading_Previews: PreviewProvider {
    static var previews: some View {
        let vm: NotesVM = .init()
        Notes(
            sendEvent: vm.sendEvent
        )
        .environmentObject(
            NotesState(
                screenState: .loading
            )
        )
    }
}
