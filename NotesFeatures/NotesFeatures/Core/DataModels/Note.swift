
import Foundation
import NotesCore

public struct Note : Equatable {
    let id: Int
    let title: String
    let content: String
    let shortContent : String
    let color: String
    let creationDate : DateVisualizer?

    public init(
        id: Int = -1,
        title: String = "",
        content: String = "",
        shortContent: String = "",
        color: String = "",
        creationDate: DateVisualizer? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.shortContent = shortContent
        self.color = color
        self.creationDate = creationDate
    }
}
