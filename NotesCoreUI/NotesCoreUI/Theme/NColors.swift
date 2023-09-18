
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

    public static let blueLight = getBundleColor("blue_light")
    public static let accent = getBundleColor("blue_bright")
}

//RedOrange (0xffffab91)
//RedPink (0xfff48fb1)
//BabyBlue (0xff81deea)
//Violet (0xffcf94da)
//LightGreen (0xffe7ed9b)
