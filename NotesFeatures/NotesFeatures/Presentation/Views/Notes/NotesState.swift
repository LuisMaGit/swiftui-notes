import NotesCore

public struct NotesState {
    var headerMode: NotesHeaderMode
    var filterSelected: Bool
    var filterSelectedType: NotesFilterType
    var filterColorSelected: NoteColor
    var notes: Pagination<Note>
    var notesSelected: Int
    var notesSelectedMap: [Int: Bool]
    var screenState: BasicScreenState
    var showLoadingMore: Bool
    var searchText: String

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
