import NotesCoreUI
import SwiftUI

struct NotesError: View {
    @EnvironmentObject var viewmodel: NotesVM

    var body: some View {
        VStack {
            NotesHeader()
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
                action: { viewmodel.sendEvent(.tryAgain) },
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
        NotesError()
            .environmentObject(
                NotesVM(
                    state: NotesState(
                        screenState: .loading
                    )
                )
            )
    }
}
