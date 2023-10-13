
import SwiftUI

public struct NIconButton: View {
    let action: () -> Void
    let icon: NIconsType
    let fixedFeedBack: Bool

    public init(
        action: @escaping () -> Void,
        icon: NIconsType,
        fixedFeedBack: Bool = false
    ) {
        self.action = action
        self.icon = icon
        self.fixedFeedBack = fixedFeedBack
    }

    public var body: some View {
        RippleButton(
            fixedFeedback: fixedFeedBack,
            action: action,
            content: {
                NIcons(type: icon)
            }
        )
    }
}

struct NIconButton_Previews: PreviewProvider {
    static var previews: some View {
        NIconButton(
            action: {},
            icon: .magnifyingglass,
            fixedFeedBack: true
        )
    }
}
