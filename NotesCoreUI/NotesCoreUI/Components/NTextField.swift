import SwiftUI

public struct NTextField: View {
    @State var text: String
    @State var showHint: Bool
    let hintKey: LocalizedStringKey
    let onChange: (String) -> Void
    let backgroundColor: Color
    let textHandleHintColor: Color
    let lineLimit: Int

    public init(
        text: String,
        backgroundColor: Color,
        onChange: @escaping (String) -> Void,
        hintKey: LocalizedStringKey,
        textHandleHintColor: Color = NColors.backgroundInverse,
        lineLimit : Int = 2
    ) {
        _text = State(initialValue: text)
        _showHint = State(initialValue: text.isEmpty)
        self.backgroundColor = backgroundColor
        self.onChange = onChange
        self.hintKey = hintKey
        self.textHandleHintColor = textHandleHintColor
        self.lineLimit = 2
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            TextField(
                "",
                text: $text
            )
            .onChange(of: text) { new in
                showHint = text.isEmpty
                onChange(new)
            }
            .tint(textHandleHintColor)
            .foregroundColor(textHandleHintColor)
            .padding(.vertical, NSpace.k16)
            .background(backgroundColor)
            .lineLimit(lineLimit)
            if showHint {
                NEditorHint(
                    key: hintKey,
                    color: textHandleHintColor.opacity(0.7)
                )
            }
        }
    }
}

struct NTextField_Previews: PreviewProvider {
    static var previews: some View {
        NTextField(
            text: "text",
            backgroundColor: .red,
            onChange: { _ in },
            hintKey: "Hint"
        )
    }
}
