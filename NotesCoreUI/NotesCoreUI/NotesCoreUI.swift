import SwiftUI

public struct NotesCoreUI {
    public static func setup() {
        registerFonts()
    }

    private static func registerFonts() {
        let fonts = Bundle(
            identifier: NotesCoreUIContracts.bundle
        )?.urls(
            forResourcesWithExtension: "ttf",
            subdirectory: nil
        )
        fonts?.forEach { url in
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}
