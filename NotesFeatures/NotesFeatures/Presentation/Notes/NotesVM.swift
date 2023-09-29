import Foundation
import NotesCore

public enum NotesVMEvents {
    case changeAppbar(to: NotesHeaderMode)
    case getNotesFrom(page: Int)
    case triggerNextPage
}

public class NotesVM {
    public private(set) var state: NotesState
    let notesSqlService: INotesService
    let paginationService: IPaginationService

    public init(
        state: NotesState = .init(),
        notesSqlService: INotesService = notesServiceProvider(),
        paginationService: IPaginationService = paginationServiceProvider()
    ) {
        self.state = state
        self.notesSqlService = notesSqlService
        self.paginationService = paginationService
        getNotesFrom(page: 1)
    }

    public func sendEvent(
        event: NotesVMEvents
    ) {
        switch event {
        case let .changeAppbar(to: newAppbar):
            changeAppbar(newAppbar: newAppbar)
        case let .getNotesFrom(page: page):
            getNotesFrom(page: page)
        case .triggerNextPage:
            triggerNextPage()
        }
    }

    private var itemsInPage = PAGINATION_DEF_ITEMS_IN_PAGE

    private func changeAppbar(
        newAppbar: NotesHeaderMode
    ) {
        if state.headerMode == newAppbar {
            return
        }
        state.headerMode = newAppbar
    }

    private func getNotesFrom(page: Int) {
        let result = notesSqlService.getNotes(
            page: page,
            itemsInPage: itemsInPage
        )

        switch result {
        case let .success(data: data):
            // error
            guard let pageData = data else {
                state.screenState = .error
                return
            }

            // empty
            if pageData.data.isEmpty {
                state.screenState = .empty
                return
            }

            // success
            state.allNotes = state.allNotes.addPage(newData: pageData.data)
            state.showLoadingMore = paginationService.shouldGetOtherPage(
                allItems: pageData.data.count,
                page: pageData.page,
                expectedItemsInPage: itemsInPage
            )
            state.screenState = .success

        case .error(message: _):
            state.screenState = .error
        }
    }

    private func triggerNextPage() {
        if state.blockTriggerPagination {
            return
        }
        state.blockTriggerPagination = true
        getNotesFrom(page: state.allNotes.nextPage)
        state.blockTriggerPagination = false
    }
}
