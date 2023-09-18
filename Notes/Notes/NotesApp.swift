import NotesCoreUI
import SwiftUI

@main
struct NotesApp: App {
    init() {
        NotesCoreUI.setup()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
