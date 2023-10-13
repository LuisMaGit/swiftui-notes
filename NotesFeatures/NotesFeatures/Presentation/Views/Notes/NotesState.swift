import NotesCore
import SwiftUI

public class NotesState: ObservableObject {
    @Published var headerMode: NotesHeaderMode
    @Published var filterSelected: Bool
    @Published var filterSelectedType: NotesFilterType
    @Published var filterColorSelected: NoteColor
    @Published var notes: Pagination<Note>
    @Published var notesSelected: Int
    @Published var notesSelectedMap: [Int: Bool]
    @Published var screenState: BasicScreenState
    @Published var showLoadingMore: Bool
    @Published var searchText: String

    public init(
        headerMode: NotesHeaderMode = .initial,
        filterSelected: Bool = false,
        filterSelectedType: NotesFilterType = .latest,
        filterColorSelected: NoteColor = Note.DEFAULT_COLOR,
        notesSelected: Int = 0,
        notes: Pagination<Note> = Pagination<Note>.initial(),
        screenState: BasicScreenState = .loading,
        showLoadingMore: Bool = false,
        searchText: String = "",
        selectedNotes: [Int: Bool] = [:]
    ) {
        self.headerMode = headerMode
        self.filterSelected = filterSelected
        self.filterSelectedType = filterSelectedType
        self.filterColorSelected = filterColorSelected
        self.notesSelected = notesSelected
        self.notes = notes
        self.screenState = screenState
        self.showLoadingMore = showLoadingMore
        self.searchText = searchText
        self.notesSelectedMap = selectedNotes
    }
}

public enum NotesHeaderMode {
    case initial
    case searchbar
    case itemsSelected
    case filter
}

public enum NotesFilterType: CaseIterable {
    case latest
    case older
    case colors
}
