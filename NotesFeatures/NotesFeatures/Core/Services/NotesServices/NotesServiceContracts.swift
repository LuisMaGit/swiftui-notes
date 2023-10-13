import Foundation

public enum NotesServiceNotesQueryType {
    case all
}

let SELECT_ALL_NOTES = """
SELECT rowid, * FROM Notes;
"""

func notesPaginatedQuery(
    limit: Int,
    offset: Int
) -> String {
    return """
    SELECT rowid, *
    FROM Notes n
    ORDER BY creation_date DESC
    LIMIT \(limit) OFFSET \(offset);
    """
}

func notesOlderPaginatedQuery(
    limit: Int,
    offset: Int
) -> String {
    return """
    SELECT rowid, *
    FROM Notes n
    ORDER BY creation_date ASC
    LIMIT \(limit) OFFSET \(offset);
    """
}

func searchNotesPaginatedQuery(
    search: String,
    limit: Int,
    offset: Int
) -> String {
    return """
    SELECT rowid, *
    FROM Notes n
    WHERE n.title LIKE '%\(search)%' OR n.content LIKE '%\(search)%'
    ORDER BY creation_date DESC
    LIMIT \(limit) OFFSET \(offset);
    """
}

func deleteNotesQuery(
    ids: String
) -> String {
    return """
    DELETE FROM Notes WHERE rowid IN \(ids);
    """
}

func filterNotesByColor(
    color: String,
    limit: Int,
    offset: Int
) -> String {
    return """
    SELECT rowid, *
    FROM  Notes n
    WHERE  n.color == "\(color)"
    ORDER BY creation_date DESC
    LIMIT \(limit) OFFSET \(offset);
    """
}

func selectNoteById(id : Int) -> String {
    return """
    SELECT rowid, *
    FROM  Notes n
    WHERE  n.rowid == \(id)
    """
}
