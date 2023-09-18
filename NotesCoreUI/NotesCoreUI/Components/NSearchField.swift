import SwiftUI

public enum NSearchFieldStyles {
    public static let colorUnfocusBorder = NColors.backgroundLighterInverse.opacity(0.5)
    public static let colorFocusBorder = NColors.backgroundInverse
    public static let lineWidthBorder = 2.0
    public static let paddingHorizontal = NSpace.k8
    public static let paddingVertical = NSpace.k16
}

public struct NSearchField: View {
    @State var text: String
    let hint: LocalizedStringKey
    let startFocused: Bool
    // control
    @FocusState private var focus: Bool
    @State private var showHint: Bool = true
    @State private var borderColor: Color = NSearchFieldStyles.colorUnfocusBorder
    @State private var showSearchIcon = true

    public init(
        text: String = "",
        hint: LocalizedStringKey = "",
        startFocused: Bool = false
    ) {
        self.text = text
        self.hint = hint
        self.startFocused = startFocused
    }

    private var textStyle: NTextStyles {
        NTextStyles.getStyle(.title)
    }

    private func showHintHandler() {
        showHint = text.isEmpty
    }

    private func startFocusHandler() {
        focus = startFocused
        if !focus {
            borderColorHandler(false)
        }
    }

    private func borderColorHandler(_ focusValue: Bool) {
        borderColor = focusValue ?
            NSearchFieldStyles.colorFocusBorder :
            NSearchFieldStyles.colorUnfocusBorder
    }

    private func suffixIconHandler() {
        showSearchIcon = text.isEmpty
    }

    private func cleanText() {
        text = ""
    }

    public var body: some View {
        ZStack(
            alignment: .leading
        ) {
            TextField(
                "",
                text: $text
            )
            .focused($focus)
            .font(
                Font.custom(
                    textStyle.font.rawValue,
                    size: textStyle.fontSize
                )
            )
            .foregroundColor(textStyle.defaultColor)
            .padding(.horizontal, NSearchFieldStyles.paddingHorizontal)
            .padding(.vertical, NSearchFieldStyles.paddingVertical)
            .autocapitalization(.none)
            .accentColor(NSearchFieldStyles.colorFocusBorder)
            .overlay {
                RoundedRectangle(
                    cornerRadius: NBorderRadius.k10
                )
                .strokeBorder(
                    borderColor,
                    lineWidth: NSearchFieldStyles.lineWidthBorder
                )
            }
            .onChange(of: focus) { newFocus in
                borderColorHandler(newFocus)
            }
            .onChange(of: text) { _ in
                showHintHandler()
                suffixIconHandler()
            }
            .onAppear {
                showHintHandler()
                startFocusHandler()
                suffixIconHandler()
            }

            HStack {
                hintView
                Spacer()
                suffixView
            }
            .padding(
                .horizontal,
                NSearchFieldStyles.paddingHorizontal
            )
        }
    }

    @ViewBuilder private var hintView: some View {
        NText(
            showHint ? hint : "",
            type: .title,
            color: NSearchFieldStyles.colorUnfocusBorder,
            lineLimit: 1
        )
        .allowsHitTesting(false)
    }

    @ViewBuilder private var suffixView: some View {
        if showSearchIcon {
            NIcons(
                type: .magnifyingglass,
                color: NSearchFieldStyles.colorUnfocusBorder
            )
            .padding(
                .trailing,
                RippleButtonStyles.paddingTransparent
            )
            .allowsHitTesting(false)
        } else {
            RippleButton(
                action: cleanText
            ) {
                NIcons(
                    type: .xmark,
                    color: borderColor
                )
            }
        }
    }
}

struct NSearchField_Previews: PreviewProvider {
    static var previews: some View {
        NSearchField(
            text: "afaf",
            hint: "Search in your notes",
            startFocused: false
        )
    }
}
