import NotesCoreUI
import SwiftUI

public struct NoteDetails: View {
    @EnvironmentObject var state: NoteDetailsState
    let sendEvent: (NotesVMEvents) -> Void

    public init(
        sendEvent: @escaping (NotesVMEvents) -> Void
    ) {
        self.sendEvent = sendEvent
    }

    public var body: some View {
        switch state.screenState {
            case .loading:
                NoteLoading()
            case .error:
                NoteError()
            case .success:
                NoteSuccess(
                    sendEvent: sendEvent
                )
            default:
                Rectangle()
        }
    }
}

struct NoteDetails_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetails(
            sendEvent: { _ in }
        )
    }
}
