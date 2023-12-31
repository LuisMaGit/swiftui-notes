import SwiftUI

public enum RippleButtonContracts {
    public static let paddingTransparent = NSpace.k8
    public static let colorTransparentRipple = NColors.backgroundLighter
    public static let opacityRippleColor = 0.7
    public static let durationLongTap = 0.1
}

public struct RippleButton<Content: View>: View {
    let action: () -> Void
    let longPressAction: (() -> Void)?
    let content: () -> Content
    let transparent: Bool
    let transparentPadding: Double
    let fixedFeedback: Bool

    public init(
        transparent: Bool = true,
        transparentPadding: Double = RippleButtonContracts.paddingTransparent,
        fixedFeedback: Bool = false,
        action: @escaping () -> Void,
        longPressAction: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.action = action
        self.transparent = transparent
        self.transparentPadding = transparentPadding
        self.fixedFeedback = fixedFeedback
        self.content = content
        self.longPressAction = longPressAction
    }

    public var body: some View {
        Button(
            action: {},
            label: {
                content()
                    .onTapGesture {
                        action()
                    }
                    .onLongPressGesture(
                        minimumDuration: RippleButtonContracts.durationLongTap
                    ) {
                        if let lp = longPressAction {
                            lp()
                        }
                    }
            }
        ).buttonStyle(
            RippleButtonStyle(
                transparent: transparent,
                transparentPadding: transparentPadding,
                fixedFeedback: fixedFeedback
            )
        )
    }
}

public struct RippleButtonStyle: ButtonStyle {
    let transparent: Bool
    let transparentPadding: Double
    let fixedFeedback: Bool

    init(
        transparent: Bool,
        transparentPadding: Double,
        fixedFeedback: Bool
    ) {
        self.transparent = transparent
        self.transparentPadding = transparentPadding
        self.fixedFeedback = fixedFeedback
    }

    public func makeBody(
        configuration: Configuration
    ) -> some View {
        let label = configuration.label
        let isPressed = configuration.isPressed
        if transparent {
            let color = RippleButtonContracts.colorTransparentRipple.opacity(
                RippleButtonContracts.opacityRippleColor
            )
            label
                .padding(.all, transparentPadding)
                .background {
                    RoundedRectangle(
                        cornerRadius: NBorderRadius.k10
                    )
                    .fill(
                        fixedFeedback ? color :
                            isPressed ? color : color.opacity(0.0)
                    )
                }
        } else {
            label.opacity(
                fixedFeedback ? RippleButtonContracts.opacityRippleColor :
                    isPressed ? RippleButtonContracts.opacityRippleColor : 1
            )
        }
    }
}

struct RippleButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RippleButton(
                transparent: true,
                action: {},
                content: {
                    Text("transparent: true")
                }
            )
            RippleButton(
                transparent: false,
                action: {},
                content: {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 100)
                        .overlay {
                            Text("transparent: false")
                        }
                }
            )
            RippleButton(
                transparent: true,
                fixedFeedback: true,
                action: {},
                content: {
                    Text("transparent: true\nfixedFeedback: true")
                }
            )
            RippleButton(
                transparent: false,
                fixedFeedback: true,
                action: {},
                content: {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 100)
                        .overlay {
                            Text("transparent: false\nfixedFeedback: true")
                        }
                }
            )
        }
        .background(Color.blue)
    }
}
