import SwiftUI

public struct NotesColorsUtils {
    static let cardDefColor = NColors.babyBlue
    
    static let notesColorMap = [
        "red_orange": NColors.redOrange,
        "red_pink": NColors.redPink,
        "baby_blue": NColors.babyBlue,
        "violet": NColors.violet,
        "light_green": NColors.lightGreen,
    ]

    public static func getColor(_ value: String?) -> Color {
  
        guard let colorStr = value else {
            return cardDefColor
        }

        return notesColorMap[colorStr] ?? cardDefColor
    }
}
