import NotesCoreUI
import SwiftUI

public struct Notes: View {
    @EnvironmentObject var state: NotesState
    let sendEvent: (_ event: NotesVMEvents) -> Void

    public init(
        sendEvent: @escaping (_: NotesVMEvents) -> Void
    ) {
        self.sendEvent = sendEvent
    }

    public var body: some View {
        Group {
            switch state.screenState {
            case .empty:
                NotesEmpty(
                    sendEvent: sendEvent
                )
            case .success:
                NotesList(
                    sendEvent: sendEvent
                )
            case .loading:
                NotesLoading(
                    sendEvent: sendEvent
                )
            case .error:
                NotesError(
                    sendEvent: sendEvent
                )
            }
        }
        .nHPadding()
    }
}
