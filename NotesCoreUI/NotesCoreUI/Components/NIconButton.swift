
import SwiftUI

public struct NIconButton: View {
    let action: () -> Void
    let icon: NIconsType
    let iconColor: Color?
    let fixedFeedBack: Bool

    public init(
        action: @escaping () -> Void,
        icon: NIconsType,
        iconColor: Color? = nil,
        fixedFeedBack: Bool = false
    ) {
        self.action = action
        self.icon = icon
        self.iconColor = iconColor
        self.fixedFeedBack = fixedFeedBack
    }

    public var body: some View {
        RippleButton(
            fixedFeedback: fixedFeedBack,
            action: action,
            content: {
                if let iconColor = iconColor {
                    NIcons(
                        type: icon,
                        color: iconColor
                    )
                }
                else {
                    NIcons(
                        type: icon
                    )
                }
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
