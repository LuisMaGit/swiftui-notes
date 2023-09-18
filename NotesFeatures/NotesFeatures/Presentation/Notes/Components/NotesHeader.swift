import NotesCoreUI
import SwiftUI

enum NotesHeaderStyles {
    static let height = 100.0
    static let iconSpacing = NSpace.k8
}

struct NotesHeader: View {
    let mode: NotesHeaderMode
    let switchMode: (_ to: NotesHeaderMode) -> Void
    let notesSelected: Int
    let onTapFilter: () -> Void
    let filterSelected: Bool

    var body: some View {
        HStack(spacing: 0) {
            switch mode {
                case .initial:
                    appBarView
                case .searchbar:
                    searchView
                case .itemsSelected:
                    selectionMode
            }
        }
        .frame(
            height: NotesHeaderStyles.height
        )
        .background(
            NColors.background
        )
    }

    @ViewBuilder var appBarView: some View {
        NText(
            "notes.header.title",
            type: .title,
            lineLimit: 1
        )
        Spacer()
        NotesHeaderRippleButtonIcon(
            action: onTapFilter,
            icon: NIconsType.horizontaldecrease,
            fixedFeedBack: filterSelected
        )
        .padding(
            .trailing,
            NotesHeaderStyles.iconSpacing
        )
        NotesHeaderRippleButtonIcon(
            action: { switchMode(.searchbar) },
            icon: NIconsType.magnifyingglass
        )
    }

    @ViewBuilder var searchView: some View {
        NSearchField(
            hint: "searchbar.hint"
        )
        .padding(
            .trailing,
            NotesHeaderStyles.iconSpacing
        )
        NotesHeaderRippleButtonIcon(
            action: { switchMode(.initial) },
            icon: NIconsType.xmark
        )
    }

    @ViewBuilder var selectionMode: some View {
        NText(
            "notes.header.items-selected",
            lineLimit: 1
        )
        .padding(
            .trailing,
            NotesHeaderStyles.iconSpacing
        )
        NText(
            "\(notesSelected)",
            font: .poppinsBlack
        )
        Spacer()
        NotesHeaderRippleButtonIcon(
            action: { switchMode(.searchbar) },
            icon: NIconsType.trash
        )
    }
}

struct NotesHeader_Previews: PreviewProvider {
    static var previews: some View {
        NotesHeader(
            mode: .initial,
            switchMode: { _ in },
            notesSelected: 10,
            onTapFilter: {},
            filterSelected: true
        )
        .background(.red)
    }
}
