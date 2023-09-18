import SwiftUI

public enum NTextType {
    case title
    case body
    case caption
}

public enum NTextFont: String {
    case poppinsExtraLight = "Poppins-ExtraLight"
    case poppinsRegular = "Poppins-Regular"
    case poppinsBlack = "Poppins-Black"
}

public struct NTextStyles {
    let font: NTextFont
    let fontSize: Double
    let defaultColor: Color

    public static func getStyle(_ type: NTextType) -> NTextStyles {
        switch type {
            case .title:
                return NTextStyles(
                    font: .poppinsRegular,
                    fontSize: 24,
                    defaultColor: NColors.backgroundInverse
                )
            case .body:
                return NTextStyles(
                    font: .poppinsRegular,
                    fontSize: 16,
                    defaultColor: NColors.backgroundInverse
                )
            case .caption:
                return NTextStyles(
                    font: .poppinsExtraLight,
                    fontSize: 14,
                    defaultColor: NColors.backgroundInverse
                )
        }
    }
}

public struct NText: View {
    let key: LocalizedStringKey
    let type: NTextType
    let color: Color?
    let font: NTextFont?
    let fontSize: CGFloat?
    let lineLimit: Int?

    public init(
        _ key: LocalizedStringKey,
        type: NTextType = .body,
        color: Color? = nil,
        font: NTextFont? = nil,
        fontSize: CGFloat? = nil,
        lineLimit: Int? = nil
    ) {
        self.key = key
        self.type = type
        self.color = color
        self.font = font
        self.fontSize = fontSize
        self.lineLimit = lineLimit
    }

    var style: NTextStyles {
        NTextStyles.getStyle(type)
    }

    var getFont: Font? {
        .custom(
            font?.rawValue ?? style.font.rawValue,
            size: fontSize ?? style.fontSize
        )
    }

    var getColor: Color {
        if let color = color {
            return color
        } else {
            return style.defaultColor
        }
    }

    public var body: some View {
        Text(key)
            .foregroundColor(getColor)
            .font(getFont)
            .lineLimit(lineLimit)
    }
}

struct NText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NText("Title", type: .title)
            NText("Body", type: .body)
            NText("Caption", type: .caption)
        }
    }
}
