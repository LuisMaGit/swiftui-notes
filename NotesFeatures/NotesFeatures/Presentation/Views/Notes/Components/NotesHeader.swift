import NotesCoreUI
import SwiftUI

struct NotesHeader: View {
    @EnvironmentObject var viewmodel: NotesVM
    
    var body: some View {
        switch viewmodel.state.headerMode {
        case .initial:
            initialView
        case .searchbar:
            searchView
        case .itemsSelected:
            selectionModeView
        case .filter:
            initialAndFilterView
        }
    }
    
    func wrapper<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        HStack(spacing: 0) {
            content()
        }
        .frame(
            height: notesHeaderHeight
        )
        .background(
            NColors.background
        )
    }
    
    @ViewBuilder var initialView: some View {
        wrapper {
            NText(
                key: "notes.header.title",
                type: .title,
                lineLimit: 1
            )
            Spacer()
            NIconButton(
                action: {
                    viewmodel.sendEvent(.onTapFilter)
                },
                icon: NIconsType.horizontaldecrease,
                fixedFeedBack: viewmodel.state.filterSelected
            )
            .padding(
                .trailing,
                notesHeaderIconSpacing
            )
            NIconButton(
                action: {
                    viewmodel.sendEvent(.setSearchMode)
                },
                icon: NIconsType.magnifyingglass
            )
        }
    }
    
    @ViewBuilder var searchView: some View {
        wrapper {
            NSearchField(
                text: viewmodel.state.searchText,
                hint: "notes.searchbar.hint",
                startFocused: true,
                onChangeText: { value in
                    viewmodel.sendEvent(.searchNotes(search: value))
                }
            )
            .padding(
                .trailing,
                notesHeaderIconSpacing
            )
            NIconButton(
                action: {
                    viewmodel.sendEvent(.closeSearchMode)
                },
                icon: NIconsType.xmark
            )
        }
    }
    
    @ViewBuilder var selectionModeView: some View {
        wrapper {
            // close
            NIconButton(
                action: {
                    viewmodel.sendEvent(.closeSelectionMode)
                },
                icon: NIconsType.xmark
            )
            .padding(
                .trailing,
                notesHeaderIconSpacing
            )
            // selected
            NText(
                key: "notes.header.items-selected",
                lineLimit: 1
            )
            .padding(
                .trailing,
                notesHeaderIconSpacing
            )
            // counter
            NText(
                text: String(viewmodel.state.notesSelected),
                font: .poppinsBlack
            )
            .padding(
                .trailing,
                notesHeaderIconSpacing
            )
            Spacer()
            // trash can
            NIconButton(
                action: {
                    viewmodel.sendEvent(.deleteNotes)
                },
                icon: NIconsType.trash
            )
        }
    }
    
    func filterKey(type: NotesFilterType) -> LocalizedStringKey {
        switch type {
        case .latest:
            return "notes.header.filter.latest.button"
        case .older:
            return "notes.header.filter.older.button"
        case .colors:
            return "notes.header.filter.color.button"
        }
    }
        
    @ViewBuilder var initialAndFilterView: some View {
        VStack(spacing: 0) {
            initialView
            Group {
                // filter buttons
                filterView
                    .padding(.bottom, NSpace.k4)
                    .background(
                        NColors.background
                    )
                // colors filter
                if viewmodel.state.filterSelectedType == .colors {
                    filterColorsView
                }
            }
            .padding(.bottom, NSpace.k4)
            .background(
                NColors.background
            )
        }
    }
    
    @ViewBuilder var filterView: some View {
        ScrollView(
            .horizontal
        ) {
            HStack {
                ForEach(
                    NotesFilterType.allCases.indices,
                    id: \.self
                ) { idx in
                    let type = NotesFilterType.allCases[idx]
                    ChipButton(
                        key: filterKey(type: type),
                        selected: type == viewmodel.state.filterSelectedType,
                        onTap: {
                            viewmodel.sendEvent(.selectFilter(type: type))
                        }
                    )
                }
            }
        }
    }
    
    var filterColorsView: some View {
        return ColorSelector(
            colors: NotesColorsUtils.nColors,
            onTapColor: { idx in
                let color = NotesColorsUtils.noteColors[idx]
                viewmodel.sendEvent(.setFilterColor(color: color))
            },
            selectedColor: NotesColorsUtils.noteColors.firstIndex(
                of: viewmodel.state.filterColorSelected
            ) ?? 0
        )
    }
}

struct NotesHeader_Previews: PreviewProvider {
    static var previews: some View {
        NotesHeader()
            .environmentObject(
                NotesVM(
                    state: NotesState(
                        headerMode: .filter,
                        filterSelected: true,
                        filterSelectedType: .colors
                    )
                )
            )
    }
}
