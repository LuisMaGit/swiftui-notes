import Foundation
import NotesCore

public enum NotesVMEvents {
    case closeSearchMode
    case closeSelectionMode
    case deleteNotes
    case onLongPressNote(idx: Int)
    case onTapFilter
    case onTapNote(idx: Int)
    case searchNotes(search: String?)
    case selectFilter(type: NotesFilterType)
    case setFilterColor(color: NoteColor)
    case setSearchMode
    case triggerNextPage
    case tryAgain
}

enum NotesQueryType {
    case all
    case filterColor
    case filterOlder
    case search
}

public class NotesVM {
    // state
    public private(set) var state: NotesState
    // di
    private let notesSqlService: INotesService
    private let paginationService: IPaginationService
    // control
    private var searchTimer: Timer?
    private var searchTask: Task<Void, Never>?
    private var blockTriggerPagination: Bool = false
    private let ITEMS_IN_PAGE = PAGINATION_DEF_ITEMS_IN_PAGE
    private let TIMER_DELAY = 0.5
    private var notesQueryType: NotesQueryType = .all
    
    public init(
        state: NotesState = .init(),
        notesSqlService: INotesService = notesServiceProvider(),
        paginationService: IPaginationService = paginationServiceProvider()
    ) {
        self.state = state
        self.notesSqlService = notesSqlService
        self.paginationService = paginationService
        Task {
            await queryAllNotes(
                page: state.notes.nextPage,
                isFirstCall: true
            )
        }
    }
    
    public func sendEvent(
        event: NotesVMEvents
    ) {
        switch event {
        case .setSearchMode:
            setSearchMode()
        case .closeSearchMode:
            closeSearchMode()
        case .triggerNextPage:
            triggerNextPage()
        case .tryAgain:
            tryAgain()
        case let .searchNotes(search: value):
            searchNotes(search: value)
        case let .onTapNote(idx: idx):
            onTapNote(idx: idx)
        case let .onLongPressNote(idx: idx):
            onLongPressNote(idx: idx)
        case .closeSelectionMode:
            closeSelectMode()
        case .deleteNotes:
            deleteNotes()
        case .onTapFilter:
            onTapFilter()
        case let .selectFilter(type: type):
            setFilter(type: type)
        case let .setFilterColor(color: color):
            setFilterColor(color: color)
        }
    }
    
    private func queryAllNotes(
        page: Int,
        isFirstCall: Bool,
        latest: Bool = true
    ) async {
        notesQueryType = latest ? .all : .filterOlder
        await queryNotes(
            page: page,
            isFirstCall: isFirstCall,
            queryCallback: {
                await notesSqlService.getNotes(
                    page: page,
                    itemsInPage: ITEMS_IN_PAGE,
                    latest: latest
                )
            }
        )
    }
    
    private func querySearchNotes(
        search: String,
        page: Int,
        isFirstCall: Bool
    ) async {
        notesQueryType = .search
        await queryNotes(
            page: page,
            isFirstCall: isFirstCall,
            queryCallback: {
                await notesSqlService.searchNotes(
                    page: page,
                    itemsInPage: ITEMS_IN_PAGE,
                    search: search
                )
            }
        )
    }
    
    private func queryNotesByColor(
        color: NoteColor,
        page: Int,
        isFirstCall: Bool
    ) async {
        notesQueryType = .filterColor
        await queryNotes(
            page: page,
            isFirstCall: isFirstCall,
            queryCallback: {
                await notesSqlService.notesByColor(
                    page: page,
                    itemsInPage: ITEMS_IN_PAGE,
                    color: color
                )
            }
        )
    }
    
    private func queryNotes(
        page: Int,
        isFirstCall: Bool,
        queryCallback: () async -> Result<Pagination<Note>>
    ) async {
        if isFirstCall {
            await MainActor.run {
                state.screenState = .loading
            }
        }
        
        let result = await queryCallback()
        
        await MainActor.run {
            switch result {
            case let .success(data: data):
                // error
                guard let pageData = data else {
                    state.screenState = .error
                    return
                }
                
                // empty
                if isFirstCall, pageData.data.isEmpty {
                    state.screenState = .empty
                    return
                }
                
                // append notes
                state.notes = state.notes.addPage(
                    newData: pageData.data
                )
                // set if the list should show the pagination loader
                state.showLoadingMore = paginationService.shouldGetOtherPage(
                    allItems: state.notes.data.count,
                    page: state.notes.page,
                    expectedItemsInPage: ITEMS_IN_PAGE
                )
                // create/expand the notes selected map
                let lastIdx = state.notesSelectedMap.count
                var newNotesSelectedChunk: [Int: Bool] = [:]
                for idx in 0 ..< pageData.data.count {
                    newNotesSelectedChunk.updateValue(false, forKey: idx + lastIdx)
                }
                state.notesSelectedMap.merge(newNotesSelectedChunk) { _, new in new }
                // set success
                state.screenState = .success
                
            case .error(message: _):
                state.screenState = .error
            }
        }
    }
    
    private func setSearchMode() {
        state.headerMode = .searchbar
    }
    
    private func closeSearchMode() {
        resetView()
        Task {
            await queryAllNotes(
                page: state.notes.nextPage,
                isFirstCall: true
            )
        }
    }
    
    private func triggerNextPage() {
        if blockTriggerPagination {
            return
        }
        blockTriggerPagination = true
        Task {
            switch notesQueryType {
            case .all:
                await queryAllNotes(
                    page: state.notes.nextPage,
                    isFirstCall: false
                )
            case .search:
                await querySearchNotes(
                    search: state.searchText,
                    page: state.notes.nextPage,
                    isFirstCall: false
                )
            case .filterOlder:
                await queryAllNotes(
                    page: state.notes.nextPage,
                    isFirstCall: false,
                    latest: false
                )
            case .filterColor:
                await queryNotesByColor(
                    color: state.filterColorSelected,
                    page: state.notes.nextPage,
                    isFirstCall: false
                )
            }
            await MainActor.run {
                blockTriggerPagination = false
            }
        }
    }
    
    private func tryAgain() {
        resetView(
            avoidSearchText: true,
            avoidHeaderMode: true,
            avoidHeaderFilterSelected: true
        )
        Task {
            switch notesQueryType {
            case .all:
                await queryAllNotes(
                    page: state.notes.nextPage,
                    isFirstCall: true
                )
            case .search:
                await querySearchNotes(
                    search: state.searchText,
                    page: state.notes.nextPage,
                    isFirstCall: true
                )
            case .filterOlder:
                await queryAllNotes(
                    page: state.notes.nextPage,
                    isFirstCall: true,
                    latest: false
                )
            case .filterColor:
                await queryNotesByColor(
                    color: state.filterColorSelected,
                    page: state.notes.nextPage,
                    isFirstCall: true
                )
            }
        }
    }
    
    private func resetViewMaintainFilter() {
        resetView(
            avoidHeaderMode: true,
            avoidHeaderFilterSelected: true
        )
    }
    
    private func resetView(
        avoidSearchText: Bool = false,
        avoidHeaderMode: Bool = false,
        avoidHeaderFilterSelected: Bool = false
    ) {
        let base = NotesState()
        if !avoidHeaderMode {
            state.headerMode = base.headerMode
        }
        if !avoidHeaderFilterSelected {
            state.filterSelected = base.filterSelected
            state.filterSelectedType = base.filterSelectedType
            state.filterColorSelected = base.filterColorSelected
        }
        state.notesSelected = base.notesSelected
        state.notesSelectedMap = base.notesSelectedMap
        state.notes = base.notes
        state.screenState = base.screenState
        state.showLoadingMore = base.showLoadingMore
        if !avoidSearchText {
            state.searchText = base.searchText
        }
        blockTriggerPagination = false
    }
    
    private func searchNotes(search: String?) {
        searchTimer?.invalidate()
        searchTask?.cancel()
        
        // validation
        let searchValue = search ?? ""
        state.searchText = searchValue
        if state.searchText.isEmpty {
            resetView(
                avoidHeaderMode: true
            )
            Task {
                await queryAllNotes(
                    page: state.notes.nextPage,
                    isFirstCall: true
                )
            }
            return
        }
        
        // search
        searchTimer = Timer.scheduledTimer(
            withTimeInterval: TIMER_DELAY,
            repeats: false,
            block: { _ in
                self.searchTask = Task {
                    await MainActor.run {
                        self.resetView(
                            avoidSearchText: true,
                            avoidHeaderMode: true
                        )
                    }
                    await self.querySearchNotes(
                        search: self.state.searchText,
                        page: self.state.notes.nextPage,
                        isFirstCall: true
                    )
                    self.searchTask = nil
                }
            }
        )
    }
    
    private func onTapNote(idx: Int) {
        // selection mode
        if state.headerMode == .itemsSelected {
            state.notesSelectedMap[idx] = !state.notesSelectedMap[idx]!
            setSelectedNotes()
        }
    }
    
    private func onLongPressNote(idx: Int) {
        if state.headerMode == .itemsSelected {
            return
        }
        
        state.headerMode = .itemsSelected
        state.notesSelectedMap[idx] = true
        setSelectedNotes()
    }
    
    private func closeSelectMode() {
        resetView()
        Task {
            await queryAllNotes(
                page: state.notes.nextPage,
                isFirstCall: true
            )
        }
    }
    
    private func setSelectedNotes() {
        state.notesSelected = state
            .notesSelectedMap
            .filter { _, selected in selected }.count
        if state.notesSelected == 0 {
            closeSelectMode()
        }
    }
    
    private func deleteNotes() {
        Task {
            let idxs = state
                .notesSelectedMap
                .filter { _, selected in selected }.keys
            var ids: [Int] = []
            idxs.forEach { idx in
                ids.append(
                    state.notes.data[idx].id
                )
            }
            let result = await notesSqlService.deleteNotes(
                ids: ids
            )
            if case .success = result {
                await MainActor.run {
                    resetView()
                }
                await queryAllNotes(
                    page: state.notes.nextPage,
                    isFirstCall: true
                )
            }
        }
    }
    
    private func onTapFilter() {
        state.filterSelected = !state.filterSelected
        
        if !state.filterSelected {
            resetView()
            Task {
                await queryAllNotes(
                    page: state.notes.nextPage,
                    isFirstCall: true
                )
            }
            return
        }
        
        state.headerMode = .filter
    }
    
    private func setFilter(type: NotesFilterType) {
        if type == state.filterSelectedType {
            return
        }
        
        state.filterSelectedType = type
        resetViewMaintainFilter()
        switch type {
        case .latest:
            Task {
                await queryAllNotes(
                    page: state.notes.nextPage,
                    isFirstCall: true
                )
            }
        case .older:
            Task {
                await queryAllNotes(
                    page: state.notes.nextPage,
                    isFirstCall: true,
                    latest: false
                )
            }
        case .colors:
            Task {
                await queryNotesByColor(
                    color: state.filterColorSelected,
                    page: state.notes.nextPage,
                    isFirstCall: true
                )
            }
        }
    }
    
    private func setFilterColor(color: NoteColor) {
        if state.filterColorSelected == color {
            return
        }
     
        Task {
            await MainActor.run {
                state.filterColorSelected = color
                resetViewMaintainFilter()
            }
            await queryNotesByColor(
                color: state.filterColorSelected,
                page: state.notes.nextPage,
                isFirstCall: true
            )
        }
    }
}
