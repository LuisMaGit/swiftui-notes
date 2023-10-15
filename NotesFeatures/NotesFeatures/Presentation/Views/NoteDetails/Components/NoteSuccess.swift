import NotesCoreUI
import SwiftUI

struct NoteSuccess: View {
    @EnvironmentObject private var state: NoteDetailsState
    let sendEvent: (_ event: NoteDetailsEvents) -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            content
            floatingButton
                .padding(
                    .all,
                    NSpace.k16
                )
        }
    }

    var floatingButton: some View {
        FloatingCircleButton(
            onTap: { sendEvent(.submit) }
        )
    }

    var content: some View {
        let background = NotesColorsUtils.notesColorMap[state.color] ?? NColors.background
        return VStack(spacing: 0) {
            // color
            ColorSelector(
                colors: NotesColorsUtils.nColors,
                onTapColor: { idx in
                    let color = NotesColorsUtils.noteColors[idx]
                    sendEvent(.setColor(color: color))
                },
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
                onChange: { value in
                    sendEvent(.setTitle(title: value))
                },
                hintKey: "notes-details.title.hint",
                textHandleHintColor: NColors.backgroundInverseLight
            )
            .submitLabel(.continue)
            .padding(
                .bottom, NSpace.k16
            )
            // note
            NTextEditor(
                text: state.note,
                onChange: { value in
                    sendEvent(.setNote(note: value))
                },
                backgroundColor: background,
                hintKey: "notes-details.title.note",
                textHandleHintColor: NColors.backgroundInverseLight
            )
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
