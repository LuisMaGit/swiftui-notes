
import SwiftUI

public enum CircleColorStyles {
    static let size = 30.0
    static let lineWidth = 2.0
    static var sizeBorder: Double {
        return size + 14
    }
}

public struct CircleColor: View {
    let color: Color
    let onTap: () -> Void
    let selected: Bool

    public init(
        color: Color,
        onTap: @escaping () -> Void,
        selected: Bool
    ) {
        self.color = color
        self.onTap = onTap
        self.selected = selected
    }

    public var body: some View {
        if selected {
            ZStack {
                colorCircle
                colorCircleSelected
            }
        } else {
            colorCircle
        }
    }

    @ViewBuilder var colorCircle: some View {
        RippleButton(
            transparent: false,
            action: onTap
        ) {
            Circle()
                .fill(color)
                .frame(
                    width: CircleColorStyles.size,
                    height: CircleColorStyles.size
                )
        }
    }

    @ViewBuilder var colorCircleSelected: some View {
        let size = CircleColorStyles.sizeBorder
        Circle()
            .strokeBorder(
                NColors.backgroundInverse,
                lineWidth: CircleColorStyles.lineWidth
            )
            .frame(
                width: size,
                height: size
            )
    }
}

struct CircleColor_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CircleColor(
                color: NColors.lightGreen,
                onTap: {},
                selected: true
            )
            CircleColor(
                color: NColors.lightGreen,
                onTap: {},
                selected: false
            )
        }
    }
}
