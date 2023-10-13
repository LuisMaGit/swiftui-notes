import SwiftUI

public struct NEditorHint: View {
    let key: LocalizedStringKey

    public init(key: LocalizedStringKey) {
        self.key = key
    }

    public var body: some View {
        NText(
            key: key,
            color: NColors.backgroundInverse
        )
        .allowsHitTesting(false)
    }
}

struct NEditorHint_Previews: PreviewProvider {
    static var previews: some View {
        NEditorHint(key: "key")
    }
}
