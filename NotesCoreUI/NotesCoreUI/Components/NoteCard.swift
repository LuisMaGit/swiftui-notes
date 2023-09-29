import SwiftUI

private struct NoteCardConstants {
    static let borderRadius: Double = NBorderRadius.k10
    static let cornerSize: Double = 30
    static let lineLimitTitle: Int = 1
    static let trashcanButtonSize = 12.0
    static let cardMinHeight = 80.0
    static let cardMaxHeight = 200.0
    static let fontSizeTime = 10.0
}

public struct NoteCard: View {
    let title: String?
    let content: String
    let date: LocalizedStringKey
    let time: String
    let selected: Bool
    let color: Color

    public init(
        title: String = "",
        content: String = "",
        selected: Bool = false,
        color: Color = NColors.babyBlue,
        date: LocalizedStringKey = "",
        time: String = ""
    ) {
        self.title = title
        self.content = content
        self.selected = selected
        self.color = color
        self.date = date
        self.time = time
    }

    public var body: some View {
        ZStack(
            alignment: .topLeading
        ) {
            wrapper
            layoutBuilder
                .padding(.leading, NSpace.k16)
                .padding(
                    .trailing,
                    selected ? NoteCardConstants.cornerSize : NSpace.k16
                )
        }
        .frame(
            minHeight: NoteCardConstants.cardMinHeight,
            maxHeight: NoteCardConstants.cardMaxHeight
        )
        .fixedSize(horizontal: false, vertical: true)
    }

    @ViewBuilder var wrapper: some View {
        NoteCardWrapper(
            color: color,
            selected: selected
        )
    }

    @ViewBuilder var layoutBuilder: some View {
        VStack(
            alignment: .leading,
            spacing: 0
        ) {
            NText(
                text: title ?? "",
                type: .title,
                color: NColors.backgroundLighterDark,
                lineLimit: NoteCardConstants.lineLimitTitle
            )
            .padding(.vertical, NSpace.k8)
            NText(
                text: content,
                color: NColors.backgroundDark
            )
            .padding(.bottom, NSpace.k8)
            HStack(
                alignment: .lastTextBaseline
            ) {
                Spacer()
                NText(
                    key: date,
                    type: .caption,
                    color: NColors.backgroundLighterInverse
                )
                NText(
                    text: time,
                    type: .caption,
                    color: NColors.backgroundLighterInverse,
                    fontSize: NoteCardConstants.fontSizeTime
                )
            }
            .padding(.bottom, NSpace.k8)
        }
    }
}

private struct NoteCardWrapper: View {
    let borderRadius: Double = NoteCardConstants.borderRadius
    let cornerSize: Double = NoteCardConstants.cornerSize
    let color: Color
    let selected: Bool

    init(
        color: Color,
        selected: Bool
    ) {
        self.color = color
        self.selected = selected
    }

    var body: some View {
        Canvas { context, size in
            let cornerRRectSize = CGSize(
                width: cornerSize,
                height: cornerSize
            )

            func roundedRectBackground() {
                let cornerSizeBorderR = CGSize(
                    width: borderRadius,
                    height: borderRadius
                )
                let rRectPath = Path { path in
                    path.addRoundedRect(
                        in: CGRect(origin: .zero, size: size),
                        cornerSize: cornerSizeBorderR
                    )
                }
                context.fill(
                    rRectPath,
                    with: .color(color)
                )
            }

            func clipBackgroundCorner() {
                let clipRightCornerPath = Path { path in
                    path.move(
                        to: CGPoint(
                            x: size.width - cornerRRectSize.width,
                            y: 0
                        )
                    )
                    path.addLine(
                        to: CGPoint(
                            x: size.width,
                            y: 0
                        )
                    )
                    path.addLine(
                        to: CGPoint(
                            x: size.width,
                            y: cornerRRectSize.height
                        )
                    )
                }
                context.clip(
                    to: clipRightCornerPath,
                    options: .inverse
                )
            }

            func corner() {
                let cornerColor = CoreUIUtils.blendColor(
                    color1: UIColor(color),
                    color2: UIColor(.black),
                    intensity2: 0.15
                )
                let rCornerBorderPath = Path { path in
                    path.move(
                        to: CGPoint(x: size.width - cornerRRectSize.width, y: 0)
                    )
                    path.addArc(
                        center: CGPoint(
                            x: size.width - cornerRRectSize.width + borderRadius,
                            y: cornerRRectSize.height - borderRadius
                        ),
                        radius: borderRadius,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 90),
                        clockwise: true
                    )
                    path.addLine(
                        to: CGPoint(
                            x: size.width,
                            y: cornerRRectSize.height
                        )
                    )
                }
                context.fill(
                    rCornerBorderPath,
                    with: .color(
                        Color(uiColor: cornerColor)
                    )
                )
            }

            if selected {
                clipBackgroundCorner()
            }
            roundedRectBackground()
            if selected {
                corner()
            }
        }
    }
}

struct NoteCard_Previews: PreviewProvider {
    static var previews: some View {
        NoteCard(
            title: "Title",
            content: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
            selected: true,
            date: "Today",
            time: "10:43"
        )
    }
}
