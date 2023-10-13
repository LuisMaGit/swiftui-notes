import NotesCoreUI
import SwiftUI

struct NoteSuccess: View {
    @EnvironmentObject var state: NoteDetailsState
    let sendEvent: (_ event: NotesVMEvents) -> Void

    var body: some View {
        let background = NotesColorsUtils.notesColorMap[state.color] ?? NColors.background
        VStack(spacing: 0) {
            // color
            ColorSelector(
                colors: NotesColorsUtils.nColors,
                onTapColor: { _ in },
                selectedColor: NotesColorsUtils.noteColors.firstIndex(
                    of: state.color
                ) ?? 0
            )
            .padding(
                .bottom, NSpace.k16
            )
            .background(background)
            // title
            NTextField(
                text: state.title,
                backgroundColor: background,
                onChange: { _ in },
                hintKey: "notes-details.title.hint"
            )
            .submitLabel(.continue)
            .padding(
                .bottom, NSpace.k16
            )
            // note
            NTextEditor(
                text: state.note,
                onChange: { _ in },
                backgroundColor: background,
                hintKey: "notes-details.title.note"
            )
            .submitLabel(.continue)
        }
        .nHPadding()
        .background(background)
    }
}

struct NoteSuccess_Previews: PreviewProvider {
    static var previews: some View {
        NoteSuccess(
            sendEvent: { _ in }
        )
        .environmentObject(
            NoteDetailsState(
                color: .lightGreen
            )
        )
    }
}
