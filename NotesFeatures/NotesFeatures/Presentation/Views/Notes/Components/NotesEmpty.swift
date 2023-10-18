import NotesCoreUI
import SwiftUI

struct NotesEmpty: View {
    @EnvironmentObject var viewmodel: NotesVM

    var body: some View {
        VStack {
            NotesHeader()
            NText(
                key: "notes.empty-result.label",
                type: .caption,
                color: NColors.backgroundLighterInverse
            )
            .padding(
                .top,
                NSpace.k8
            )
            Spacer()
        }
    }
}

struct NotesEmpty_Previews: PreviewProvider {
    static var previews: some View {
        let vm: NotesVM = .init(
            state: NotesState(
                screenState: .empty
            )
        )
        NotesEmpty()
            .environmentObject(vm)
    }
}
