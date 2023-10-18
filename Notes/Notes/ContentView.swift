import NotesCore
import NotesCoreUI
import NotesFeatures
import SwiftUI

struct ContentView: View {
    @StateObject var snackbarService: SnackbarService = .instance
    @StateObject var navigationService: NavigationService = .instance

    var body: some View {
        Group {
            switch navigationService.currentRoute {
            case .notes:
                Notes()
            case .noteDetails(
                noteId: let noteId,
                screenType: let screenType
            ):
                NoteDetails(
                    screenType: screenType,
                    noteId: noteId
                )
            }
        }
        .popup(snackbarType: $snackbarService.type)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
