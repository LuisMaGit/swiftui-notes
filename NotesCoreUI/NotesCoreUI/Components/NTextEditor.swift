import SwiftUI

public struct NTextEditor: View {
    @State var text: String
    @State var showHint: Bool
    let onChange: (String) -> Void
    let backgroundColor: Color
    let hintKey: LocalizedStringKey
    let textHandleHintColor: Color
    

    public init(
        text: String,
        onChange: @escaping (String) -> Void,
        backgroundColor: Color,
        hintKey: LocalizedStringKey,
        textHandleHintColor: Color = NColors.backgroundInverse
    ) {
        _text = State(initialValue: text)
        _showHint = State(initialValue: text.isEmpty)
        self.onChange = onChange
        self.backgroundColor = backgroundColor
        self.hintKey = hintKey
        self.textHandleHintColor = textHandleHintColor
    }

    public var body: some View {
        ZStack(
            alignment: .topLeading
        ) {
            TextEditor(text: $text)
                .padding(.leading, -5)
                .tint(textHandleHintColor)
                .foregroundColor(textHandleHintColor)
                .scrollContentBackground(.hidden)
                .onChange(of: text) { _ in
                    onChange(text)
                    showHint = text.isEmpty
                }
            if showHint {
                NEditorHint(
                    key: hintKey,
                    color: textHandleHintColor.opacity(0.7)
                )
                .padding(.top, NSpace.k8)
            }
        }
        .background(backgroundColor)
    }
}

struct NTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        NTextEditor(
            text: "text",
            onChange: { _ in },
            backgroundColor: .green,
            hintKey: "Hint"
        )
    }
}
