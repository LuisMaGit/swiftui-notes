import SwiftUI

public struct NTextField: View {
    @State var text: String
    @State var showHint: Bool
    let hintKey: LocalizedStringKey
    let onChange: (String) -> Void
    let backgroundColor: Color

    public init(
        text: String,
        backgroundColor: Color,
        onChange: @escaping (String) -> Void,
        hintKey: LocalizedStringKey
    ) {
        _text = State(initialValue: text)
        _showHint = State(initialValue: text.isEmpty)
        self.backgroundColor = backgroundColor
        self.onChange = onChange
        self.hintKey = hintKey
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
            .tint(NColors.backgroundInverse)
            .padding(.vertical, NSpace.k16)
            .background(backgroundColor)
            .lineLimit(2)
            if showHint {
                NEditorHint(
                    key: hintKey
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
