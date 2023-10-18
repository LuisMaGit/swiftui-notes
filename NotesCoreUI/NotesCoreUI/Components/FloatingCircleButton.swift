
import SwiftUI

public struct FloatingCircleButton: View {
    let onTap: () -> Void
    let icon: NIconsType

    public init(
        onTap: @escaping () -> Void,
        icon: NIconsType
    ) {
        self.onTap = onTap
        self.icon = icon
    }

    public var body: some View {
        RippleButton(
            transparent: false,
            action: onTap,
            content: {
                Circle()
                    .fill(NColors.accent)
                    .overlay(
                        content: {
                            NIcons(
                                type: icon,
                                color: NColors.backgroundInverseDark,
                                size: 25
                            )
                        }
                    )
                    .frame(width: 70)
            }
        )
    }
}

struct FloatingCircleButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingCircleButton(
            onTap: {},
            icon: .checkmark
        )
    }
}
