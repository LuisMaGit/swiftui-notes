
import SwiftUI


public enum ChipButtonStyles {
    static let lineWidth = 2.0
    static let colorActive = NColors.backgroundInverse
    static let colorUnactive = NColors.background
    static let maxWidth = 120.0
}


public struct ChipButton: View {
    let key: LocalizedStringKey
    let selected: Bool
    let onTap: () -> Void

    public init(
        key: LocalizedStringKey,
        selected: Bool,
        onTap: @escaping () -> Void
    ) {
        self.key = key
        self.selected = selected
        self.onTap = onTap
    }

    public var body: some View {
        RippleButton(
            transparent: false,
            action: onTap
        ) {
            if selected {
                textView
                    .background {
                        rectangle
                            .fill(ChipButtonStyles.colorActive)
                    }
            } else {
                textView
                    .background {
                        rectangle
                            .stroke(lineWidth: ChipButtonStyles.lineWidth)
                            .fill(ChipButtonStyles.colorActive)
                            .background(ChipButtonStyles.colorUnactive)
                    }
            }
        }
    }

    @ViewBuilder var rectangle: RoundedRectangle {
        RoundedRectangle(
            cornerRadius: NBorderRadius.k10
        )
    }

    @ViewBuilder var textView: some View {
        NText(
            key,
            type: .body,
            color: selected ?
                ChipButtonStyles.colorUnactive :
                ChipButtonStyles.colorActive
        )
        .padding(
            .vertical,
            NSpace.k8 + (selected ? ChipButtonStyles.lineWidth / 2 : 0)
        )
        .padding(
            .horizontal,
            NSpace.k16
        )
        .frame(maxWidth: ChipButtonStyles.maxWidth)
        .fixedSize(horizontal: true, vertical: false)
    }
}


struct ChipButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ChipButton(
                key: "Latest",
                selected: true,
                onTap: {}
            )
            ChipButton(
                key: "Older",
                selected: false,
                onTap: {}
            )
        }
    }
}
