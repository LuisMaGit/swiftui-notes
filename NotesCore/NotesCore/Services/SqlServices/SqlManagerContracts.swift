
import Foundation

let NOTE_DB_NAME = "notes_db.db"

let CREATE_NOTES_TABLE = """
CREATE TABLE Notes (
    title TEXT,
    content TEXT,
    color TEXT,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
"""


