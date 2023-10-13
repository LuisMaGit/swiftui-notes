import SwiftUI

public struct ColorSelector: View {
    let colors: [Color]
    let onTapColor: (Int) -> Void
    let selectedColor: Int

    public init(
        colors: [Color],
        onTapColor: @escaping (Int) -> Void,
        selectedColor: Int
    ) {
        self.colors = colors
        self.onTapColor = onTapColor
        self.selectedColor = selectedColor
    }

    public var body: some View {
        ScrollView(
            .horizontal
        ) {
            HStack(
                spacing: NSpace.k16
            ) {
                ForEach(
                    colors.indices,
                    id: \.self
                ) { idx in
                    CircleColor(
                        color: colors[idx],
                        onTap: { onTapColor(idx) },
                        selected: idx == selectedColor
                    )
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
}

struct ColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelector(
            colors: [.red, .blue, .green],
            onTapColor: { _ in },
            selectedColor: 1
        )
    }
}
