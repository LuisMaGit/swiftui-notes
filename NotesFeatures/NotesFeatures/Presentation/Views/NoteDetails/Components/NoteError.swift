import NotesCoreUI
import SwiftUI

struct NoteError: View {
    var body: some View {
        VStack {
            NIcons(
                type: .multiplyCircle,
                size: notesBigIconSize
            )
            .padding(
                .bottom,
                NSpace.k4
            )
            NText(
                key: "error.label"
            )
            .padding(
                .bottom,
                NSpace.k16
            )
        }
    }
}

struct NoteError_Previews: PreviewProvider {
    static var previews: some View {
        NoteError()
    }
}
