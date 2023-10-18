import NotesCore
import SwiftUI

public struct NSnackbarHandler: View {
    @ObservedObject var service: SnackbarService

    public init(service: SnackbarService) {
        self.service = service
    }

    public var body: some View {
        ZStack {
            Button("SHOW") {
                service.showSnackbar(.noteAdded)
            }
            Spacer()
        }
        .popup(snackbarType: $service.type)
    }
}

public extension View {
    func popup(
        snackbarType: Binding<SnackbarType>,
        offsetBottom: Double = 50
    ) -> some View {
        modifier(
            PopupModifier(
                snackbarType: snackbarType,
                offsetBottom: offsetBottom
            )
        )
    }
}

public struct PopupModifier: ViewModifier {
    @Binding var snackbarType: SnackbarType
    let offsetBottom: Double

    public init(
        snackbarType: Binding<SnackbarType>,
        offsetBottom: Double
    ) {
        self._snackbarType = snackbarType
        self.offsetBottom = offsetBottom
    }

    public func body(content: Content) -> some View {
        let show = snackbarType != .none

        return GeometryReader { geometry in
            let halfScreen = geometry.size.height / 2
            let bottomInset = geometry.safeAreaInsets.bottom
            return content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    content: {
                        ZStack {
                            snackbar
                                .padding(
                                    .horizontal,
                                    NSpace.k16
                                )
                                .transition(
                                    .asymmetric(
                                        insertion: .move(edge: .bottom),
                                        removal: .move(edge: .bottom)
                                    )
                                )
                                .offset(x: 0, y: show ? (halfScreen - bottomInset) : (halfScreen + bottomInset))
                        }
                        .animation(.spring(), value: show)
                    }
                )
        }
    }

    @ViewBuilder var snackbar: some View {
        switch snackbarType {
        case .noteAdded:
            NSnackbar(title: "snackbar.note-added.title")
        case .noteEdited:
            NSnackbar(title: "snackbar.note-edited.title")
        case .notesDeleted:
            NSnackbar(title: "snackbar.note-deleted.title")
        case .error:
            NSnackbar(title: "snackbar.error.title", type: .error)
        case .none:
            ZStack {}
        }
    }
}

struct NSnackbarHandler_Previews: PreviewProvider {
    static var previews: some View {
        NSnackbarHandler(
            service: SnackbarService.instance
        )
    }
}
