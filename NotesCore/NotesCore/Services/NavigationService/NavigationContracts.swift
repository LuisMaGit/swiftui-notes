import Foundation

public enum NotesRoutes: Hashable {
    case notes
    case noteDetails(noteId: Int? = nil, screenType: FormScreenType)

}
