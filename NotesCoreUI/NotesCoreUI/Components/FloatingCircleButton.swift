
import SwiftUI

public struct FloatingCircleButton: View {
    let onTap: () -> Void
    
    public init(onTap: @escaping () -> Void) {
        self.onTap = onTap
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
                                type: .checkmark,
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
            onTap: {}
        )
    }
}
