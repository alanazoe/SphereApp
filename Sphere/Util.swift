//
//  Util.swift
//  media discussion
//
//  Created by Alana Greenaway on 1/28/24.
//

import Foundation
import SwiftUI
import AVFoundation

struct HighlightCoordinate {
    var chapterparagraph: (Int, Int)
    var start: Int
    var end: Int
    var color: Color
}

class User: Identifiable, Hashable, ObservableObject {
    var id: UUID
    @Published var handle: String
    @Published var name: String
    @Published var photo: String
    @Published var bio: String
    @Published var location: String
    @Published var instagram: String
    @Published var profileDisplay: ProfileDisplay
    var followers: [UUID]
    var following: [UUID]
    var posts: [UUID: [Note]]
    var currentReads: List
    var pastReads: List
    var readingList: List
    var lists: [List]
    var library: [Book]
    var status: [UUID: StatusType]
    var ratings: [UUID: Rating]
    var reviews: [UUID: Review]
    var feed: [FeedItem]
    var notes: [UUID: [UUID: Note]]
    var characters: [UUID: [Character]]
    var terms: [UUID: [Term]]
    var quotes: [UUID: [UUID: Quote]]
    var images: [UUID: [Image]]
    @Published var highlights: [UUID: [HighlightCoordinate]]
    var queue: [Book]
    var sharedNotes: Set<UUID>
    var conversations: [UUID: Conversation]

    init(id: UUID = UUID(), handle: String = "emptyuser", name: String = "Empty Name", photo: String = "", bio: String = "", location: String = "", instagram: String = "", profileDisplay: ProfileDisplay = ProfileDisplay(id: UUID(), pinnedBooks: [], pinnedPosts: [], pinnedReviews: [], pinnedLists: []), followers: [UUID] = [], following: [UUID] = [], posts: [UUID: [Note]] = [:], currentReads: List = List(title: "Reading"), pastReads: List = List(title: "Read"), readingList: List = List(title: "To Be Read"), lists: [List] = [], library: [Book] = [], status: [UUID: StatusType] = [:], ratings: [UUID: Rating] = [:], reviews: [UUID: Review] = [:], feed: [FeedItem] = [], notes: [UUID: [UUID: Note]] = [:], characters: [UUID: [Character]] = [:], terms: [UUID: [Term]] = [:], quotes: [UUID: [UUID: Quote]] = [:], images: [UUID: [Image]] = [:], highlights: [UUID: [HighlightCoordinate]] = [:], queue: [Book] = [], sharedNotes: Set<UUID> = Set<UUID>(), conversations: [UUID: Conversation] = [:]) {
        self.id = id
        self.handle = handle
        self.name = name
        self.photo = photo
        self.bio = bio
        self.location = location
        self.instagram = instagram
        self.profileDisplay = profileDisplay
        self.followers = followers
        self.following = following
        self.posts = posts
        self.currentReads = currentReads
        self.pastReads = pastReads
        self.readingList = readingList
        self.lists = lists
        self.library = library
        self.status = status
        self.ratings = ratings
        self.reviews = reviews
        self.feed = feed
        self.notes = notes
        self.characters = characters
        self.terms = terms
        self.quotes = quotes
        self.images = images
        self.highlights = highlights
        self.queue = queue
        self.sharedNotes = sharedNotes
        self.conversations = conversations

    }
    
    // Hashable protocol conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    func isShared(noteid: UUID) -> Bool {
        return sharedNotes.contains(noteid)
    }
    
    func addPost(post: Note) {
        let bookId = post.book.id
        if posts[bookId] == nil {
            posts[bookId] = []
        }
        posts[bookId]?.append(post)
    }
    func isStatusList(list: List) -> Bool {
        return self.isTBRList(list: list) && self.isReadList(list: list) && self.isReadingList(list: list)
    }
    func isTBRList(list: List) -> Bool {
        if list.id == readingList.id {
            return true
        } else {
            return false
        }
    }
    
    func isReadList(list: List) -> Bool {
        if list.id == pastReads.id {
            return true
        } else {
            return false
        }
    }
    func isReadingList(list: List) -> Bool {
        if list.id == currentReads.id {
            return true
        } else {
            return false
        }
    }
    func addBook(book: Book, status: StatusType){
        self.library.append(book)
        self.status[book.id] = status
        if status == .read {
            self.pastReads.books.append(book)
        } else if status == .current {
            self.currentReads.books.append(book)
        } else if status == .tbr {
            self.readingList.books.append(book)
        }
    }
    
    func follow(user: User) {
        self.followers.append(user.id)
    }
    
    func getAllLists() -> [List]{
        var allLists = [currentReads]
        allLists.append(pastReads)
        allLists.append(readingList)
        allLists.append(contentsOf: lists)
        return allLists
    }
    
    func addCharacter(bookid: UUID, character: Character){
        if characters[bookid] != nil {
            characters[bookid]!.append(character)
        } else {
            characters[bookid] = [character]
        }
    }
    
    func getAllBookCharacters(bookid: UUID) -> [Character]{
        return characters[bookid] ?? []
        
    }
    
    
    func addTerm(bookid: UUID, term: Term){
        if terms[bookid] != nil {
            terms[bookid]!.append(term)
        } else {
            terms[bookid] = [term]
        }
    }
    
    
    func getAllBookTerms(bookid: UUID) -> [Term]{
        return terms[bookid] ?? []
        
    }
    
    
    func getAllBookImages(bookid: UUID) -> [Image]{
        return images[bookid] ?? []
        
    }
    
    func addConvo(recipientIds: [UUID]) {
        var newConvo = Conversation(participants: [self.id] + recipientIds)
        self.conversations[newConvo.id] = newConvo
    }
    
    func getAllConversations()-> [Conversation]{
        return conversations.flatMap { $0.value }
    }

    func addQuote(quote: Quote) {
        let bookId = quote.book.id
        if quotes[bookId] == nil {
            quotes[bookId] = [:]
        }
        quotes[bookId]?[quote.id] = quote
    }
    
    
    func getAllUserQuotes() -> [Quote]{
        return quotes.flatMap { $0.value.values }
    }

    func unfollow(user: User) {
        self.followers.append(user.id)
    }
    
    func read(book: Book) -> Bool {
        return self.pastReads.books.contains(where: { $0.id == book.id })
    }
    
    func addRating(rating: Rating){
        ratings[rating.book.id] = rating
    }
    func getRating(bookid: UUID) -> Rating? {
        return ratings[bookid]
    }
    
    func getAllRatings() -> [Rating] {
        return Array(ratings.values)
    }
    
    func getAllBooks() -> [Book] {
        return library
    }
    
    func getFollowerCount() -> Int {
        return followers.count
    }
    
    func getFollowingCount() -> Int {
        return following.count
    }
    
    func getAllFollowerIDs() -> [UUID] {
        return followers
    }
    func getAllFollowingIDs() -> [UUID] {
        return following
    }
    func hasNotes(bookid: UUID) -> Bool {
        return notes[bookid] != nil
    }
    func getPostsByID(bookid: UUID) -> [Note] {
        if posts[bookid] != nil {
            return posts[bookid]!
        } else {
            return []
        }
    }
    
    func getNotesByBookID(bookid: UUID) -> [Note] {
        // Check if the book ID exists in the notes dictionary
        if let bookNotes = notes[bookid] {
            // Return the values (notes) of the inner dictionary as an array
            return Array(bookNotes.values)
        } else {
            // Return an empty array if the book ID is not found
            return []
        }
    }
    
    func getQuotesByBookID(bookid: UUID) -> [Quote] {
        // Check if the book ID exists in the notes dictionary
        if let bookQuotes = quotes[bookid] {
            // Return the values (notes) of the inner dictionary as an array
            return Array(bookQuotes.values)
        } else {
            // Return an empty array if the book ID is not found
            return []
        }
    }
    

    // Function to get a note by its book ID and note ID
    func getNoteByNoteID(bookid: UUID, noteid: UUID) -> Note? {
        // Check if the book ID exists in the notes dictionary
        if let bookNotes = notes[bookid] {
            // Check if the note ID exists in the inner dictionary
            if let note = bookNotes[noteid] {
                return note
            }
        }
        // Return nil if the note is not found
        return nil
    }
    
    func getQuoteByQuoteID(bookid: UUID, quoteid: UUID) -> Quote? {
        if let bookQuotes = quotes[bookid] {

            if let quote = bookQuotes[quoteid] {
                return quote
            }
        }
        // Return nil if the note is not found
        return nil
    }
    
    func changeBookStatus(book: Book, newStatus: StatusType){
        if let stat = status[book.id] {
            status[book.id] = newStatus
        } else {
            addBook(book: book, status: newStatus)
        }
    }
    
    func getStatus(bookid: UUID) -> StatusType? {
        if let stat = status[bookid]{
            return stat
        } else {
            return nil
        }
    }
    
    func addList(list: List){
        lists.append(list)
    }
    
    
    
    func addHighlight(bookid: UUID, chapterNumber: Int, paragraphNumber: Int,  start: Int, end: Int, color: Color) {
        if highlights[bookid] != nil {
            highlights[bookid]!.append(HighlightCoordinate(chapterparagraph: (chapterNumber, paragraphNumber), start: start, end: end, color: color))
        } else {
            highlights[bookid] = [HighlightCoordinate(chapterparagraph: (chapterNumber, paragraphNumber),  start: start, end: end, color: color)]
        }
    }
    
    func getHighlightsByBook(bookid: UUID) -> [HighlightCoordinate] {
        if let lights = highlights[bookid] {
            return lights
        } else {
            return []
        }
    }
    
    func getAllPosts() -> [Note] {
        return posts.flatMap { $0.value }
    }
    
    func getAllNotes() -> [Note] {
        return notes.flatMap { $0.value.values }
    }

    // Function to add a note
    func addNote(note: Note) {
        let bookId = note.book.id
        if notes[bookId] == nil {
            notes[bookId] = [:]
        }
        notes[bookId]?[note.id] = note
    }
    
    func hasReviewed(bookid: UUID) -> Bool {
        return reviews[bookid] != nil
    }
    
    func getReviewByID(bookid: UUID) -> Review? {
        return reviews[bookid]

    }
    
    func getAllReviews() -> [Review] {
        return reviews.flatMap { $0.value }
    }
    
    func addReview(review: Review) {
        review.rating.book.addReview(review: review)
        reviews[review.rating.book.id] = review
        ratings[review.rating.book.id] = review.rating
    }

    
    func applyAnnotationsToBook(book: Book) -> Book {
        let annotations = getHighlightsByBook(bookid: book.id)
        
        for annotation in annotations {
            let paragraphIndex = annotation.chapterparagraph.1
            let chapterIndex = annotation.chapterparagraph.0
            guard paragraphIndex >= 0 && paragraphIndex < book.ebook.pages.count else { continue }
            
            let paragraph = book.ebook.pages[paragraphIndex]
            var text = paragraph.text
            
            let start = text.index(text.startIndex, offsetBy: annotation.start)
            let end = text.index(text.startIndex, offsetBy: annotation.end)
            
            text.insert(contentsOf: "</hi>", at: end)
            text.insert(contentsOf: "<hi>", at: start)
            
            book.ebook.pages[paragraphIndex].text = text
        }
        
        return book
    }

    /* func notifyHighlightsUpdated() {
        objectWillChange.send()
    }*/
}
func timeSince(from date: Date) -> String {
    let calendar = Calendar.current
    let now = Date()
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
    
    if let year = components.year, year > 0 {
        return "\(year) y"
    } else if let month = components.month, month > 0 {
        return "\(month) mon"
    } else if let day = components.day, day > 0 {
        return "\(day) d"
    } else if let hour = components.hour, hour > 0 {
        return "\(hour) h"
    } else if let minute = components.minute, minute > 0 {
        return "\(minute) min"
    } else {
        return "now"
    }
}

enum StatusType {
    case read
    case tbr
    case current
}
extension StatusType {
    var displayName: String {
        switch self {
        case .tbr: return "To Be Read"
        case .current: return "Reading"
        case .read: return "Read"
        }
    }
    
    var color: Color {
        switch self {
        case .tbr: return Color(hex: "#fff9d0")
        case .current: return Color(hex: "#dbc7e4") //Color(hex: "#f7ecf2")
        case .read: return Color(hex: "#d1ebc7")
        }
    }
    
    func bookCount(userData: UserData) -> Int {
        switch self {
        case .tbr: return userData.user.readingList.books.count
        case .current: return userData.user.currentReads.books.count
        case .read: return userData.user.pastReads.books.count
        }
    }
}

struct Achievement: Identifiable, Hashable {
    var id: UUID
    var name: String
    var badge: String
    
}

class LoverAchievemnt: Identifiable {
    var id: UUID
    var name: String
    var badge: String
    
    init(id: UUID = UUID(), name: String = "Lover", badge: String = "heartbadge") {
        self.id = id
        self.name = name
        self.badge = badge
    }
}


class Citation {
    let author: String
    let title: String
    let year: Int
    let publisher: String

    init(author: String, title: String, year: Int, publisher: String) {
        self.author = author
        self.title = title
        self.year = year
        self.publisher = publisher
    }

    func abaNavigate() -> String {
        return "\(author), \(title) (\(year))."
    }

    func chicagoStyle() -> String {
        return "\(author). \(year). \(title). \(publisher)."
    }

    func mlaStyle() -> String {
        return "\(author). \"\(title).\" \(publisher), \(year)."
    }
}

struct ProfileDisplay: Identifiable, Hashable {
    var id: UUID
    var pinnedBooks: [Book]
    var pinnedPosts: [Note]
    var pinnedReviews: [Review]
    var pinnedLists: [List]
    
    init(id: UUID = UUID(), pinnedBooks: [Book] = [], pinnedPosts: [Note] = [], pinnedReviews: [Review] = [], pinnedLists: [List] = []) {
        self.id = id
        self.pinnedBooks = pinnedBooks
        self.pinnedPosts = pinnedPosts
        self.pinnedReviews = pinnedReviews
        self.pinnedLists = pinnedLists
    }

}


class ExploreViewModel: ObservableObject {
    @Published var contentViewModel = ContentViewModel(book: Book())
    @Published var showSearch = false
    @Published var searchText = ""
    @Published var searchHistory = ["History 1", "History 2", "History 3"]
    @Published var searched = false
    @Published var backgroundColor = Color(hex: "#FDFAEF")
    @Published var foregroundColor = Color(.black)
    @Published var create = false
    @Published var showMedia = Book()
    @Published var longPress = false
    @Published var showBook = false
    @Published var selectedBook = Book()
    @Published var showEReader = false
    @Published var bookOffset = 0.0
    @Published var listOffset = UIScreen.main.bounds.width
    @Published var index = 0
    @Published var selectedList = List()
    @Published var showList = false
    @Published var selectedTab = 0
    @Published var showPost = false
    @Published var selectedPost = Note()
    @Published var showProfile = false
    @Published var selectedProfile = User()
    @Published var postActions = false
    @Published var isLiked = false
    @Published var showReview = false
    @Published var selectedReview = Review()
}
/*
class FeedViewModel: ObservableObject {
    // Add properties that need to be preserved
}

class ProfileViewModel: ObservableObject {
    // Add properties that need to be preserved
}

*/



class ContentViewModel: ObservableObject {
    @Published var book: Book
    @Published var isPresentingDiscPopup = false
    @Published var isPresentingMoreInfo = false
    @Published var isPresentingBuy = false
    @Published var isBookmarked = false
    @Published var backgroundColor = Color(hex: "#FDFAEF")
    @Published var foregroundColor = Color(hex: "#000000")
    @Published var color1: UIColor? = nil
    @Published var color2: UIColor? = nil
    @Published var isPresentingAddToLibrary = false
    @Published var selectedList: Int = 0
    @Published var create = false
    @Published var xoffset = 0.0
    @Published var showEReader: Bool = false
    @Published var toolbarActive = false
    @Published var selectedImageIndex = 0
    @Published var showBook = true
    @Published var showPost = false
    @Published var selectedPost = Note()
    @Published var showNotificationView = false
    @Published var selectedBook = Book()
    @Published var refreshID = UUID()
    @Published var showReview = false
    @Published var selectedReview = Review()
    @Published var isLiked = false
    @Published var postActions = false
    @Published var showRateView = false
    @Published var rating: Float = 5.0
    @Published var initialRating: Float = 1.0
    @Published var showCreateReview = false
    @Published var showProfile = false
    @Published var selectedProfile = User()
    @Published var showAuthor = false
    @Published var showToolbar: Bool = false
    @Published var showActivity: Bool = false
    @Published var selectedUser: User = User()
    @Published var changeStatus = false
    @Published var showQuotes: Bool = false

    init(book: Book, showActivity: Bool = false, selectedUser: User = User()) {
        self.book = book
        self.showActivity = showActivity
        self.selectedUser = selectedUser
        
    }
    
    func formatLargeNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if number >= 1_000_000_000 {
            return formatter.string(from: NSNumber(value: Double(number) / 1_000_000_000))! + "b"
        } else if number >= 1_000_000 {
            return formatter.string(from: NSNumber(value: Double(number) / 1_000_000))! + "m"
        } else if number >= 1_000 {
            return formatter.string(from: NSNumber(value: Double(number) / 1_000))! + "k"
        } else {
            return "\(number)"
        }
    }
}

func formatLargeNumber(_ number: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 1
    
    if number >= 1_000_000_000 {
        return formatter.string(from: NSNumber(value: Double(number) / 1_000_000_000))! + "b"
    } else if number >= 1_000_000 {
        return formatter.string(from: NSNumber(value: Double(number) / 1_000_000))! + "m"
    } else if number >= 1_000 {
        return formatter.string(from: NSNumber(value: Double(number) / 1_000))! + "k"
    } else {
        return "\(number)"
    }
}

struct FeedItem: Identifiable, Hashable {
    var id: UUID
    var type: FeedType
    var post: Note?
    var review: Review?
    var quote: Quote2?
    var list: List?
    var rating: Rating?

}


enum FeedType: String, Hashable {
    case post = "post"
    case review = "review"
    case quote = "quote"
    case read = "read"
    case list = "list"
    case rating = "rating"
}


enum ReactionType: String, CaseIterable, Identifiable {
    case laugh = "😂"
    case blush = "😊"
    case shock = "😨"
    case anger = "😡"
    case tear = "😢"
    case applause = "👏"
    case love = "❤️"
    case loveStruck = "🥰"
    case party = "🥳"
    case celebrate = "🎉"
    case thinking = "🤔"
    case sleepy = "😴"
    case sad = "😔"
    case confused = "😕"
    case facepalm = "🤦"
    case grimace = "😬"

    var id: String { self.rawValue }
}
class Reaction: Identifiable, ObservableObject  {
    var id: ReactionType { type }
    var type: ReactionType
    @Published var count: Int
    
    init(type: ReactionType, count: Int) {
        self.type = type
        self.count = count
    }
    
}


class PostLibrary: Identifiable, Hashable, ObservableObject {
    var id: UUID
    var posts: [Note]
    
    init(id: UUID = UUID(), posts: [Note] = []){
        self.id = id
        self.posts = posts
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: PostLibrary, rhs: PostLibrary) -> Bool {
        lhs.id == rhs.id
    }
}

class Note : Identifiable, Hashable, ObservableObject, Observable {
    @Published var id: UUID
    @Published var user: User
    @Published var title: String
    @Published var description: String
    @Published var likes: Int
    @Published var upvotes: Int
    @Published var downvotes: Int
    @Published var comments: [Comment]
    @Published var timestamp: Date
    @Published var book: Book
    @Published var chapterparagraph: (Int, Int)
    @Published var spoiler: Bool
    @Published var pub: Bool
    @Published var characters: [Character]
    @Published var terms: [Term]
    @Published var quote: Quote
    @Published var elements: [NoteElement]
    @State var allText: String
    @Published var coverShown: Bool
    
    
    init(id: UUID = UUID(), user: User = User(), title: String = "", description: String = "", likes: Int = 0, upvotes: Int = 0, downvotes: Int = 0, comments: [Comment] = [], timestamp: Date = Date(), book: Book = Book(), chapterparagraph: (Int, Int) = (1,1), spoiler: Bool = false, pub: Bool = false, characters: [Character] = [], terms: [Term] = [], quote: Quote = Quote(), elements: [NoteElement] = [], allText: String = "", coverShown: Bool = true) {
        self.id = id
        self.user = user
        self.title = title
        self.description = description
        self.likes = likes
        self.upvotes = upvotes
        self.downvotes = downvotes
        self.comments = comments
        self.timestamp = timestamp
        self.book = book
        self.chapterparagraph = chapterparagraph
        self.spoiler = spoiler
        self.pub = pub
        self.characters = characters
        self.terms = terms
        self.quote = quote
        self.elements = elements
        self.allText = elements.reduce("") { result, element in
            if element.isText {
                return result + element.text!
            } else {
                return result
            }
        }
        self.coverShown = coverShown
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }
    
    func getAllText() -> String {
        return self.allText
    }
    
    func addText(text: String){
        self.elements
    }
    
    func isPublished() -> Bool {
        return self.pub
    }
    
    func upvote() {
        upvotes += 1
    }
    
    func downvote(){
        downvotes += 1
    }
    
    func getNetVotes() -> Int {
        return upvotes - downvotes
    }
    
    func getUpvotes() -> Int {
        return upvotes
    }
    
    func getDownvotes() -> Int {
        return downvotes
    }
}



class Review: Identifiable, Hashable {
    var id: UUID
    var rating: Rating // Assume a 1-5 scale
    var title: String
    var description: String
    var likes: Int
    var comments: [Comment]
    var timestamp: Date
    
    init(id: UUID = UUID(), rating: Rating = Rating(), title: String = "", description: String = "", likes: Int = 0, comments: [Comment] = [], timestamp: Date = Date()) {
        self.id = id
        self.rating = rating
        self.title = title
        self.description = description
        self.likes = likes
        self.comments = comments
        self.timestamp = timestamp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Review, rhs: Review) -> Bool {
        lhs.id == rhs.id
    }
    func addComment(comment: Comment){
        comments.append(comment)
    }
}

class Rating: Identifiable, Hashable {
    var id: UUID
    var user: User
    var book: Book
    var stars: Float
    var likes: Int
    var comments: [Comment]
    var timestamp: Date

    init(id: UUID = UUID(), user: User = User(), book: Book = Book(), stars: Float = 0.0, likes: Int = 0, comments: [Comment] = [], timestamp: Date = Date()) {
        self.id = id
        self.user = user
        self.book = book
        self.stars = stars
        self.likes = likes
        self.comments = comments
        self.timestamp = timestamp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Rating, rhs: Rating) -> Bool {
        lhs.id == rhs.id
    }

}

class Quote: Identifiable, Hashable {
    var id: UUID
    var quote: String
    var book: Book
    var speaker: Character
    var chapter: Int
    var pageNumber: Int
    var likes: Int
    var comments: [Comment]

    init(id: UUID = UUID(), quote: String = "", book: Book = Book(), speaker: Character = Character(bookid: UUID()), chapter: Int = 1, pageNumber: Int = 1, likes: Int = 0, comments: [Comment] = []) {
        self.id = id
        self.quote = quote
        self.book = book
        self.speaker = speaker
        self.chapter = chapter
        self.pageNumber = pageNumber
        self.likes = likes
        self.comments = comments
    }
    // Hashable protocol conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Quote, rhs: Quote) -> Bool {
        lhs.id == rhs.id
    }
}

class Quote2: Identifiable, Hashable {
    var id: UUID
    var user: User
    var quote: String
    var title: String
    var description: String
    var likes: Int
    var comments: [Comment]
    var timestamp: Date
    var book: Book
    
    init(id: UUID = UUID(),
         user: User = User(),
         quote: String = "",
         title: String = "",
         description: String = "",
         likes: Int = 0,
         comments: [Comment] = [],
         timestamp: Date = Date(),
         book: Book = Book()) {
        self.id = id
        self.user = user
        self.quote = quote
        self.title = title
        self.description = description
        self.likes = likes
        self.comments = comments
        self.timestamp = timestamp
        self.book = book
    }
    
    // Hashable protocol conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Quote2, rhs: Quote2) -> Bool {
        lhs.id == rhs.id
    }
}

enum PrivacyType {
    case `private`
    case `public`
}

class List: Identifiable, Hashable, ObservableObject {
    var id: UUID
    var user: UUID
    var title: String
    var description: String
    var books: [Book]
    var privacy: PrivacyType
    
    init(id: UUID = UUID(), user: UUID = UUID(), title: String = "", description: String = "", books: [Book] = [], privacy: PrivacyType = .public) {
        self.id = id
        self.user = user
        self.title = title
        self.description = description
        self.books = books
        self.privacy = privacy
    }
    
    // Hashable protocol conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: List, rhs: List) -> Bool {
        lhs.id == rhs.id
    }
    
    func moveToFront(book: Book) {

        if let index = books.firstIndex(where: { $0.id == book.id }) {
            // Remove the book at the found index
            books.remove(at: index)
            // Insert it at the front of the array
            books.insert(book, at: 0)

        }

        
    }
    
    func isPrivate() -> Bool {
        if privacy == .private {
            return true
        } else {
            return false
        }
    }
    func makePublic() {
        privacy = .public
    }
    func makePrivate() {
        privacy = .private
    }
}

class Author: Identifiable, ObservableObject, Hashable {
    var id: UUID
    var user: User?
    @Published var name: String
    @Published var photo: String
    @Published var bio: String
    var books: [Book]
    var favorites: Int
    
    init(id: UUID = UUID(), user: User? = nil, name: String = "Author Name", photo: String = "", bio: String = "", books: [Book] = [], favorites: Int = 0) {
        self.id = id
        self.user = user
        self.name = name
        self.photo = photo
        self.bio = bio
        self.books = books
        self.favorites = favorites
    }
    
    // Hashable protocol conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Author, rhs: Author) -> Bool {
        lhs.id == rhs.id
    }
   
    func getReviews()-> [Review] {
        /* var allreviews: [Review] = []
         
         for book in self.books {
         allreviews += book.reviews
         }
         */
        return []
    }
}

class Book: Identifiable, ObservableObject, Hashable {
    var id: UUID
    var title: String
    var author: Author
    var synopsis: String
    var readers: Int
    var cover: String
    var genre: Genre
    var rating: Float
    var year: String
    var length: String
    var discussion: Discussion
    var reviews: [UUID: Review]
    var currentPage: Int?
    var totalPages: Int?
    var price: Double
    var ebook: SphereEBook
    
    init(id: UUID = UUID(), title: String = "", author: Author = Author(), synopsis: String = "", readers: Int = 0, cover: String = "", genre: Genre = .unknown, rating: Float = 0.0, year: String = "2024", length: String = "", discussion: Discussion = Discussion(id: UUID(), posts: []), reviews: [UUID: Review] = [:], currentPage: Int? = nil, totalPages: Int? = nil, price: Double = 0.0, ebook: SphereEBook = SphereEBook()) {
        self.id = id
        self.title = title
        self.author = author
        self.synopsis = synopsis
        self.readers = readers
        self.cover = cover
        self.genre = genre
        self.rating = rating
        self.year = year
        self.length = length
        self.discussion = discussion
        self.reviews = reviews
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.price = price
        self.ebook = ebook
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func addPost(post: Note) {
        self.discussion.posts.append(post)
        post.pub = true
    }
    
    func addReview(review: Review) {
        self.reviews[review.rating.user.id] = review
    }
    
    func getAllReviews() -> [Review] {
        return Array(self.reviews.values)
    }
    
    func getGenre() -> Genre {
        return genre
    }
    
    func getPostCount() -> Int {
        return discussion.posts.count
    }
    
    func getReadersString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if self.readers >= 1_000_000_000 {
            return formatter.string(from: NSNumber(value: Double(self.readers) / 1_000_000_000))! + "b"
        } else if self.readers >= 1_000_000 {
            return formatter.string(from: NSNumber(value: Double(self.readers) / 1_000_000))! + "m"
        } else if self.readers >= 1_000 {
            return formatter.string(from: NSNumber(value: Double(self.readers) / 1_000))! + "k"
        } else {
            return "\(self.readers)"
        }
    }
    
}



class Library: ObservableObject {
    @Published var library: [Book]
    
    init(library: [Book]) {
        self.library = library
    }
    
  /*  @Published var library: [UUID: Book]

    init(library: [UUID: Book]) {
        self.library = library
    }
    
    func getBookById(bookid: UUID) -> Book? {
        return library[bookid]
    }
    
    func getAllBooks() -> [Book] {
        return Array(library.values)
    }*/
}



struct Discussion : Identifiable, Hashable {
    var id: UUID
    var posts: [Note]
}




class Comment: Identifiable, Hashable {
    var id: UUID
    var user: User
    var comment: String
    var likes: Int
    var timestamp: Date
    var replies: [Comment]
    var isReply: Bool
    var replyTo: Comment?
    var hasQuote: Bool
    var quote: Quote2
    var image: String?
    
    init(id: UUID = UUID(),
         user: User = User(),
         comment: String = "",
         likes: Int = 0,
         timestamp: Date = Date(),
         replies: [Comment] = [],
         isReply: Bool = false,
         replyTo: Comment? = nil, hasQuote: Bool = false, quote: Quote2 = Quote2(), image: String? = nil) {
        self.id = id
        self.user = user
        self.comment = comment
        self.likes = likes
        self.timestamp = timestamp
        self.replies = replies
        self.isReply = isReply
        self.replyTo = replyTo
        self.hasQuote = hasQuote
        self.quote = quote
        self.image = image
    }
    
    // Hashable protocol conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        lhs.id == rhs.id
    }
    
    func addImage(image: String){
        self.image = image
    }
}




struct GenreTag: View {
    @State var book: Book
    @Binding var showGenre: Bool
    @Binding var selectedGenre: Genre?
    @State var fontSize: Double = 13.0
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        let thisGenre = book.getGenre()
        
        Button(action: {
            showGenre.toggle()
            selectedGenre = thisGenre
        }){
            Text(thisGenre.rawValue)
                .padding(7)
                .font(.system(size: fontSize, weight: .medium))
                .lineLimit(1)
                .foregroundColor(.black)
                .background(
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color(hex: "#FDFAEF"))
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(thisGenre.color.opacity(0.1))
                        
                    }
                )
        }
    }
}


enum Genre: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case mystery = "Mystery"
    case romance = "Romance"
    case fantasy = "Fantasy"
    case scienceFiction = "Science Fiction"
    case thriller = "Thriller"
    case literaryFiction = "Literary Fiction"
    case historicalFiction = "Historical Fiction"
    case horror = "Horror"
    case crime = "Crime"
    case adventure = "Adventure"
    case youngAdult = "Young Adult"
    case childrenLiterature = "Children's Literature"
    case westerns = "Westerns"
    case biography = "Biography"
    case autobiography = "Autobiography"
    case memoir = "Memoir"
    case essays = "Essays"
    case history = "History"
    case trueCrime = "True Crime"
    case selfHelp = "Self-Help"
    case healthAndWellness = "Health and Wellness"
    case science = "Science"
    case travel = "Travel"
    case cookingAndFood = "Cooking and Food"
    case politics = "Politics"
    case businessAndEconomics = "Business and Economics"
    case philosophy = "Philosophy"
    case religionAndSpirituality = "Religion and Spirituality"
    case artAndPhotography = "Art and Photography"
    case poetry = "Poetry"
    case drama = "Drama"
    case graphicNovels = "Graphic Novels"
    case shortStories = "Short Stories"
    case unknown = "Unknown"
    
    var color: Color {
        switch self {
        case .mystery: return Color.yellow
        case .romance: return Color.pink
        case .fantasy: return Color.purple
        case .scienceFiction: return Color.blue
        case .thriller: return Color.red
        case .literaryFiction: return Color.green
        case .historicalFiction: return Color.orange
        case .horror: return Color.black
        case .crime: return Color.gray
        case .adventure: return Color.brown
        case .youngAdult: return Color.teal
        case .childrenLiterature: return Color.cyan
        case .westerns: return Color.brown
        case .biography: return Color.indigo
        case .autobiography: return Color.indigo
        case .memoir: return Color.indigo
        case .essays: return Color.mint
        case .history: return Color.brown
        case .trueCrime: return Color.red
        case .selfHelp: return Color.green
        case .healthAndWellness: return Color.green
        case .science: return Color.blue
        case .travel: return Color.orange
        case .cookingAndFood: return Color.orange
        case .politics: return Color.purple
        case .businessAndEconomics: return Color.green
        case .philosophy: return Color.purple
        case .religionAndSpirituality: return Color.purple
        case .artAndPhotography: return Color.pink
        case .poetry: return Color.purple
        case .drama: return Color.red
        case .graphicNovels: return Color.blue
        case .shortStories: return Color.teal
        case .unknown: return Color.gray
        }
    }
}


class UserData: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        
    }
    
    func sendToFeed(item: FeedItem){
       // self.user.addPost(post: item.post!)
        //self.user.feed.insert(item, at: 0)
        self.user.feed.append(item)
        
    }
     
    func addToLibrary(book: Book){
        self.user.library.append(book)
    }
    
    func addToCurrentReads(book: Book){
        self.user.currentReads.books.append(book)
    }
    
    func addToPastReads(book: Book){
        self.user.pastReads.books.append(book)
    }
    
}


extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            red: Double((rgb >> 16) & 0xff) / 255,
            green: Double((rgb >> 8) & 0xff) / 255,
            blue: Double(rgb & 0xff) / 255
        )
    }
}


struct ProfileThumbnail: View {
    var image : String
    var size: CGFloat
    
    var body: some View {
        if let img = UIImage(named: image){
            Image(uiImage: img)
            // Replace "profile_image" with your image name
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
            //.overlay(Circle().stroke(Color.white, lineWidth: 4)
        }
        
    }
}

struct AuthorThumbnail: View {
    var image : String
    var size: CGFloat
    
    var body: some View {
        if let img = UIImage(named: image){
            Image(uiImage: img)
            // Replace "profile_image" with your image name
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            //.overlay(Circle().stroke(Color.white, lineWidth: 4)
        }
        
    }
}


class Nav: ObservableObject {
    @Published var showLibrary: Bool
    @Published var showExplore: Bool
    @Published var showReader: Bool
    @Published var showFeed: Bool
    @Published var showProfile: Bool
    @Published var selectedBook: Book?
    @Published var choosingBook: Bool
    @Published var showToolbar: Bool

    init(showLibrary: Bool = true, showExplore: Bool = false, showReader: Bool = false, showFeed: Bool = false, showProfile: Bool = false, selectedBook: Book? = nil, choosingBook: Bool = false, showToolbar: Bool = true) {
        self.showLibrary = showLibrary
        self.showExplore = showExplore
        self.showReader = showReader
        self.showFeed = showFeed
        self.showProfile = showProfile
        self.selectedBook = selectedBook
        self.choosingBook = choosingBook
        self.showToolbar = showToolbar
    }
    
    func goToLibrary() {
        showLibrary = true
        showExplore = false
        showReader = false
        showFeed = false
        showProfile = false
    }
    
    func goToExplore() {
        showLibrary = false
        showExplore = true
        showReader = false
        showFeed = false
        showProfile = false
    }
    
    func goToReader() {
        showLibrary = false
        showExplore = false
        showReader = true
        showFeed = false
        showProfile = false
    }
    
    func goToFeed() {
        showLibrary = false
        showExplore = false
        showReader = false
        showFeed = true
        showProfile = false
    }
    
    func goToProfile() {
        showLibrary = false
        showExplore = false
        showReader = false
        showFeed = false
        showProfile = true
    }
    
    func chooseBook(book: Book){
        choosingBook = true
        selectedBook = book
    }
    
    func showingLibrary() -> Bool {
        return showLibrary
    }
    
    func showingExplore() -> Bool {
        return showExplore
    }
    func showingReader() -> Bool {
        return showReader
    }
    
    func showingFeed() -> Bool {
        return showFeed
    }
    
    func showingProfile() -> Bool {
        return showProfile
    }
    
    func isChoosingBook() -> Bool {
        return choosingBook
    }
    func getSelectedBook() -> Book? {
        return selectedBook
    }
    
    func reset(){
        selectedBook = nil
    }
    
    func hideToolbar(){
        showToolbar = false
    }
    func showToolbarTrue(){
        showToolbar = true
    }
    
    func showingToolbar() -> Bool {
        return showToolbar
    }
    
}


struct ToolbarView: View {
    @EnvironmentObject var navigation: Nav
    @State private var isExploreViewActive = false
    @State private var isProfileViewActive = false
    @State private var isSearchViewActive = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController
    @State private var homeButtonColor: Color = Color(hex: "BDBDBD")
    @State private var exploreButtonColor: Color = Color(hex: "BDBDBD")
    @State private var button3Color: Color = Color(hex: "BDBDBD")
    @State private var feedButtonColor: Color = Color(hex: "BDBDBD")
    @State private var profileButtonColor: Color = Color(hex: "BDBDBD")

    
    var body: some View {
        
        if navigation.showingToolbar() {
            HStack {
                Button(action: {
                    navigation.goToLibrary()
                    updateButtonColors()
                }) {
                    VStack {
                        //Image(systemName: "square.leftthird.inset.filled")
                        Image(systemName: "book")
                            .foregroundColor(homeButtonColor)
                            .font(.system(size: 21))
                        Text("Library")
                            .foregroundColor(homeButtonColor)
                            .font(.system(size: 9))
                    }
                }
                .padding(.leading)
                
                Spacer()
                Button(action: {
                    navigation.goToExplore()
                    updateButtonColors()
                }) {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(exploreButtonColor)
                            .font(.system(size: 21))
                        Text("Explore")
                            .foregroundColor(exploreButtonColor)
                            .font(.system(size: 9))
                    }
                }
                
                
                /*
                 Spacer()
                 
                 Button(action: {
                 navigation.goToReader()
                 updateButtonColors()
                 
                 }) {
                 Image(systemName: "book")
                 .foregroundColor(button3Color)
                 .font(.system(size: 24))
                 }
                 */
                
                Spacer()
                
                Button(action: {
                    navigation.goToFeed()
                    updateButtonColors()
                }) {
                    VStack {
                        Image(systemName: "tray")
                            .foregroundColor(feedButtonColor)
                            .font(.system(size: 21))
                        Text("For You")
                            .foregroundColor(feedButtonColor)
                            .font(.system(size: 9))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    navigation.goToProfile()
                    updateButtonColors()
                }) {
                    VStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(profileButtonColor)
                            .font(.system(size: 21))
                        Text("Profile")
                            .foregroundColor(profileButtonColor)
                            .font(.system(size: 9))
                    }
                }
                .padding(.trailing)
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
            .background(lightModeController.isDarkMode() && navigation.showingReader() ? Color(hex: "#121212"): lightModeController.getBackgroundColor())
            
            .overlay(
                HStack {
                    Spacer()
                    Button(action: {
                        lightModeController.switchMode()
                    }){
                        Image(systemName: "moon.circle.fill")
                            .font(.system(size: 18))
                            .foregroundColor(Color(hex: "#673AB7"))
                    }
                    
                }
                    .padding(.horizontal)
                    .padding(.top)
            )
            .onAppear {
                updateButtonColors()
            }
            .onChange(of: navigation.showingLibrary()) { _ in updateButtonColors() }
            .onChange(of: navigation.showingExplore()) { _ in updateButtonColors() }
            .onChange(of: navigation.showingFeed()) { _ in updateButtonColors() }
            .onChange(of: navigation.showingReader()) { _ in updateButtonColors() }
            .onChange(of: navigation.showingProfile()) { _ in updateButtonColors() }
            
        } else {
            HStack {
                
            }
        }
    }
    
    private func updateButtonColors() {
        if navigation.showingLibrary() {
            homeButtonColor = lightModeController.getForegroundColor()
            exploreButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingExplore() {
            exploreButtonColor = lightModeController.getForegroundColor()
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingReader() {
            button3Color = lightModeController.getForegroundColor()
            homeButtonColor = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingFeed() {
            feedButtonColor = lightModeController.getForegroundColor()
            profileButtonColor = Color(hex: "BDBDBD")
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingProfile() {
            profileButtonColor = lightModeController.getForegroundColor()
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
        }
    }
}

struct iPadToolbarView: View {
    @EnvironmentObject var navigation: Nav
    @State private var isExploreViewActive = false
    @State private var isProfileViewActive = false
    @State private var isSearchViewActive = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController
    @State private var homeButtonColor: Color = Color(hex: "BDBDBD")
    @State private var exploreButtonColor: Color = Color(hex: "BDBDBD")
    @State private var button3Color: Color = Color(hex: "BDBDBD")
    @State private var feedButtonColor: Color = Color(hex: "BDBDBD")
    @State private var profileButtonColor: Color = Color(hex: "BDBDBD")

    
    var body: some View {
        

        HStack {
            Button(action: {
                navigation.goToLibrary()
                updateButtonColors()
            }) {
                VStack {
                    //Image(systemName: "square.leftthird.inset.filled")
                    Image(systemName: "book")
                        .foregroundColor(homeButtonColor)
                        .font(.system(size: 21))
                    Text("Library")
                        .foregroundColor(homeButtonColor)
                        .font(.system(size: 9))
                }
            }
            .padding(.leading)
            
            Spacer()
            Button(action: {
                navigation.goToExplore()
                updateButtonColors()
            }) {
                VStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(exploreButtonColor)
                        .font(.system(size: 21))
                    Text("Explore")
                        .foregroundColor(exploreButtonColor)
                        .font(.system(size: 9))
                }
            }
            
               
           
            
            Spacer()
    
            
            Button(action: {
                navigation.goToFeed()
                updateButtonColors()
            }) {
                VStack {
                    Image(systemName: "tray")
                        .foregroundColor(feedButtonColor)
                        .font(.system(size: 21))
                    Text("For You")
                        .foregroundColor(feedButtonColor)
                        .font(.system(size: 9))
                }
            }
           
            Spacer()
        
            Button(action: {
                navigation.goToProfile()
                updateButtonColors()
            }) {
                VStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(profileButtonColor)
                        .font(.system(size: 21))
                    Text("Profile")
                        .foregroundColor(profileButtonColor)
                        .font(.system(size: 9))
                }
            }
            .padding(.trailing)
        }
        .padding(.horizontal)
        .padding(.vertical)
        .padding(.horizontal, UIScreen.main.bounds.width * 0.24)
        .background(lightModeController.isDarkMode() && navigation.showingReader() ? Color(hex: "#121212"): lightModeController.getBackgroundColor())

        .overlay(
            HStack {
                Spacer()
                Button(action: {
                    lightModeController.switchMode()
                }){
                    Image(systemName: "moon.circle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color(hex: "#673AB7"))
                }
                    
            }
            .padding(.horizontal)
            .padding(.vertical)
        )
        .onAppear {
            updateButtonColors()
        }
        .onChange(of: navigation.showingLibrary()) { _ in updateButtonColors() }
        .onChange(of: navigation.showingExplore()) { _ in updateButtonColors() }
        .onChange(of: navigation.showingFeed()) { _ in updateButtonColors() }
        .onChange(of: navigation.showingReader()) { _ in updateButtonColors() }
        .onChange(of: navigation.showingProfile()) { _ in updateButtonColors() }
    
         }
    
    private func updateButtonColors() {
        if navigation.showingLibrary() {
            homeButtonColor = lightModeController.getForegroundColor()
            exploreButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingExplore() {
            exploreButtonColor = lightModeController.getForegroundColor()
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingReader() {
            button3Color = lightModeController.getForegroundColor()
            homeButtonColor = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingFeed() {
            feedButtonColor = lightModeController.getForegroundColor()
            profileButtonColor = Color(hex: "BDBDBD")
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingProfile() {
            profileButtonColor = lightModeController.getForegroundColor()
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
        }
    }
}

struct SoundWaveView: View {
    @Binding var audioLevels: [CGFloat]
    
    // Base heights to stagger the bars (you can adjust the heights to match your design)
    let baseHeights: [CGFloat] = [1, 3, 4, 5, 6, 5, 4, 3, 1]
    
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            ForEach(0..<audioLevels.count, id: \.self) { index in
                Rectangle()
                    .frame(width: 3, height: baseHeights[index % baseHeights.count] + audioLevels[index]) // Adding the audio level on top of the base height
                    .cornerRadius(2)
            }
        }
    }
}


struct ReaderiPadToolbarView: View {
    @EnvironmentObject var navigation: Nav
    @State private var isExploreViewActive = false
    @State private var isProfileViewActive = false
    @State private var isSearchViewActive = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController
    @State private var homeButtonColor: Color = Color(hex: "BDBDBD")
    @State private var exploreButtonColor: Color = Color(hex: "BDBDBD")
    @State private var button3Color: Color = Color(hex: "BDBDBD")
    @State private var feedButtonColor: Color = Color(hex: "BDBDBD")
    @State private var profileButtonColor: Color = Color(hex: "BDBDBD")
    var index: Int = 0
    @Binding var showComments: Bool
    @Binding var selectedIndex: Int
    @ObservedObject var ebook: SphereEBook
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    let skipTime: TimeInterval = 10

    // New state variable to hold debug messages
    @State private var debugMessage: String = ""
    @State private var timer: Timer?
    @State private var audioLevels: [CGFloat] = Array(repeating: 10, count: 20) // Create 20 bars
    // Time tracking variables
    @State private var currentTime: TimeInterval = 0
    @State private var totalTime: TimeInterval = 0
    
    @State private var playbackSpeed: Float = 1.0
    let playbackSpeeds: [Float] = [1.0, 1.5, 2.0]
    @State var showAssistant = false
    @State var showNotes = false
    
    var body: some View {
        
        ZStack {
   
            VStack {
                Spacer()
                ProgressBar(totalPages: ebook.getPageCount(), currentPage: ebook.getCurrentPage() + 1)
                    //.padding([.bottom, .bottom])
                
                HStack {
                    Button(action: {
                        navigation.goToLibrary()
                    }){
                        VStack {
                            Image(systemName: "book.closed")
                                .font(.system(size: 21))
                            Text("Close Book")
                                .font(.system(size: 9))
                        }
                    }
                    
                    if !isPlaying {
                        Button(action: {
                            togglePlayPause()
                        }) {
                            Image(systemName: "speaker.2.fill")
                                .font(.system(size: 18, weight: .medium))
                                .frame(height: 38)
                                .padding(.horizontal)
                                .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#ECE8DA").opacity(0.5))
                                .cornerRadius(10)
                        }
                        .padding(.leading)
                    } else {
                        Button(action: {
                            togglePlayPause()
                        }) {
                            Image(systemName: "pause.fill")
                                .font(.system(size: 18, weight: .medium))
                                .frame(height: 38)
                                .padding(.horizontal)
                                .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#ECE8DA").opacity(0.5))
                                .cornerRadius(10)
                        }
                        .padding(.leading)
                    }
                    // Debug message displayed on the screen
                    /* Text(debugMessage)
                     .font(.footnote)
                     .foregroundColor(.red)
                     .padding()
                     .background(Color.black.opacity(0.8))
                     .cornerRadius(8)
                     .padding(.top, 10)*/
                    if isPlaying {
                        SoundWaveView(audioLevels: $audioLevels)
                            .frame(height: 100)
                            .padding(.horizontal)
                        
                        
                        // Time elapsed / total time display
                        VStack {
                            Text("\(formatTime(currentTime)) / \(formatTime(totalTime))")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding(.leading)
                        
                    }
                    
                    Spacer()
                }
                
            .padding(.bottom)
            /*
             .overlay(
             HStack {
             Spacer()
             Text("\(ebook.getCurrentPage()) / \(ebook.getPageCount())")
             .font(.system(size: 14))
             .foregroundColor(.gray)
             Spacer()
             }
             
             
             )*/
            .onAppear {
                loadAudio()
            }
            .padding(.horizontal)
            //.padding(.vertical)
            .background(lightModeController.isDarkMode() && navigation.showingReader() ? Color(hex: "#121212") : Color(hex: "#F7F3E5"))
            .foregroundColor(lightModeController.getForegroundColor().opacity(0.7))
            }
            //.background(lightModeController.isDarkMode() ? Color(hex: "#121212") : Color(hex: "F7F3E5"))

            .sheet(isPresented: $showNotes){
                NoteView2()
            }

            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showNotes.toggle()
                        }) {
                            Text("Notes")
                                .font(.system(size: 14, weight: .medium))
                                .frame(height: 38)
                                .padding(.horizontal)
                                .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#ECE8DA").opacity(0.5))
                                .cornerRadius(10)
                        }
                        
                        
                        Button(action: {
                            selectedIndex = index
                            showComments = true
                        }) {
                            Text("\(formatLargeNumber(ebook.pages[index].comments.count)) comments")
                                .font(.system(size: 14, weight: .medium))
                                .frame(height: 38)
                                .padding(.horizontal)
                                .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#ECE8DA").opacity(0.5))
                                .cornerRadius(10)
                        }
                        /*
                        AIAssistantButton(showAssistant: $showAssistant)
                            .padding(.trailing)
                        */
                        Button(action: {
                            lightModeController.switchMode()
                        }) {
                            Image(systemName: "moon.circle.fill")
                                .font(.system(size: 18))
                                .foregroundColor(Color(hex: "#673AB7"))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    .foregroundColor(lightModeController.getForegroundColor().opacity(0.7))
                }
            )
                    
     
            .onAppear {
                updateButtonColors()
            }
            .onChange(of: navigation.showingLibrary()) { _ in updateButtonColors() }
            .onChange(of: navigation.showingExplore()) { _ in updateButtonColors() }
            .onChange(of: navigation.showingFeed()) { _ in updateButtonColors() }
            .onChange(of: navigation.showingReader()) { _ in updateButtonColors() }
            .onChange(of: navigation.showingProfile()) { _ in updateButtonColors() }
            .onTapGesture{
                showAssistant = false
            }
            VStack(alignment: .trailing) {
                Spacer()
                if showAssistant {
                    HStack {
                        Spacer()
                        
                        AIChatBoxView(isPresented: $showAssistant)
                            .frame(width: UIScreen.main.bounds.width / 2)
                    }
                    .padding(.horizontal)
                }
                
            }
            .padding(.bottom, 80)
            
            
        }
            
           
    }

    func loadAudio() {
        // Set up and activate the audio session
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
            
        } catch {
            debugMessage = "Failed to set up audio session: \(error.localizedDescription)"
        }

        guard let url = Bundle.main.url(forResource: "greatgatsby_audio", withExtension: "mp3") else {
            debugMessage = "Error: Audio file not found in the bundle."
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.isMeteringEnabled = true  // Enable metering
            audioPlayer?.volume = 1.0  // Ensure volume is set to maximum
            debugMessage = "Successfully loaded audio"
            totalTime = audioPlayer?.duration ?? 0 // Get total duration of the audio

        } catch let error as NSError {
            debugMessage = "Error initializing audio player: \(error.localizedDescription)"
        }
    }

    func togglePlayPause() {
        guard let player = audioPlayer else {
            debugMessage = "Audio player not available."
            return
        }

        if player.isPlaying {
            player.pause()
            timer?.invalidate()
            debugMessage = "Paused audio"
        } else {
            player.play()
            startMetering()
            startTimer()  // Start tracking time

            debugMessage = "Playing audio"
        }
        isPlaying.toggle()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            guard let player = audioPlayer else { return }
            self.currentTime = player.currentTime  // Update the current playback time
        }
    }

    // Format time to "minutes:seconds"
    func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func skipForward() {
        guard let player = audioPlayer else {
            debugMessage = "Audio player not available for skipping."
            return
        }
        let currentTime = player.currentTime
        let newTime = currentTime + skipTime
        player.currentTime = newTime < player.duration ? newTime : player.duration
        debugMessage = "Skipped forward"
    }

    func skipBack() {
        guard let player = audioPlayer else {
            debugMessage = "Audio player not available for skipping."
            return
        }
        let currentTime = player.currentTime
        let newTime = currentTime - skipTime
        player.currentTime = newTime > 0 ? newTime : 0
        debugMessage = "Skipped back"
    }
    
    func startMetering() {
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                guard let player = audioPlayer else { return }
                
                player.updateMeters()  // Update the metering values
                
                var levels: [CGFloat] = []
                let numberOfBars = audioLevels.count

                for i in 0..<numberOfBars {
                    // Get the current decibel value for the left channel
                    let decibels = player.averagePower(forChannel: 0)
                    let level = normalizedPowerLevel(fromDecibels: decibels)
                    levels.append(level)
                }
                
                self.audioLevels = levels
            }
        }

        // Convert decibel levels to a more visually friendly scale
        func normalizedPowerLevel(fromDecibels decibels: Float) -> CGFloat {
            if decibels < -80 {
                return 10
            } else {
                let normalizedValue = CGFloat(decibels + 80) / 2
                return max(CGFloat(normalizedValue), 10)  // Minimum bar height of 10
            }
        }

    func formatLargeNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1

        if number >= 1_000_000_000 {
            return formatter.string(from: NSNumber(value: Double(number) / 1_000_000_000))! + "b"
        } else if number >= 1_000_000 {
            return formatter.string(from: NSNumber(value: Double(number) / 1_000_000))! + "m"
        } else if number >= 1_000 {
            return formatter.string(from: NSNumber(value: Double(number) / 1_000))! + "k"
        } else {
            return "\(number)"
        }
    }

    private func updateButtonColors() {
        if navigation.showingLibrary() {
            homeButtonColor = lightModeController.getForegroundColor()
            exploreButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingExplore() {
            exploreButtonColor = lightModeController.getForegroundColor()
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingReader() {
            button3Color = lightModeController.getForegroundColor()
            homeButtonColor = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingFeed() {
            feedButtonColor = lightModeController.getForegroundColor()
            profileButtonColor = Color(hex: "BDBDBD")
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingProfile() {
            profileButtonColor = lightModeController.getForegroundColor()
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
        }
    }
}
       
struct MenuIcon: View {
    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 18, height: 2)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 18, height: 2)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 18, height: 2)
            
        }
        .frame(width: 22)
    }
}
        
struct SphereStudentToolbar: View {
    @EnvironmentObject var navigation: Nav
    @State private var isExploreViewActive = false
    @State private var isProfileViewActive = false
    @State private var isSearchViewActive = false
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")

    @State private var homeButtonColor: Color = Color(hex: "BDBDBD")
    @State private var exploreButtonColor: Color = Color(hex: "BDBDBD")
    @State private var button3Color: Color = Color(hex: "BDBDBD")
    @State private var feedButtonColor: Color = Color(hex: "BDBDBD")
    @State private var profileButtonColor: Color = Color(hex: "BDBDBD")
    
    var body: some View {
        HStack {
            Button(action: {
                navigation.goToLibrary()
                updateButtonColors()
            }) {
                VStack {
                    Image(systemName: "square.leftthird.inset.filled")
                        .foregroundColor(homeButtonColor)
                        .font(.system(size: 21))
                    Text("Library")
                        .foregroundColor(homeButtonColor)
                        .font(.system(size: 9))
                }
            }
            .padding(.leading)
            
            Spacer()
            
    
            Button(action: {
                navigation.goToReader()
                updateButtonColors()

            }) {
                Image(systemName: "book")
                    .foregroundColor(button3Color)
                    .font(.system(size: 24))
            }
            
            Spacer()
            
     
            Button(action: {
                navigation.goToProfile()

                updateButtonColors()
            }) {
                VStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(profileButtonColor)
                        .font(.system(size: 21))
                    Text("Profile")
                        .foregroundColor(profileButtonColor)
                        .font(.system(size: 9))
                }
            }
            .padding(.trailing)
        }
        .padding(.horizontal)
        .padding(.vertical)
        .padding(.horizontal, UIScreen.main.bounds.width * 0.24)
        .background(backgroundColor)
        .background(backgroundColor)
        .onAppear {
            updateButtonColors()
        }
        .onChange(of: navigation.showingLibrary()) { _ in updateButtonColors() }
        .onChange(of: navigation.showingExplore()) { _ in updateButtonColors() }
        .onChange(of: navigation.showingFeed()) { _ in updateButtonColors() }
        .onChange(of: navigation.showingReader()) { _ in updateButtonColors() }
        .onChange(of: navigation.showingProfile()) { _ in updateButtonColors() }
    
         }
    
    private func updateButtonColors() {
        if navigation.showingLibrary() {
            homeButtonColor = Color(.black)
            exploreButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingExplore() {
            exploreButtonColor = Color(.black)
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingReader() {
            button3Color = Color(.black)
            homeButtonColor = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            profileButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingFeed() {
            feedButtonColor = Color(.black)
            profileButtonColor = Color(hex: "BDBDBD")
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
        } else if navigation.showingProfile() {
            profileButtonColor = Color(.black)
            homeButtonColor = Color(hex: "BDBDBD")
            button3Color = Color(hex: "BDBDBD")
            feedButtonColor = Color(hex: "BDBDBD")
            exploreButtonColor = Color(hex: "BDBDBD")
        }
    }
}

struct Publication {
    var id: UUID
    var logo: String
}
class Article: Identifiable, ObservableObject, Hashable {
    var id: UUID
    var title: String
    var subtitle: String
    var author: Author
    var publication: Publication
    var readers: Int
    var cover: String
    var genre: Genre
    // change into magazine genre
    var rating: Float
    var year: String
    var discussion: Discussion
    var currentPage: Int?
    var totalPages: Int?
    var price: Double
    var body: String
    
    init(id: UUID = UUID(), title: String = "", subtitle: String = "", author: Author = Author(), publication: Publication = Publication(id: UUID(), logo: ""), readers: Int = 0, cover: String = "", genre: Genre = .unknown, rating: Float = 0.0, year: String = "2024", length: String = "", discussion: Discussion = Discussion(id: UUID(), posts: []), currentPage: Int? = nil, totalPages: Int? = nil, price: Double = 0.0, body: String = "") {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.author = author
        self.publication = publication
        self.readers = readers
        self.cover = cover
        self.genre = genre
        self.rating = rating
        self.year = year
        self.discussion = discussion
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.price = price
        self.body = body
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func addPost(post: Note) {
        self.discussion.posts.append(post)
        post.pub = true
    }
    
    func getLogo() -> String {
        return publication.logo
    }
    
    func getGenre() -> Genre {
        return genre
    }
    func getCover() -> String {
        return cover
    }
    func getTitle() -> String {
        return title
    }
    func getSubtitle() -> String {
        return subtitle
    }
}

struct ArticlePreview: View {
    var article: Article
    var width: CGFloat
    var fontSize: CGFloat = 25.0
    @Binding var showArticle: Bool
    @Binding var selectedArticle: Article
    var body: some View {
        
        VStack(alignment: .leading){
            Image(article.getCover())
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding(.vertical)
            
            HStack {
                Text(article.getTitle())
                    .font(.system(size: fontSize, weight: .medium))
                    .padding(.bottom)
                Spacer()
                
            }
            HStack {
                Image(article.getLogo())
                    .resizable()
                    .scaledToFit()
                    .frame(idealWidth: width * 0.5, maxWidth: 300, maxHeight: 15)
                
                Text("by \(article.author.name)")
                    .font(.system(size: 15))
                    .padding(.horizontal)
                Spacer()
                
            }
            
        }
        .frame(width: width)

        .onTapGesture {
            showArticle.toggle()
            selectedArticle = article
        }
    }
}
   

struct ArticleView: View {
    @Binding var isPresenting: Bool
    @Binding var article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Image(article.getLogo())
                .resizable()
                .scaledToFit()
                .frame(width: 400)
            Image(article.getCover())
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .cornerRadius(10)
            Text(article.getTitle())
                .font(.system(size: 20, weight: .medium))
            Text(article.body)
                .font(.system(size: 17))
                .lineSpacing(6)
            
        }
        .padding(.horizontal, UIScreen.main.bounds.width * 0.2)
    }
}
        
        

class HighlightKey: ObservableObject {
    // Dictionary to store highlight colors for different themes
    @Published var highlightColors: [Color: String] = [
        Color(red: 1.0, green: 0.8, blue: 0.8): "Key terms/definitions",  // Pastel Pink
        Color(red: 0.8, green: 0.6, blue: 1.0): "Main ideas/concepts",    // Pastel Purple
        Color(red: 0.7, green: 0.8, blue: 1.0): "Equations",              // Pastel Blue
        Color(red: 1.0, green: 1.0, blue: 0.8): "People/places",          // Pastel Yellow
        Color(red: 0.8, green: 1.0, blue: 0.8): "Dates",                  // Pastel Green
        Color(red: 0.9, green: 0.9, blue: 0.9): "Examples"                // Pastel Gray
    ]

    // Function to set highlight color for a theme
    func setHighlightColor(color: Color, forTheme theme: String) {
        highlightColors[color] = theme
    }
    
    // Function to get the theme for a specific color
    func getTheme(color: Color) -> String {
        return highlightColors[color] ?? "Unknown Theme"
    }

    // Function to get all highlight colors
    func getHighlightColors() -> [Color] {
          return highlightColors.keys.sorted { $0.description < $1.description }
      }
}



