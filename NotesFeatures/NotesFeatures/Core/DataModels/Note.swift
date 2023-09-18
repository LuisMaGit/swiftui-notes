
import Foundation

public struct Note {
    var id: Int
    var title: String
    var content: String
    var color: String
    var dateCreation: Date?

    public init(
        id: Int = -1,
        title: String = "",
        content: String = "",
        color: String = "",
        dateCreation: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.color = color
        self.dateCreation = dateCreation
    }
}
