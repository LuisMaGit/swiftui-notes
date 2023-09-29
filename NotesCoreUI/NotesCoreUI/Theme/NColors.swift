
import SwiftUI

public struct NColors {
    private static var bundle: Bundle? {
        return Bundle(identifier: NotesCoreUIContracts.bundle)
    }

    private static func getBundleColor(_ named: String) -> Color {
        Color(named, bundle: bundle)
    }

    private static func getDark(_ named: String) -> Color {
        return Color(
            UIColor(
                named: named,
                in: bundle,
                compatibleWith: nil
            )?.resolvedColor(
                with: UITraitCollection(
                    userInterfaceStyle: .dark
                )
            ) ?? .green
        )
    }

    private static func getLight(_ named: String) -> Color {
        return Color(
            UIColor(
                named: named,
                in: bundle,
                compatibleWith: nil
            )?.resolvedColor(
                with: UITraitCollection(
                    userInterfaceStyle: .light
                )
            ) ?? .green
        )
    }

    private static let backgroundKey = "background"
    public static let background = getBundleColor(backgroundKey)
    public static let backgroundDark = getDark(backgroundKey)
    public static let backgroundLight = getLight(backgroundKey)

    private static let backgroundInverseKey = "background_inverse"
    public static let backgroundInverse = getBundleColor(backgroundInverseKey)
    public static let backgroundInverseLight = getLight(backgroundInverseKey)
    public static let backgroundInverseDark = getDark(backgroundInverseKey)

    private static let backgroundLighterKey = "background_lighter"
    public static let backgroundLighter = getBundleColor(backgroundLighterKey)
    public static let backgroundLighterLight = getLight(backgroundLighterKey)
    public static let backgroundLighterDark = getDark(backgroundLighterKey)

    private static let backgroundLighterInverseKey = "background_lighter_inverse"
    public static let backgroundLighterInverse = getBundleColor(backgroundLighterInverseKey)
    public static let backgroundLighterInverseLight = getLight(backgroundLighterInverseKey)
    public static let backgroundLighterInverseDark = getDark(backgroundLighterInverseKey)

    public static let accent = getBundleColor("blue_bright")

    // notes colors
    public static let redOrange = getBundleColor("red_orange")
    public static let redPink = getBundleColor("red_pink")
    public static let babyBlue = getBundleColor("baby_blue")
    public static let violet = getBundleColor("violet")
    public static let lightGreen = getBundleColor("light_green")
}
