
import NotesCoreUI
import SwiftUI

struct NotesLoading: View {
    var body: some View {
        VStack {
            NotesHeader()
            Spacer()
            NLoader()
            Spacer()
        }
    }
}

struct NotesLoading_Previews: PreviewProvider {
    static var previews: some View {
        NotesLoading()
            .environmentObject(
                NotesVM(
                    state: NotesState(
                        screenState: .loading
                    )
                )
            )
    }
}
