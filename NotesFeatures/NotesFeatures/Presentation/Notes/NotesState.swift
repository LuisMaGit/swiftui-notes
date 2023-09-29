import NotesCore
import SwiftUI

public class NotesState: ObservableObject {
    @Published var headerMode: NotesHeaderMode
    @Published var headerFilterSelected: Bool
    @Published var notesSelected: Int
    @Published var allNotes: Pagination<Note>
    @Published var screenState: BasicScreenState
    var showLoadingMore: Bool
    var blockTriggerPagination: Bool

    public init(
        headerMode: NotesHeaderMode = .initial,
        headerFilterSelected: Bool = false,
        notesSelected: Int = 0,
        allNotes: Pagination<Note> = Pagination<Note>.initial(),
        screenState: BasicScreenState = .loading,
        showLoadingMore: Bool = false,
        blockTriggerPagination: Bool = false
    ) {
        self.headerMode = headerMode
        self.headerFilterSelected = headerFilterSelected
        self.notesSelected = notesSelected
        self.allNotes = allNotes
        self.screenState = screenState
        self.showLoadingMore = showLoadingMore
        self.blockTriggerPagination = blockTriggerPagination
    }
}

public enum NotesHeaderMode {
    case initial
    case searchbar
    case itemsSelected
}
