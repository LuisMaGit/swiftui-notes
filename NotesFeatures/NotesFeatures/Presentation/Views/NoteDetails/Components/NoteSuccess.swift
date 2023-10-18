import NotesCoreUI
import SwiftUI

struct NoteSuccess: View {
    @EnvironmentObject var viewmodel: NoteDetailsVM

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
            onTap: { viewmodel.sendEvent(.submit) },
            icon: .checkmark
        )
    }

    var content: some View {
        let background = NotesColorsUtils.notesColorMap[viewmodel.state.color] ?? NColors.background
        return VStack(spacing: 0) {
            // header
            ZStack(
                alignment: .leading
            ) {
                // color
                ColorSelector(
                    colors: NotesColorsUtils.nColors,
                    onTapColor: { idx in
                        let color = NotesColorsUtils.noteColors[idx]
                        viewmodel.sendEvent(.setColor(color: color))
                    },
                    selectedColor: NotesColorsUtils.noteColors.firstIndex(
                        of: viewmodel.state.color
                    ) ?? 0
                )
                .padding(
                    .bottom, NSpace.k16
                )
                .background(background)
                // back
                NIconButton(
                    action: {
                        viewmodel.sendEvent(.goBack)
                    },
                    icon: .back,
                    iconColor: NColors.backgroundInverse
                )
                .padding(.bottom, NSpace.k16)
            }

            // title
            NTextField(
                text: viewmodel.state.title,
                backgroundColor: background,
                onChange: { value in
                    viewmodel.sendEvent(.setTitle(title: value))
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
                text: viewmodel.state.note,
                onChange: { value in
                    viewmodel.sendEvent(.setNote(note: value))
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
        NoteSuccess()
            .environmentObject(
                NoteDetailsVM(
                    state: NoteDetailsState(
                        color: .babyBlue
                    )
                )
            )
    }
}
