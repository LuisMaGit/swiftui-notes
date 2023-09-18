import SwiftUI

public class NotesState: ObservableObject {
    @Published var headerMode: NotesHeaderMode
    @Published var headerFilterSelected: Bool
    @Published var notesSelected: Int

    public init(
        headerMode: NotesHeaderMode = .initial,
        headerFilterSelected: Bool = false,
        notesSelected: Int = 0
    ) {
        self.headerMode = headerMode
        self.headerFilterSelected = headerFilterSelected
        self.notesSelected = notesSelected
    }
}

public enum NotesHeaderMode {
    case initial
    case searchbar
    case itemsSelected
}
