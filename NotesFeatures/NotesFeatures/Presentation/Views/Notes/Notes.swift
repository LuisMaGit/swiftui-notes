import NotesCoreUI
import SwiftUI

public struct Notes: View {
    @StateObject var viewmodel = NotesVM()

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                bodyViewBuilder
                topColor(top: geometry.safeAreaInsets.top)
                floatingButton
            }
            .environmentObject(viewmodel)
            .onAppear {
                viewmodel.sendEvent(.onAppear)
            }
            .nHPadding()
        }
    }

    @ViewBuilder var bodyViewBuilder: some View {
        switch viewmodel.state.screenState {
        case .empty:
            NotesEmpty()
        case .success:
            NotesList()
        case .loading:
            NotesLoading()
        case .error:
            NotesError()
        }
    }

    var floatingButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                FloatingCircleButton(
                    onTap: {
                        viewmodel.sendEvent(.addNote)
                    },
                    icon: .plus
                )
            }
        }
    }

    func topColor(top: Double) -> some View {
        NColors.background.frame(
            height: top
        )
        .ignoresSafeArea()
    }
}

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        let vm: NotesVM = .init(
            state: NotesState(
                screenState: .empty
            )
        )
        Notes()
            .environmentObject(vm)
    }
}
