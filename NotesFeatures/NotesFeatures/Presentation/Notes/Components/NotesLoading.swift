
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
        NotesLoading(
            state: .init(),
            sendEvent: { _ in }
        )
    }
}
