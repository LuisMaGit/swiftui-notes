
import NotesCoreUI
import SwiftUI

struct NotesHeaderRippleButtonIcon: View {
    let action: () -> Void
    let icon: NIconsType
    let fixedFeedBack: Bool

    init(
        action: @escaping () -> Void,
        icon: NIconsType,
        fixedFeedBack: Bool = false
    ) {
        self.action = action
        self.icon = icon
        self.fixedFeedBack = fixedFeedBack
    }

    var body: some View {
        RippleButton(
            fixedFeedback: fixedFeedBack,
            action: action,
            content: {
                NIcons(type: icon)
            }
        )
    }
}

struct NotesHeaderRippleButtonIcon_Previews: PreviewProvider {
    static var previews: some View {
        NotesHeaderRippleButtonIcon(
            action: {},
            icon: .magnifyingglass,
            fixedFeedBack: true
        )
    }
}
