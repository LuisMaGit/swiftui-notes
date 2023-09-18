import NotesCoreUI
import SwiftUI

public struct Notes: View {
    @ObservedObject var state: NotesState
    let sendEvent: (_ event: NotesVMEvents) -> Void

    public init(
        state: NotesState,
        sendEvent: @escaping (_: NotesVMEvents) -> Void
    ) {
        self.state = state
        self.sendEvent = sendEvent
    }

    public var body: some View {
        ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            LazyVStack(
                alignment: .leading,
                spacing: 0,
                pinnedViews: [.sectionHeaders]
            ) {
                Section(
                    header: NotesHeader(
                        mode: state.headerMode,
                        switchMode: { mode in
                            sendEvent(.changeAppbar(to: mode))
                        },
                        notesSelected: 0,
                        onTapFilter: {
                            sendEvent(.openDB)
                        },
                        filterSelected: false
                    )
                ) {
                    ForEach(0 ..< 5) { idx in
                        Text(idx.description)
                    }
                }
            }
        }
    }
}

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        let vm: NotesVM = .init()
        Notes(
            state: vm.state,
            sendEvent: vm.sendEvent
        )
    }
}
