import Foundation


public enum NotesVMEvents {
    case changeAppbar(to: NotesHeaderMode)
    case openDB
}

public class NotesVM {
    public private(set) var state: NotesState
    let notesSqlService: NotesService

    public init(
        state: NotesState = .init(),
        notesSqlService: NotesService = notesServiceProvider()
    ) {
        self.state = state
        self.notesSqlService = notesSqlService
    }

    public func sendEvent(
        event: NotesVMEvents
    ) {
        switch event {
        case .changeAppbar(to: let newAppbar):
            changeAppbar(newAppbar: newAppbar)
        case .openDB:
            openDatabase()
        }
    }

    private func changeAppbar(
        newAppbar: NotesHeaderMode
    ) {
        if state.headerMode == newAppbar {
            return
        }

        state.headerMode = newAppbar
    }

    private func openDatabase() {
        let result = notesSqlService.getNotes(page: 1)

        switch result {
        case .success(data: let data):
            print("\(String(describing: data?.data))")
        case .error(message: let message):
            print(message ?? "null error")
        }

    }
}

//import XCTest
//
//final class StringManagerServiceTests: XCTestCase {
//    func test_getFirstChars_whit_less_or_equal_than_amount() {
//        let service = StringMangerService()
//        let stub = "Luisma"
//        XCTAssertEqual(stub, service.getFirstChars(of: stub, amount: 5))
//    }
//}
