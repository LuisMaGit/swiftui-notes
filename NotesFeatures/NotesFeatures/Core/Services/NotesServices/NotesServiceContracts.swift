import Foundation

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

let INSERT_DUMB_DATA_NOTES_TABLE = """
INSERT INTO Notes (title, content, color)
VALUES
    ("Meeting Notes", "Discussion points for today's meeting", "red_orange"),
    ("Grocery List", "Items to buy for the weekend", "red_pink"),
    ("Vacation Plans", "Ideas for our upcoming trip", "baby_blue"),
    ("Favorite Movies", "List of top movies to watch", "violet"),
    ("Garden Checklist", "Tasks for the garden this week", "light_green"),
    ("Recipe Book", "New recipes to try out", "red_orange"),
    ("Book Recommendations", "Books to read this year", "red_pink"),
    ("Fitness Goals", "Workout and health objectives", "baby_blue"),
    ("Dream Journal", "Record your dreams and reflections", "violet"),
    ("Home Decor Ideas", "Inspiration for decorating our home", "light_green"),
    ("Family Photos", "Album organization and printing", "red_orange"),
    ("Budget Planning", "Financial goals and expenses", "red_pink"),
    ("Project Ideas", "Brainstorming for creative projects", "baby_blue"),
    ("Learning List", "Topics and skills to study", "violet"),
    ("Travel Bucket List", "Dream destinations to visit", "light_green"),
    ("Restaurant Reviews", "Favorite eateries and reviews", "red_orange"),
    ("Health Diary", "Tracking health and well-being", "red_pink"),
    ("Tech Wishlist", "Gadgets and tech items to consider", "baby_blue"),
    ("Holiday Plans", "Ideas for holiday celebrations", "violet"),
    ("Hobby Pursuits", "Hobbies to explore and master", "light_green");
"""
