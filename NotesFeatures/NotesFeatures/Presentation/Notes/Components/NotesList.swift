import NotesCoreUI
import SwiftUI

struct NotesList: View {
    @EnvironmentObject var state: NotesState
    let sendEvent: (_ event: NotesVMEvents) -> Void

    var body: some View {
        wrapper {
            ForEach(
                state.allNotes.data.indices,
                id: \.self
            ) { idx in
                let note = state.allNotes.data[idx]
                NoteCard(
                    title: note.title,
                    content: note.content,
                    color: NotesColorsUtils.getColor(
                        note.color
                    ),
                    date: CoreUIUtils.dateFromDateVisualizer(
                        dateVisualizer: note.creationDate
                    ),
                    time: CoreUIUtils.timeFromDateVisualizer(
                        dateVisualizer: note.creationDate
                    )
                )
            }
        }
    }

    func wrapper<Content: View>(
        content: () -> Content
    ) -> some View {
        return ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            LazyVStack(
                alignment: .leading,
                spacing: 0,
                pinnedViews: [.sectionHeaders]
            ) {
                Section(
                    header: NotesHeader(
                        sendEvent: sendEvent
                    )
                ) {
                    content()
                }
            }
        }
    }
}

struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList(
            state: .init(),
            sendEvent: { _ in }
        )
    }
}
