import Foundation

public enum SqlManagerColumnTypeMapper {
    case integer
    case text
}

let NOTE_DB_NAME = "notes_db.db"

let CREATE_NOTES_TABLE = """
CREATE TABLE Notes (
    title TEXT,
    content TEXT,
    color TEXT,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
"""

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
    ("Hobby Pursuits", "Hobbies to explore and master", "light_green"),
    ("Random Thoughts", "Just some random musings", "red_orange"),
    ("Bucket List", "Things to do before I die", "red_pink"),
    ("Daily Journal", "Daily reflections and notes", "baby_blue"),
    ("Workout Log", "Recording daily workout routines", "violet"),
    ("Shopping List", "Items to buy for the house", "light_green"),
    ("Movie Watchlist", "Movies I want to watch soon", "red_orange"),
    ("Recipe Ideas", "New recipe concepts to explore", "red_pink"),
    ("Travel Diary", "Recording travel experiences", "baby_blue"),
    ("Birthday Plans", "Planning for upcoming birthdays", "violet"),
    ("Artistic Creations", "Ideas for artistic projects", "light_green"),
    ("Study Schedule", "Organizing study plans", "red_orange"),
    ("Pet Care Notes", "Notes for taking care of pets", "red_pink"),
    ("Home Improvement", "Projects to improve the house", "baby_blue"),
    ("Financial Goals", "Savings and investment goals", "violet"),
    ("Gaming Wishlist", "Video games to play in the future", "light_green"),
    ("Fashion Ideas", "Fashion trends and outfit ideas", "red_orange"),
    ("Event Planning", "Planning for upcoming events", "red_pink"),
    ("Music Playlist", "Favorite songs and music recommendations", "baby_blue"),
    ("To-Do List", "Daily tasks and to-do items", "violet"),
    ("Test Row", "This is a test row", "light_green");
"""
