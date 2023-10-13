import NotesCoreUI
import SwiftUI

struct NotesError: View {
    @EnvironmentObject var state: NotesState
    let sendEvent: (_ event: NotesVMEvents) -> Void
    
    var body: some View {
        VStack {
            NotesHeader(
                sendEvent: sendEvent
            )
            Spacer()
            NIcons(
                type: .multiplyCircle,
                size: notesBigIconSize
            )
            .padding(
                .bottom,
                NSpace.k4
            )
            NText(
                key: "error.label"
            )
            .padding(
                .bottom,
                NSpace.k16
            )
            RippleButton(
                action: {sendEvent(.tryAgain)},
                content: {
                    NText(
                        key: "try-again.label",
                        color: NColors.accent
                    )
                }
            )
            Spacer()
        }
    }
}

struct NotesError_Previews: PreviewProvider {
    static var previews: some View {
        let vm: NotesVM = .init()
        Notes(
            sendEvent: vm.sendEvent
        )
        .environmentObject(
            NotesState(
                screenState: .error
            )
        )
    }
}

