import NotesCoreUI
import SwiftUI

struct NotesHeader: View {
    @EnvironmentObject var state: NotesState
    let sendEvent: (_ event: NotesVMEvents) -> Void

    var body: some View {
        HStack(spacing: 0) {
            switch state.headerMode {
            case .initial:
                appBarView
            case .searchbar:
                searchView
            case .itemsSelected:
                selectionMode
            }
        }
        .frame(
            height: notesHeaderHeight
        )
        .background(
            NColors.background
        )
    }

    @ViewBuilder var appBarView: some View {
        NText(
            key: "notes.header.title",
            type: .title,
            lineLimit: 1
        )
        Spacer()
        NotesHeaderRippleButtonIcon(
            action: {},
            icon: NIconsType.horizontaldecrease,
            fixedFeedBack: false
        )
        .padding(
            .trailing,
            notesHeaderIconSpacing
        )
        NotesHeaderRippleButtonIcon(
            action: {
                sendEvent(.changeAppbar(to: .searchbar))
            },
            icon: NIconsType.magnifyingglass
        )
    }

    @ViewBuilder var searchView: some View {
        NSearchField(
            hint: "notes.searchbar.hint"
        )
        .padding(
            .trailing,
            notesHeaderIconSpacing
        )
        NotesHeaderRippleButtonIcon(
            action: {
                sendEvent(.changeAppbar(to: .initial))
            },
            icon: NIconsType.xmark
        )
    }

    @ViewBuilder var selectionMode: some View {
        NText(
            key: "notes.header.items-selected",
            lineLimit: 1
        )
        .padding(
            .trailing,
            notesHeaderIconSpacing
        )
        NText(
            text: "\(0)",
            font: .poppinsBlack
        )
        Spacer()
        NotesHeaderRippleButtonIcon(
            action: {
                sendEvent(.changeAppbar(to: .initial))
            },
            icon: NIconsType.trash
        )
    }
}

struct NotesHeader_Previews: PreviewProvider {
    static var previews: some View {
        NotesHeader(
            state: .init(),
            sendEvent: { _ in }
        )
        .background(.red)
    }
}
