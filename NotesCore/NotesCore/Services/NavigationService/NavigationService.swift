
import Foundation

public class NavigationService: ObservableObject {
    @Published public private(set) var currentRoute: NotesRoutes = .notes
    public static let instance: NavigationService = .init()

    private init() {}

    public func goTo(notesRoute: NotesRoutes) {
        if notesRoute == currentRoute {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.currentRoute = notesRoute
        }
    }
}
