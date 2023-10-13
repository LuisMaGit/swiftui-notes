
import Foundation
import NotesCore

public struct Note: Equatable {
    let id: Int
    let title: String
    let content: String
    let shortContent: String
    let color: NoteColor
    let creationDate: DateVisualizer?

    public init(
        id: Int = -1,
        title: String = "",
        content: String = "",
        shortContent: String = "",
        color: NoteColor = NoteColor.lightGreen,
        creationDate: DateVisualizer? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.shortContent = shortContent
        self.color = color
        self.creationDate = creationDate
    }

    public static let DEFAULT_COLOR = NoteColor.babyBlue
    
    
}

public enum NoteColor: String, CaseIterable {
    case lightGreen = "light_green"
    case redOrange = "red_orange"
    case redPink = "red_pink"
    case babyBlue = "baby_blue"
    case violet = "violet"
    
    static func getType(raw: String) -> NoteColor {
        
        for c in NoteColor.allCases{
            if c.rawValue == raw {
                return c
            }
        }
        
        return Note.DEFAULT_COLOR
    }
}
