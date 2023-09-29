import NotesCoreUI
import SwiftUI

struct NotesEmpty: View {
    @EnvironmentObject var state: NotesState
    let sendEvent: (_ event: NotesVMEvents) -> Void
    
    var body: some View {
        VStack {
            NotesHeader(
                sendEvent: sendEvent
            )
            NText(
                key: "notes.empty-result.label",
                type: .caption,
                color: NColors.backgroundLighterInverse
            )
            .padding(
                .top,
                NSpace.k8
            )
            Spacer()
        }
    }
}

struct NotesEmpty_Previews: PreviewProvider {
    static var previews: some View {
        NotesEmpty(
            state: .init(),
            sendEvent: { _ in }
        )
    }
}
