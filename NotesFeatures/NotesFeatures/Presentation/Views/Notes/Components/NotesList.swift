import NotesCore
import NotesCoreUI
import SwiftUI

struct NotesList: View {
    @EnvironmentObject var viewmodel: NotesVM

    var body: some View {
        let allNotes = viewmodel.state.notes.data
        wrapper {
            ForEach(
                allNotes.indices,
                id: \.self
            ) { idx in
                let note = viewmodel.state.notes.data[idx]
                cardBuilder(
                    idx: idx,
                    note: note,
                    isLastView: idx == allNotes.count - 1,
                    selected: viewmodel.state.notesSelectedMap[idx] ?? false
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
                    dateVisualizer: note.lastEditDate
                ),
                time: CoreUIUtils.timeFromDateVisualizer(
                    dateVisualizer: note.lastEditDate
                ),
                onTap: {
                    viewmodel.sendEvent(.onTapNote(idx: idx))
                },
                onLongPress: {
                    viewmodel.sendEvent(.onLongPressNote(idx: idx))
                }
            )

        if isLastView, viewmodel.state.showLoadingMore {
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
                viewmodel.sendEvent(.triggerNextPage)
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
                    header: NotesHeader()
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
        let notesIdxs = Array(0 ..< 2)
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
        return NotesList()
            .environmentObject(NotesVM(state: state))
    }
}
