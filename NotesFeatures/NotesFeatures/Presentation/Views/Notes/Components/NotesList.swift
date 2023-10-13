import NotesCore
import NotesCoreUI
import SwiftUI

struct NotesList: View {
    @EnvironmentObject var state: NotesState
    let sendEvent: (_ event: NotesVMEvents) -> Void

    var body: some View {
        let allNotes = state.notes.data
        wrapper {
            ForEach(
                allNotes.indices,
                id: \.self
            ) { idx in
                let note = state.notes.data[idx]
                cardBuilder(
                    idx: idx,
                    note: note,
                    isLastView: idx == allNotes.count - 1,
                    selected: state.notesSelectedMap[idx] ?? false
                )
            }
        }
    }

    @ViewBuilder
    func cardBuilder(
        idx: Int,
        note: Note,
        isLastView: Bool,
        selected: Bool
    ) -> some View {
        let noteView = NoteCard(
            title: note.title,
            content: note.shortContent,
            selected: selected,
            color: NotesColorsUtils.notesColorMap[
                note.color
            ] ?? NotesColorsUtils.notesColorMap[
                Note.DEFAULT_COLOR
            ]!,
            date: CoreUIUtils.dateFromDateVisualizer(
                dateVisualizer: note.creationDate
            ),
            time: CoreUIUtils.timeFromDateVisualizer(
                dateVisualizer: note.creationDate
            ),
            onTap: {
                sendEvent(.onTapNote(idx: idx))
            },
            onLongPress: {
                sendEvent(.onLongPressNote(idx: idx))
            }
        )

        if isLastView, state.showLoadingMore {
            VStack {
                noteView
                loaderView
            }
        } else {
            noteView
                .padding(.bottom, NSpace.k16)
        }
    }

    var loaderView: some View {
        NLoader()
            .padding(.vertical, NSpace.k8)
            .onAppear {
                sendEvent(.triggerNextPage)
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
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
    }
}

struct NotesSuccess_Previews: PreviewProvider {
    static var previews: some View {
        let vm: NotesVM = .init()
        let notesIdxs = Array(0 ..< 5)
        let notes = Pagination(
            page: 1,
            data: notesIdxs
                .map {
                    idx in Note(
                        id: idx,
                        title: "Title \(idx)",
                        shortContent: "Content \(idx)"
                    )
                }
        )

        var selected: [Int: Bool] = [:]
        notesIdxs.forEach { idx in
            selected.updateValue(idx == 0 || idx % 2 == 0, forKey: idx)
        }

        let state = NotesState(
            notes: notes,
            screenState: .success,
            showLoadingMore: true,
            selectedNotes: selected
        )
        return Notes(
            sendEvent: vm.sendEvent
        )
        .environmentObject(state)
    }
}
