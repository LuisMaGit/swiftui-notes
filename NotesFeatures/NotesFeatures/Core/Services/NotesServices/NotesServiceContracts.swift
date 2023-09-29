import Foundation

public enum NotesServiceNotesQueryType {
    case all
}

let SELECT_ALL_NOTES = """
SELECT rowid, * FROM Notes;
"""

func selectNotesPaginatedQuery(
    limit: Int,
    offset: Int
) -> String {
    return """
    SELECT rowid, *
    FROM Notes n
    ORDER BY rowid
    LIMIT \(limit) OFFSET \(offset);
    """
}

