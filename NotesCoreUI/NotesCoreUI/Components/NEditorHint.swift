import SwiftUI

public struct NEditorHint: View {
    let key: LocalizedStringKey
    let color : Color

    public init(
        key: LocalizedStringKey,
        color: Color = NColors.backgroundInverse
    ) {
        self.key = key
        self.color = color
    }

    public var body: some View {
        NText(
            key: key,
            color: color
        )
        .allowsHitTesting(false)
    }
}

struct NEditorHint_Previews: PreviewProvider {
    static var previews: some View {
        NEditorHint(key: "key")
    }
}
