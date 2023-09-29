import SwiftUI

public enum NIconsType: String {
    case magnifyingglass
    case horizontaldecrease = "line.3.horizontal.decrease"
    case xmark
    case trash
    case multiplyCircle = "multiply.circle"
}

public struct NIcons: View {
    let type: NIconsType
    let color: Color
    let size: Double

    public init(
        type: NIconsType,
        color: Color = NColors.backgroundLighterInverse,
        size: Double = 20
    ) {
        self.type = type
        self.color = color
        self.size = size
    }

    public var body: some View {
        Image(
            systemName: type.rawValue
        )
        .resizable()
        .foregroundColor(color)
        .frame(width: size, height: size)
    }
}

struct NIcons_Previews: PreviewProvider {
    static var previews: some View {
        NIcons(
            type: .horizontaldecrease
        )
    }
}
