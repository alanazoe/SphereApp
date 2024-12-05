//
//  ReaderView.swift
//  sphere
//
//  Created by Alana Greenaway on 5/27/24.
//

import SwiftUI
import PencilKit

class SharedData: ObservableObject {
    @Published var book = Book(title: "Seven Days in June", cover: "b3", ebook: SphereEBook(pages: [Page(text: "He didn't say any more but we've always been unusually communicative in a reserved way, and I understood that he meant a great deal more than that. In consequence <hi> I'm inclined to reserve all judgments </hi> , a habit that has opened up many curious natures to me and also made me the victim of not a few veteran bores. The abnormal mind is quick to detect and attach itself to this quality when it appears in a normal person, and so it came about that in college I was unjustly accused of being a politician, because I was privy to the secret griefs of wild, unknown men.\n\n Most of the confidences were unsought--frequently I have feigned sleep, preoccupation, or a hostile levity when I realized by some unmistakable sign that an intimate revelation was quivering on the horizon--for the intimate revelations of young men or at least the terms in which they express them are usually plagiaristic and marred by obvious suppressions. Reserving judgments is a matter of infinite hope. I am still a little afraid of missing something if I forget that, as my father snobbishly suggested, and I snobbishly repeat, <hi> a sense of the fundamental decencies is parcelled out unequally at birth. </hi> \n\n And, after boasting this way of my tolerance, I come to the admission that it has a limit. Conduct may be founded on the hard rock or the wet marshes but after a certain point I don't care what it's founded on. When I came back from the East last autumn I felt that I wanted the world to be in uniform and at a sort of moral attention forever; I wanted no more riotous excursions with privileged glimpses into the human heart. Only Gatsby, the man who gives his name to this book, was exempt from my reaction--Gatsby who represented everything for which I have an unaffected scorn. If personality is an unbroken series of successful gestures, then there was something gorgeous about him, some heightened sensitivity to the promises of life, as if he were related to one oflibr those intricate machines that register earthquakes ten thousand miles away. This responsiveness had nothing to do with that flabby impressionability which is dignified under the name of the \"creative temperament\"--it was an extraordinary gift for hope, a romantic readiness such as I have never found in any other person and which it is not likely I shall ever find again. No--Gatsby turned out all right at the end; it is what preyed on Gatsby, what foul dust floated in the wake of his dreams that temporarily closed out my interest in the abortive sorrows and short-winded elations of men. \n\n He didn't say any more but we've always been unusually communicative in a reserved way, and I understood that he meant a great deal more than that. In consequence <hi> I'm inclined to reserve all judgments </hi> , a habit that has opened up many curious natures to me and also made me the victim of not a few veteran bores. The abnormal mind is quick to detect and attach itself to this quality when it appears in a normal person, and so it came about that in college I was unjustly accused of being a politician, because I was privy to the secret griefs of wild, unknown men."),
        Page(text:"Most of the confidences were unsought--frequently I have feigned sleep, preoccupation, or a hostile levity when I realized by some unmistakable sign that an intimate revelation was quivering on the horizon--for the intimate revelations of young men or at least the terms in which they express them are usually plagiaristic and marred by obvious suppressions. Reserving judgments is a matter of infinite hope. I am still a little afraid of missing something if I forget that, as my father snobbishly suggested, and I snobbishly repeat, <hi> a sense of the fundamental decencies is parcelled out unequally at birth. </hi>"),
                                                    Page(text: "And, after boasting this way of my tolerance, I come to the admission that it has a limit. Conduct may be founded on the hard rock or the wet marshes but after a certain point I don't care what it's founded on. When I came back from the East last autumn I felt that I wanted the world to be in uniform and at a sort of moral attention forever; I wanted no more riotous excursions with privileged glimpses into the human heart. Only Gatsby, the man who gives his name to this book, was exempt from my reaction--Gatsby who represented everything for which I have an unaffected scorn. If personality is an unbroken series of successful gestures, then there was something gorgeous about him, some heightened sensitivity to the promises of life, as if he were related to one of those intricate machines that register earthquakes ten thousand miles away. This responsiveness had nothing to do with that flabby impressionability which is dignified under the name of the \"creative temperament\"--it was an extraordinary gift for hope, a romantic readiness such as I have never found in any other person and which it is not likely I shall ever find again. No--Gatsby turned out all right at the end; it is what preyed on Gatsby, what foul dust floated in the wake of his dreams that temporarily closed out my interest in the abortive sorrows and short-winded elations of men."), Page(text: "He didn't say any more but we've always been unusually communicative in a reserved way, and I understood that he meant a great deal more than that. In consequence <hi> I'm inclined to reserve all judgments </hi> , a habit that has opened up many curious natures to me and also made me the victim of not a few veteran bores. The abnormal mind is quick to detect and attach itself to this quality when it appears in a normal person, and so it came about that in college I was unjustly accused of being a politician, because I was privy to the secret griefs of wild, unknown men."),
                                                                                       Page(text:"Most of the confidences were unsought--frequently I have feigned sleep, preoccupation, or a hostile levity when I realized by some unmistakable sign that an intimate revelation was quivering on the horizon--for the intimate revelations of young men or at least the terms in which they express them are usually plagiaristic and marred by obvious suppressions. Reserving judgments is a matter of infinite hope. I am still a little afraid of missing something if I forget that, as my father snobbishly suggested, and I snobbishly repeat, <hi> a sense of the fundamental decencies is parcelled out unequally at birth. </hi>"),
                                                                                                                                   Page(text: "And, after boasting this way of my tolerance, I come to the admission that it has a limit. Conduct may be founded on the hard rock or the wet marshes but after a certain point I don't care what it's founded on. When I came back from the East last autumn I felt that I wanted the world to be in uniform and at a sort of moral attention forever; I wanted no more riotous excursions with privileged glimpses into the human heart. Only Gatsby, the man who gives his name to this book, was exempt from my reaction--Gatsby who represented everything for which I have an unaffected scorn. If personality is an unbroken series of successful gestures, then there was something gorgeous about him, some heightened sensitivity to the promises of life, as if he were related to one of those intricate machines that register earthquakes ten thousand miles away. This responsiveness had nothing to do with that flabby impressionability which is dignified under the name of the \"creative temperament\"--it was an extraordinary gift for hope, a romantic readiness such as I have never found in any other person and which it is not likely I shall ever find again. No--Gatsby turned out all right at the end; it is what preyed on Gatsby, what foul dust floated in the wake of his dreams that temporarily closed out my interest in the abortive sorrows and short-winded elations of men.")
                                                                                                                                  ]))
    
}

class SphereEBook: Identifiable, Hashable, ObservableObject {
    @Published var id: UUID
    @Published var pages: [Page]
    //@Published var book: Book
    @Published var currentPage: Int
    
    
    
    init(id: UUID = UUID(), pages: [Page] = [], comments: [[Comment]] = [], currentPage: Int = 0) {
        self.id = id
        self.pages = pages
       // self.book = book
        self.currentPage = currentPage
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: SphereEBook, rhs: SphereEBook) -> Bool {
        lhs.id == rhs.id
    }
    
    func nextPage(){
        if currentPage < getPageCount() - 1 {
            currentPage += 1
        }
    }
    
    
    func getPageCount() -> Int {
        
        if pages.count > 0 {
            return pages.count
        } else {
            return 1
        }
    }
    
    func prevPage(){
        if currentPage > 0 {
            currentPage -= 1
        }
    }
    
    func getCurrentPage() -> Int {
        return currentPage
    }
    
}

class Page: Identifiable, Hashable, ObservableObject {
    @Published var id: UUID
    @Published var text: String
    @Published var chapter: Int
    @Published var comments: [Comment]
    @Published var notes: [Note]
    @Published var reactions: [Reaction]
    @Published var reactionMap: [UUID: [ReactionType]]
    
    init(id: UUID = UUID(), text: String, chapter: Int = 1, comments: [Comment] = [], notes: [Note] = [], reactionMap: [UUID: [ReactionType]] = [:]) {
        self.id = id
        self.text = text
        self.chapter = chapter
        self.comments = comments
        self.notes = notes
        self.reactions = ReactionType.allCases.map { Reaction(type: $0, count: 0) }
        self.reactionMap = reactionMap
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Page, rhs: Page) -> Bool {
        lhs.id == rhs.id
    }
    
    func addComment(index: Int, comment: Comment) {
        comments.append(comment)
    }
    
    func addNote(note: Note){
        notes.append(note)
    }
    
    func addReaction(type: ReactionType, userId: UUID) {
        if let index = reactions.firstIndex(where: { $0.type == type }) {
            reactions[index].count += 1
        }
        mapReaction(userId: userId, type: type)
    }
    
    func removeReaction(type: ReactionType, userId: UUID) {
        if let index = reactions.firstIndex(where: { $0.type == type }) {
            reactions[index].count -= 1
        }
        unMapReaction(userId: userId, type: type)
    }
    
    private func mapReaction(userId: UUID, type: ReactionType){
        if let reaction = reactionMap[userId] {
            reactionMap[userId]?.append(type)
        } else {
            reactionMap[userId] = [type]
        }
    }
    
    private func unMapReaction(userId: UUID, type: ReactionType){
        if let reaction = reactionMap[userId] {
            reactionMap[userId]?.removeAll { $0 == type }
        }
    }
    
    func getReactionsByUserId(userId: UUID) -> [ReactionType]{
        return reactionMap[userId] ?? []
    }
    
    
    func getChapter() -> Int {
        return chapter
    }
}

func generateSphereEBook(from fileName: String) -> SphereEBook? {
    guard let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") else {
        print("File not found")
        return nil
    }
    
    do {
        // Read the content of the file
        let content = try String(contentsOfFile: filePath, encoding: .utf8)
        
        // Split the content into chunks of 3000 characters
        let chunkSize = 3000
        var pages: [Page] = []
        var chapter = 1
        var startIndex = content.startIndex
        
        while startIndex < content.endIndex {
            var endIndex = content.index(startIndex, offsetBy: chunkSize, limitedBy: content.endIndex) ?? content.endIndex
            while startIndex < content.endIndex && (content[startIndex] == " " || content[startIndex] == "\n") {
                startIndex = content.index(after: startIndex)
            }
            while endIndex < content.endIndex && (content[endIndex] != " " && content[endIndex] != "\n") {
                endIndex = content.index(after: endIndex)
            }
            
            let textChunk = String(content[startIndex..<endIndex])
            
            // Create a new Page object and add it to the pages array
            let page = Page(text: textChunk, chapter: chapter)
            pages.append(page)
            
            // Update the start index for the next chunk
            startIndex = endIndex
            
            // Optionally update the chapter if needed
            // chapter += 1
        }
        
        // Create and return a new SphereEBook object
        return SphereEBook(pages: pages)
        
    } catch {
        print("Error reading the file: \(error.localizedDescription)")
        return nil
    }
}

class Chapter: Identifiable, Hashable, ObservableObject {
    @Published var id: UUID
    @Published var number: Int
    @Published var pages: [Page]
    @Published var summary: ChapterSummary
    
    init(id: UUID = UUID(), number: Int = 1, pages: [Page] = [], summary: ChapterSummary = ChapterSummary()) {
        self.id = id
        self.number = number
        self.pages = pages
        self.summary = summary
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Chapter, rhs: Chapter) -> Bool {
        lhs.id == rhs.id
    }
    

}

struct ReactionView: View {
    @ObservedObject var ebook: SphereEBook
    @State var index: Int
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        HStack {
            
            ForEach(ebook.pages[index].reactions) { reaction in
                if reaction.count > 0 {
                        HStack{
                            Text(reaction.type.rawValue)
                                .font(.system(size:17))
                                .padding(.trailing, -4)
                            Text("\(reaction.count)")
                                .font(.system(size:15))
                                .foregroundColor(lightModeController.getForegroundColor())
                        }
                        .padding(3)
                        .padding(.horizontal, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                                .foregroundColor( lightModeController.getForegroundColor().opacity(0.1))
                        )

                        
                    
                    
                    .padding(.horizontal, 4)
                }
            }
        }
    
       }

       private func addReaction(_ type: ReactionType) {
           ebook.pages[index].addReaction(type: type, userId: userData.user.id)
       }
}

struct ReactionButtons: View {
    @ObservedObject var ebook: SphereEBook
    @State var index: Int
    @EnvironmentObject var userData: UserData

    var body: some View {
        var reactionTypes = ebook.pages[index].getReactionsByUserId(userId: userData.user.id)
        ScrollView(.horizontal){
            HStack(spacing: 10) {
                ForEach(ebook.pages[index].reactions) { reaction in
                    
                    var alreadyReacted = reactionTypes.contains(reaction.type)
                    
                    Button(action: {
                        if alreadyReacted {
                            removeReaction(type: reaction.type)
                        } else {
                            addReaction(reaction.type)
                        }
                    }) {
                        HStack{
                            Text(reaction.type.rawValue)
                                .font(.system(size:19))
                            
                        }
                        
                    }
                    .padding(3)
                    .padding(.horizontal, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.black.opacity(0.4), lineWidth: 0.6)
                            .fill(alreadyReacted ? Color(.blue).opacity(0.2) : Color(.gray).opacity(0.1))
                        
                    )
                }
            }
           // .padding(.vertical)
        }
        .scrollIndicators(.hidden)
    
       }

    private func addReaction(_ type: ReactionType) {
        
        ebook.pages[index].addReaction(type: type, userId: userData.user.id)
       }
    
    private func removeReaction(type: ReactionType) {
        ebook.pages[index].removeReaction(type: type, userId: userData.user.id)

    }
}

struct ReaderView: View {
    @ObservedObject var book: Book
    @Binding var showToolbar: Bool

    @State var foregroundColor = Color(.black)
    @State var isShareQuotePresented: Bool = false
    @State var sharedQuote: String = ""
    @State var createQuotePost = false
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var showComments = false
    @State var selectedIndex: Int = 0
    @State var selectedText: String = ""
    @State var isVisible = false
    @State var fontSize = 0.0
    @State var audioModeOn = false
    @State var showNotes = false
    @State var showNote = false
    @State var selectedNote: Note = Note()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var showHighlightKey = false
    @State var showHighlightColors = false
    @State var showAllNotes = false
    @EnvironmentObject var userData: UserData
    @State var selectedColor = Color(.yellow)
    @State var index: Int = 0
    @State var start: Int = 0
    @State var end: Int = 0
    @State var isHighlightingActive = false
    @State var selectedChapterIndex: Int = 0
    @State var fullScreen = false
@State var sharePage = false
    var body: some View {
        iPadReaderView(book: book, showToolbar: $showToolbar)
        
    }

    func heightForText(_ text: String, fontSize: CGFloat, width: CGFloat, lineSpacing: CGFloat) -> CGFloat {
        let textView = UITextView()
        textView.text = text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: fontSize)
        ]

        textView.attributedText = NSAttributedString(string: text, attributes: attributes)
        let size = textView.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
}

struct CreateChapterSummary: View {
    @State var text: String
    var body: some View {
        VStack {
            Text("Chapter Summary")
            Text("Frequent highlights")
            //NoteTextEditor(text: $text, placeholder: "What was this chapter about?")
        }
    }
}
struct HighlightKeyButton: View {
    @Binding var isPresenting: Bool
    var body: some View {
        Button(action: {
            isPresenting.toggle()
        }){
            HStack {
                Circle()
                    .foregroundColor(.yellow.opacity(0.4))
                    .frame(width: 20)
                Text("Key")
                    .font(.system(size: 15))

                    .foregroundColor(.black)
                    .padding(.leading, -1)
                
            }
            .padding()

        }
    }
}
struct AllNotesButton: View {
    @Binding var isPresenting: Bool

    var body: some View {
        Button(action: {
            isPresenting.toggle()
        }){
            HStack {
         
                Text("32 notes")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
            }
            .padding()

        }
    }
}

struct iPadReaderView: View {
    @ObservedObject var book: Book
    @EnvironmentObject var userData: UserData
    @Binding var showToolbar: Bool
    @State var isShareQuotePresented: Bool = false
    @State var sharedQuote: String = ""
    @State var createQuotePost = false
    @State var showComments = false
    @State var selectedIndex: Int = 0
    @State var selectedText: String = ""
    @State var isVisible = false
    @State var fontSize = 0.0
    @State var audioModeOn = false
    @State var showNotes = false
    @State var showNote = false
    @State var selectedNote: Note = Note()
    @State var showHighlightKey = false
    @State var showHighlightColors = false
    @State var showAllNotes = false
    @State var selectedColor = Color(.yellow)
    @State var index: Int = 0
    @State var start: Int = 0
    @State var end: Int = 0
    @State var isHighlightingActive = false
    @State var selectedChapterIndex = 0
    @State var showSplitScreen: Bool = false
    @State var markPage = false
    @State var selectedChapter = 0
    @State var currentPage = 0
    @State var sharePage = false
    @State var selectBook = false
    @State var selectedBook: Book? = nil
    @State var canvasView = CustomCanvasView()
    @State private var scrollToTop: Bool = false // Trigger to scroll to top
    @State private var timer: Timer? // Timer for continuous scrolling
    @State private var scrollOffset: CGFloat = 0 // Scroll offset for ScrollView
    @State var editFormat = false
    @EnvironmentObject var navigation: Nav
    @EnvironmentObject var lightModeController: LightModeController
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        ZStack {
            GeometryReader { geometry in
            
            let isLandscape = geometry.size.width > geometry.size.height
                
            VStack {
                
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack {
                            ZStack {
                                VStack(alignment: .leading, spacing: 16) {
                                    let processedBook = userData.user.applyAnnotationsToBook(book: book)
                                    
                                    CustomTextViewRepresentable(
                                        text: .constant(processedBook.ebook.pages[currentPage].text),
                                        fontSize: 20 + fontSize,
                                        foregroundColor: UIColor(lightModeController.getForegroundColor()),
                                        lineSpacing: 13,
                                        highlightColor: .purple.withAlphaComponent(0.15),
                                        highlightedTextColor: .black,
                                        onShare: { quote in
                                            sharedQuote = quote
                                            if !sharedQuote.isEmpty {
                                                isShareQuotePresented = true
                                            }
                                        },
                                        onComment: { quote in
                                            selectedIndex = selectedChapter
                                            selectedText = quote
                                            showComments = true
                                        },
                                        onHighlight: { (start, end) in
                                            isHighlightingActive = true
                                            showHighlightColors = true
                                            self.selectedChapterIndex = selectedChapter
                                            self.index = currentPage
                                            self.start = start
                                            self.end = end
                                        }
                                    )
                                    .frame(width: min(750, UIScreen.main.bounds.width * 0.90), height: heightForText(processedBook.ebook.pages[currentPage].text, fontSize: 20 + fontSize, width: min(750, UIScreen.main.bounds.width * 0.90) * 1.1, lineSpacing: 13))
                                    
                                    HStack {
                                        Text("\(book.ebook.pages[currentPage].notes.count) notes")
                                            .font(.system(size: 13))
                                            .opacity(0.7)
                                            .padding(.trailing)
                                        CommentButton(index: currentPage, showComments: $showComments, selectedIndex: $selectedIndex, ebook: book.ebook)
                                        Spacer()
                                        
                                        Text("\(processedBook.ebook.getCurrentPage() + 1)")
                                            .font(.system(size: 15, weight: .medium))
                                    }
                                    .foregroundColor(lightModeController.getForegroundColor())
                                    .frame(width: min(750, UIScreen.main.bounds.width * 0.90))
                                }
                                
                                .padding(.horizontal, 100)
                                .padding(.top, isLandscape && iPadOrientation ? 100 : iPadOrientation ? 80 : 10)
                                .padding(.bottom, isLandscape ? 100 : 100)


                                //.padding(.top, 30)
                                .id("top") // Add an ID for the top of the content
                                .overlay(
                                    Group {
                                        if markPage {
                                            MarkupView(isPresenting: .constant(true), canvasView: $canvasView)
                                        }
                                    }
                                )
                                .background(
                                        Group {
                                            if !markPage && iPadOrientation {
                                                Rectangle()
                                                    .ignoresSafeArea()
                                                    .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#1a1a1a").opacity(0.7) : Color(hex: "#EFE9D7").opacity(0.4))
                                                
                                            } else if iPadOrientation {
                                                ZStack {
                                                    Rectangle()
                                                        .ignoresSafeArea()
                                                        .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#1a1a1a").opacity(0.7) : Color(hex: "#EFE9D7").opacity(0.4))
                                                    MarkupView(isPresenting: .constant(true), canvasView: $canvasView)
                                                }
                                            } else {
                                                VStack{
                                                    Spacer()
                                                }
                                            }
                                        }
                                    
                                       
                                    
                                )
                                .padding(.top, isLandscape ? 12 : 0)
                                .padding(.horizontal, UIScreen.main.bounds.width * 0.10)
                                // off when vertical .padding(.top, 80)
                              
                            }
                            .background(lightModeController.isDarkMode() && iPadOrientation ? lightModeController.getAccentColor() : iPadOrientation ? lightModeController.getBackgroundColor() : lightModeController.isDarkMode() && !iPadOrientation ? Color(hex: "#141414") : Color(hex: "#f1eddc"))
                            .onChange(of: currentPage) { _ in
                                scrollToTop.toggle() // Trigger scroll to top
                            }
                            .onChange(of: scrollToTop) { _ in
                                proxy.scrollTo("top", anchor: .top) // Scroll to the top without animation
                            }
                        }
                        .sheet(isPresented: $isShareQuotePresented){
                            ShareQuotePreview(isPresenting: $isShareQuotePresented, quote: $sharedQuote, book: book)
                        }
                        
                    }
                    
                    
                    .frame(width: UIScreen.main.bounds.width)
                    .scrollIndicators(.hidden)
              
                    .overlay(
                        VStack{
                            Spacer()
                            HStack {
                                Button(action: {
                                    book.ebook.prevPage()
                                    currentPage = book.ebook.getCurrentPage()
                                }){
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width * 0.10, height: UIScreen.main.bounds.height)
                                        .foregroundColor(lightModeController.getBackgroundColor())
                                        .opacity(0.01)
                                        /*
                                        .overlay(
                                            Image(systemName: "arrow.left")
                                                .padding()
                                                .padding()
                                                .opacity(0.2)
                                        )
                                  */
                                    
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    book.ebook.nextPage()
                                    currentPage = book.ebook.getCurrentPage()
                                }){
                                    Rectangle()
                                        .frame(width: 80, height: UIScreen.main.bounds.height)
                                        .foregroundColor(lightModeController.getBackgroundColor())
                                        .opacity(0.01)
                                    /*
                                        .overlay(
                                            Image(systemName: "arrow.right")
                                                .padding()
                                                .padding()
                                                .opacity(0.2)
                                        )
                                     */
                                    
                                }
                             
                            }
                            Spacer()
                        }
                    )
                  
                    .onAppear {
                        //isVisible = true // Set boolean to true when view appears
                        showToolbar = false
                        currentPage = book.ebook.getCurrentPage()
                        // Use a timer to set boolean to false after 3 seconds
                        /*Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
                         isVisible = false
                         showToolbar = false
                         
                         }*/
                    }
            
                    .onTapGesture {
                        isVisible.toggle()
                        editFormat = false
                    }
                    .sheet(isPresented: $showComments) {
                        CommentsView( chapterIndex: selectedChapterIndex, index: $currentPage, isPresenting: $showComments, book: book, initialCommentText: $selectedText)
                            .presentationDetents([.fraction(0.9)])
                    }
                    .sheet(isPresented: $showNotes) {
                        NotesView(isPresenting: $showNotes, showToolbar: $showToolbar, notes: book.ebook.pages[selectedIndex].notes, paragraph: book.ebook.pages[selectedIndex].text, showNote: $showNote, selectedNote: $selectedNote)
                            .presentationDetents([.fraction(0.9)])
                    }
                    .sheet(isPresented: $showAllNotes) {
                        ListNotes(addNew: .constant(false), notes: userData.user.getAllNotes(), showNote: $showNote, selectedNote: $selectedNote)
                        
                        // AllNotesView(isPresenting: $showAllNotes, showToolbar: $showToolbar, addNew: .constant(false), notes: userData.user.getAllNotes(), book: book, showNote: $showNote, selectedNote: $selectedNote)
                        // .presentationDetents([.fraction(0.9)])
                    }
                    .sheet(isPresented: $sharePage){
                        SharePageView(isPresenting: $sharePage, note: .constant(Note()))
                    }
                    .sheet(isPresented: $selectBook){
                        SelectBook(isPresenting: $selectBook, selected: $selectedBook) { book in
                            
                        }
                    }

                }
                
            }
            .background(iPadOrientation ? lightModeController.getBackgroundColor() : lightModeController.isDarkMode() && !iPadOrientation ? Color(hex: "#141414") : Color(hex: "#f1eddc"))

                if editFormat {
                   
                    VStack(alignment: .leading) {
                        HStack {
                            FormatPopup(isPresenting: $editFormat, fontSize: $fontSize)
                                .frame(width: 350)
                                .cornerRadius(7)
                                .shadow(radius: 0.5)
                                .padding(.top, 75)
                            Spacer()
                            
                        }
                        
                    }
                }
        }
            
            if showSplitScreen {
               // ReadNotesSplit(isPresenting: $showSplitScreen, showToolbar: $showToolbar)
            }
            
            if showHighlightKey {
                HighlightKeyView(isPresenting: $showHighlightKey)
            }
           
            
            if showHighlightColors {
                HighlightColorPicker(isPresenting: $showHighlightColors, showKey: $showHighlightKey, chapterIndex: selectedChapterIndex, index: index, start: start, end: end, isHighlightingActive: $isHighlightingActive)
            }
           
                
                
            
        }
       
        .overlay(
            VStack{
                if isVisible {
                    ReaderiPadToolbarView(index: book.ebook.getCurrentPage(), showComments: $showComments, selectedIndex: $selectedIndex, ebook: book.ebook)
                }
            }
        )
        .onDisappear{
            showToolbar = true
        }
    }

    func heightForText(_ text: String, fontSize: CGFloat, width: CGFloat, lineSpacing: CGFloat) -> CGFloat {
        let textView = UITextView()
        textView.text = text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: fontSize)
        ]

        textView.attributedText = NSAttributedString(string: text, attributes: attributes)
        let size = textView.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
    
    func switchMode(){
        
    }
}


struct HighlightColorPicker: View {
    @Binding var isPresenting: Bool
    @ObservedObject var highlightKey = HighlightKey()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State private var dragOffset = CGSize.zero
    @State private var lastPosition = CGSize.zero
    @State private var currentScale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @Binding var showKey: Bool
    @State var chapterIndex: Int
    @State var index: Int
    @State var start: Int
    @State var end: Int
    @Binding var isHighlightingActive: Bool
    @EnvironmentObject var sharedData: SharedData
    @EnvironmentObject var userData: UserData
    @State var book = Book()
    var body: some View {
        HStack(alignment: .center) {
            ForEach(highlightKey.getHighlightColors(), id: \.self) { color in
                HStack {
                    Button(action: {
                        userData.user.addHighlight(bookid: book.id, chapterNumber: chapterIndex, paragraphNumber: index, start: start, end: end, color: color)
                        //userData.user.notifyHighlightsUpdated()
                        isPresenting = false
                        isHighlightingActive = false
                    }) {
                        Circle()
                            .fill(color)
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(.trailing, 2)
            }
            Button(action: {
                showKey = true
            }){
                Text("Key")
                    .font(.system(size: 14))
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.3)
        .padding()
        .background(backgroundColor)
    }
}



struct SharePageView: View {
    @EnvironmentObject var userData: UserData
    @State private var text: String = ""
    @Binding var isPresenting: Bool
    @State private var generalAccess: GeneralAccess = .restricted
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Text("Share")
                    .font(.system(size: 18))
                    .padding(.top, 16)
                Spacer()
            }
            .padding(.bottom)
            TextField("Add people", text: $text)
                .padding()
                .background(Color(hex: "#EFEBE0"))
                .cornerRadius(8)
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("People with access")
                    .font(.headline)
                
                HStack {
                    ProfileThumbnail(image: userData.user.photo, size: 30)
                    VStack(alignment: .leading) {
                        Text("\(userData.user.name) (you)")
                        Text(userData.user.handle)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    Spacer()
                    Text("OWNER")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .padding(.vertical, 8)
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("General access")
                    .font(.headline)
                    .padding(.bottom)
                
                if note.isPublished(){
                    Text("Public")
                        .foregroundColor(.blue)
                    Text("Anyone on Sphere can see this note")
                        .font(.caption)

                    
                } else {
                    Text("Private")
                        .foregroundColor(.blue)

                    Text("Only you can see this. Publish to make public")
                        .font(.caption)

                }
                
                
                Text("Citation")
                    .padding(.top)
                
            }
            Spacer()

            HStack {
                Button(action: {
                    // Copy link action
                }) {
                    HStack {
                        Image(systemName: "link")
                        Text("Copy link")
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                Button(action: {
                    // Download
                }) {
                    HStack {
                        //Image(systemName: "link")
                        Text("Download")
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                if note.isPublished() {
                    Button(action: {
                        makePrivate()
                        isPresenting.toggle()

                    }) {
                        HStack {
                            //Image(systemName: "link")
                            Text("Private")
                        }
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                } else {
                    Button(action: {
                        publish()
                        isPresenting.toggle()
                    }) {
                        HStack {
                            //Image(systemName: "link")
                            Text("Publish")
                        }
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                
                Spacer()
                Button(action: {
                    // Done action
                }) {
                    Text("Done")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.bottom, 16)
            
        }
        .padding()
        .cornerRadius(16)
        //.shadow(radius: 5)
        .padding(.horizontal, 16)
        .background(backgroundColor)
        


    }
    func publish(){
        note.book.addPost(post: note)
    }
    
    func makePrivate(){
       // note.book.removePost(post)
    }
}

enum GeneralAccess: String, CaseIterable, Identifiable {
    case restricted, anyoneWithLink
    
    var id: String { self.rawValue }
    
    var iconName: String {
        switch self {
        case .restricted: return "lock.circle.fill"
        case .anyoneWithLink: return "link.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .restricted: return "Restricted"
        case .anyoneWithLink: return "Anyone with the link"
        }
    }
    
    var description: String {
        switch self {
        case .restricted: return "Only people with access can open with the link"
        case .anyoneWithLink: return "Anyone on the internet with the link can view"
        }
    }
}




struct HighlightKeyView: View {
    @Binding var isPresenting: Bool
    @ObservedObject var highlightKey = HighlightKey()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State private var dragOffset = CGSize.zero
    @State private var lastPosition = CGSize.zero
    @State private var currentScale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: {
                    isPresenting.toggle()
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                        .opacity(0.7)
                }
            }
            Text("Key")
                .font(.system(size: 18))
            
            Divider()
            
            ForEach(highlightKey.getHighlightColors(), id: \.self) { color in
                HStack {
                    Rectangle()
                        .fill(color)
                        .frame(width: 30, height: 10)
                        .cornerRadius(2)
                    Text(highlightKey.getTheme(color: color))
                        .font(.system(size: 15))
                }
                .padding(.bottom, 2)
            }
            HStack {
                Spacer()
                Text("EDIT")
                    .font(.system(size: 12))
                    .opacity(0.7)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.3)
        .padding()
        .background(Color(hex: "#F6F2E7"))
        .cornerRadius(20)
        .offset(x: dragOffset.width + lastPosition.width, y: dragOffset.height + lastPosition.height)
        .scaleEffect(currentScale * lastScale)
        .gesture(
            DragGesture()
                .onChanged { value in
                    let newWidth = lastPosition.width + value.translation.width
                    let newHeight = lastPosition.height + value.translation.height
                    
                    if newWidth > UIScreen.main.bounds.width / 2 {
                        dragOffset.width = UIScreen.main.bounds.width / 2 - lastPosition.width
                    } else if newWidth < -UIScreen.main.bounds.width / 2 {
                        dragOffset.width = -UIScreen.main.bounds.width / 2 - lastPosition.width
                    } else {
                        dragOffset.width = value.translation.width
                    }

                    if newHeight > UIScreen.main.bounds.height / 2 {
                        dragOffset.height = UIScreen.main.bounds.height / 2 - lastPosition.height
                    } else if newHeight < -UIScreen.main.bounds.height / 2 {
                        dragOffset.height = -UIScreen.main.bounds.height / 2 - lastPosition.height
                    } else {
                        dragOffset.height = value.translation.height
                    }
                }
                .onEnded { value in
                    lastPosition.width += dragOffset.width
                    lastPosition.height += dragOffset.height

                    if lastPosition.width > UIScreen.main.bounds.width / 2 {
                        lastPosition.width = UIScreen.main.bounds.width / 2
                    } else if lastPosition.width < -UIScreen.main.bounds.width / 2 {
                        lastPosition.width = -UIScreen.main.bounds.width / 2
                    }

                    if lastPosition.height > UIScreen.main.bounds.height / 2 {
                        lastPosition.height = UIScreen.main.bounds.height / 2
                    } else if lastPosition.height < -UIScreen.main.bounds.height / 2 {
                        lastPosition.height = -UIScreen.main.bounds.height / 2
                    }

                    dragOffset = .zero
                }
        )


        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    currentScale = value
                }
                .onEnded { value in
                    lastScale *= value
                    currentScale = 1.0
                }
        )
    }
}

struct CommonThemeView: View {
    @ObservedObject var highlightKey = HighlightKey()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State private var dragOffset = CGSize.zero
    @State private var lastPosition = CGSize.zero
    @State private var currentScale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Common Themes: ")
                .font(.system(size: 15))
            
            
            ForEach(highlightKey.getHighlightColors(), id: \.self) { color in
                HStack {
                    Circle()
                        .fill(color)
                        .frame(width: 10, height: 10)
                    Text(highlightKey.getTheme(color: color))
                        .font(.system(size: 14))
                    

                    Text("3 quotes")
                        .font(.system(size: 12, weight: .medium))
                        .padding(.leading, -2)

                }
                .padding(.bottom, 2)
            }

        }
        
        
    }
}


struct AllNotesView: View {
    @Binding var isPresenting: Bool
    @Binding var showToolbar: Bool
    @Binding var addNew: Bool
    @EnvironmentObject var userData: UserData
    var notes: [Note]
    var book: Book
    @Binding var showNote: Bool
    @Binding var selectedNote: Note
    @State var showBook = false
    @State var selectedBook = Book()
    @State var showPostActions = false
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var selectedChapter: Int? = nil
    @State var showCharacters = false
    @State var showTerms = false
    @State var showImages = false
    @State var showQuotes = false
    @State var searching = false
    @State var pickable = false
    @Binding var showCharacter: Bool
    @Binding var selectedCharacter: Character?
    
    var groupedNotes: [Int: [Note]] {
        Dictionary(grouping: notes, by: { $0.chapterparagraph.0 })
    }

    var body: some View {
        ZStack {
            VStack() {
                
                
                
                HStack {
                    /*
                    if pickable{
                        
                        //Picker(selection: $selection){
                            Text("\(book.title)")
                                .font(.system(size: 17, weight: .medium))
                        //}
                    } else {
                        Text("\(book.title)")
                            .font(.system(size: 19, weight: .medium))
                    } */
                    
                    
                    Spacer()
                    
                    if pickable {
                        Button(action: {
                            addNew.toggle()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .medium))
                                .padding(.vertical)
                                .padding(.trailing)
                        }
                    }
                    /*
                    Menu {
                        Button(action: {
                            showCharacters.toggle()
                        }){
                            Image(systemName: "person.crop.square")
                        }
                        Button(action: {
                            showQuotes.toggle()
                        }){
                            Image(systemName: "text.quote")
                        }
                        Button(action: {
                            showTerms.toggle()
                        }){
                            Image(systemName: "character.book.closed")
                        }
                        
                        Button(action: {
                            showImages.toggle()
                        }){
                            Image(systemName: "photo")
                        }
                        
                        
                        
                    } label: {
                        // Cover image for the dropdown menu
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color(.gray).opacity(0.2))
                            )
                        
                        
                    }
                    .padding(.trailing) */
                    if !searching {
                        Button(action: {
                            searching = true
                        }){
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 16))
                        }
                    }
                }
                .padding()
                HStack {
                    Spacer()
                    Image(book.cover)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .shadow(radius: 0.5)
                        .padding(.bottom)
                        .onTapGesture{
                            //showBook.toggle()
                        }
                    Spacer()
                }
                .padding(.top, UIScreen.main.bounds.height * 0.04)
                .padding(.bottom)

                if searching {
                    SearchNotesBar(isPresenting: $searching, book: book, showToolbar: $showToolbar, showCharacters: $showCharacters, showQuotes: $showQuotes)
                    
                    
                } else {
                    /*
                    HStack(spacing: 25){
                        
                        HStack {
                            Button(action: {
                                showCharacters.toggle()
                                showQuotes = false
                                showTerms = false

                            }){
                                HStack {
                                    Image(systemName: "person.crop.square")
                                    Text("Characters")
                                }
                                .foregroundColor(.black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(showCharacters ? Color(hex: "#ECE8DA") : Color(.clear))
                                    
                                )
                                
                            }
                        }
                            
                        Button(action: {
                            showQuotes.toggle()
                            showTerms = false
                            showCharacters = false

                        }){
                            HStack {
                                Image(systemName: "text.quote")
                                Text("Quotes")
                            }
                            .foregroundColor(.black)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(showQuotes ? Color(hex: "#ECE8DA") : Color(.clear))
                                
                            )
                        }
                        Button(action:{
                            showTerms.toggle()
                            showQuotes = false
                            showCharacters = false

                        }){
                            HStack {
                                Image(systemName: "character.book.closed")
                                Text("Terms")
                            }
                            .foregroundColor(.black)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor( showTerms ? Color(hex: "#ECE8DA") :Color(.clear))
                                
                            )
                        }

                        HStack {
                            Image(systemName: "photo")
                            Text("Photos")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor( Color(.clear))
                            
                        )


                        Spacer()
                    }
                    .font(.system(size: 13.5))
                    .padding(.vertical, 2)
                    .padding(.leading, 9)*/
                    HStack {
                        Text("Notes")
                            .font(.system(size: 15, weight: .medium))
                            .padding(.vertical)
                        Spacer()
                    }

                }
                
                if showCharacters {
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(userData.user.getAllBookCharacters(bookid: book.id)){ character in
                                
                                CharacterCard(character: .constant(character), width: 130, user: userData.user, showCharacter: $showCharacter, selectedCharacter: $selectedCharacter, onTapped: {
                                    showCharacter = true
                                    selectedCharacter = character
                                })
                                
                            }
                        }
                    }
                }
                let colors = ["#C6DEF1", "#F2C6DE", "#C9E4DE", "#FAEDCB", "#DBCDF0", "#F7D9C4"]

                
                if showTerms {
                    let allTerms = userData.user.getAllBookTerms(bookid: book.id)

                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(Array(allTerms.enumerated()), id: \.element.id) { index, term in
                                TermCard(term: term, color: colors[index % colors.count])
                                    .padding(.leading)
                            }
                        }
                    }
                }
                
                if showQuotes {

                    ScrollView(.horizontal){
                        HStack {
                            ForEach(Array(userData.user.getQuotesByBookID(bookid: book.id).enumerated()), id: \.element.id) { index, quote in
                                
                                QuoteCard(quote: quote, color: colors[index % colors.count])
                                    .padding(.leading)

                                
                            }
                        }
                    }
                }
                
                if let chapter = selectedChapter {
                    ForEach(groupedNotes[chapter]!) { note in
                        Button(action: {
                            selectedNote = note
                            showNote = true
                        }) {
                            NotePreview(note: note, showNote: $showNote, selectedNote: $selectedNote, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $showPostActions, showProfile: $showProfile, selectedProfile: $selectedProfile)
                        }
                        Divider()
                            .padding(.horizontal)
                    }
                } else {
                    ForEach(groupedNotes.keys.sorted(), id: \.self) { chapter in
                        ForEach(groupedNotes[chapter]!) { note in
                            Button(action: {
                                selectedNote = note
                                showNote = true
                            }) {
                                NotePreview(note: note, showNote: $showNote, selectedNote: $selectedNote, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $showPostActions, showProfile: $showProfile, selectedProfile: $selectedProfile)
                            }
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top)
            .background(backgroundColor)
                

            
            /*.sheet(isPresented: $showQuotes){
                AllQuotesFromBookView(isPresenting: $showQuotes, book: selectedBook)
            }*/
           /* .sheet(isPresented: $showTerms){
                AllTermsFromBookView(isPresenting: $showTerms, book: selectedBook)
            }*/
            .sheet(isPresented: $showImages){
                AllImagesFromBookView(isPresenting: $showImages, book: selectedBook)
            }
            .onChange(of: notes) { _ in
                selectedChapter = nil
            }
            
            
            /*.sheet(isPresented: $showCharacters) {
                AllCharactersView(isPresenting: $showCharacters, book: book, user: userData.user)
                    .background(backgroundColor)

            }*/
            
        }
    }
}

struct AllNotesList: View {
    @Binding var isPresenting: Bool
    @Binding var showToolbar: Bool
    @Binding var addNew: Bool
    @EnvironmentObject var userData: UserData
    var notes: [Note]
    var book: Book
    @Binding var showNote: Bool
    @Binding var selectedNote: Note
    @State var showBook = false
    @State var selectedBook = Book()
    @State var showPostActions = false
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var selectedChapter: Int? = nil
    @State var showCharacters = false
    @State var showTerms = false
    @State var showImages = false
    @State var showQuotes = false
    @State var searching = false
    @State var pickable = false
    @Binding var showCharacter: Bool
    @Binding var selectedCharacter: Character?
    
    var groupedNotes: [Int: [Note]] {
        Dictionary(grouping: notes, by: { $0.chapterparagraph.0 })
    }

    var body: some View {
        ZStack {
            VStack() {
                HStack {
                    
                    if pickable{
                        
                        //Picker(selection: $selection){
                            Text("\(book.title)")
                                .font(.system(size: 17, weight: .medium))
                        //}
                    } else {
                        Text("\(book.title)")
                            .font(.system(size: 19, weight: .medium))
                    }
                    Spacer()
                    
                    if pickable {
                        Button(action: {
                            addNew.toggle()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .medium))
                                .padding(.vertical)
                                .padding(.trailing)
                        }
                    }

                    if !searching {
                        Button(action: {
                            searching = true
                        }){
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 16))
                        }
                    }
                }
                .padding()
                
                
                
                
                if let chapter = selectedChapter {
                    ForEach(groupedNotes[chapter]!) { note in
                        Button(action: {
                            selectedNote = note
                            showNote = true
                        }) {
                            NotePreview(note: note, showNote: $showNote, selectedNote: $selectedNote, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $showPostActions, showProfile: $showProfile, selectedProfile: $selectedProfile)
                        }
                        Divider()
                            .padding(.horizontal)
                    }
                } else {
                    ForEach(groupedNotes.keys.sorted(), id: \.self) { chapter in
                        ForEach(groupedNotes[chapter]!) { note in
                            Button(action: {
                                selectedNote = note
                                showNote = true
                            }) {
                                NotePreview(note: note, showNote: $showNote, selectedNote: $selectedNote, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $showPostActions, showProfile: $showProfile, selectedProfile: $selectedProfile)
                            }
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top, UIScreen.main.bounds.height * 0.04)
            .padding(.top)
            .background(backgroundColor)
            .sheet(isPresented: $showImages){
                AllImagesFromBookView(isPresenting: $showImages, book: selectedBook)
            }
            .onChange(of: notes) { _ in
                selectedChapter = nil
            }
            
            
            
        }
    }
}


struct AllTermsFromBookView: View {
    @Binding var isPresenting: Bool
    @State var book: Book
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        let allTerms = userData.user.getAllBookTerms(bookid: book.id)
        VStack {
            ForEach(allTerms) { term in
               TermView(term: term)
                
            }
        }
        .background(backgroundColor)
    }
}

struct TermCard: View {
    var term: Term
    var color: String
    var body: some View {
        
        VStack{
            Text(term.term)
                .font(.system(size: 15))
                .lineLimit(1)
        }
        .frame(maxWidth: 120)
        .padding()
        .background (
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(hex: color).opacity(0.5))

        )
        .padding(.vertical)
            
    }
}

struct AllQuotesFromBookView: View {
    @Binding var isPresenting: Bool
    @State var book: Book
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        let allQuotes = userData.user.getQuotesByBookID(bookid: book.id)
        VStack {
            ForEach(allQuotes) { quote in
                QuoteView2(quote: quote)
                
            }
        }
        .background(backgroundColor)
    }
}

struct AllImagesFromBookView: View {
    @Binding var isPresenting: Bool
    @State var book: Book
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        let allImages = userData.user.getAllBookImages(bookid: book.id)
        VStack {
         
        }
        .background(backgroundColor)
    }
}



struct AddQuoteButton: View {
    @Binding var addingQuote: Bool

    
    var body: some View {
        Button(action: {
            addingQuote = true
        }){
            Label("Add Quote", systemImage: "text.quote")
        }
    }
}
struct QuoteForm: View {
    @Binding var isPresenting: Bool
    @ObservedObject var note: Note
    @State private var quoteText: String = ""
    @State private var speaker: String = ""
    @State private var chapter: String = ""
    @State private var pageNumber: String = ""
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var selectedCharacter: Character? = nil
    // Dummy book and character for initialization
    let character = Character()

    var body: some View {
        VStack {
            HStack {
                Text("NEW QUOTE")
                    .font(.system(size: 15))
                    .opacity(0.5)
                    .padding(.vertical)
                    
                Spacer()
            }
            
                HStack {
                    Text("Quote: ")
                    TextField("Enter quote", text: $quoteText)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: "#ECE8DA").opacity(0.4))
                        
                    
                )
            HStack {
                Text("Speaker: ")
                    .padding(.top)
                Spacer()
                
            }
            
            if let char = selectedCharacter {
                CharacterCard(character: .constant(char), user: userData.user, showCharacter: .constant(false), selectedCharacter: .constant(nil))
            } else {
                SearchCharactersBar(selectedCharacter: $selectedCharacter, book: note.book)
                
            }
              /*
                HStack {
                    Text("Speaker: ")
                    TextField("Enter speaker's name", text: $speaker)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: "#ECE8DA").opacity(0.4))
                    
                )*/
                HStack {
                    Text("Page Number: ")
                    TextField("Enter page number", text: $pageNumber)
                        .keyboardType(.numberPad)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: "#ECE8DA").opacity(0.4))
                    
                )
            Spacer()
            Button(action: {
                // Handle form submission
                if let newQuote = createQuote() {
                    print("Quote created: \(newQuote)")
                    userData.user.addQuote(quote: newQuote)
                    // Perform any additional actions with the new quote
                } else {
                    print("Failed to create quote.")
                }
                isPresenting = false
            }) {
                Text("Submit")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.black))
                    .cornerRadius(8)
            }
            Spacer()
        }
        .padding()
        .background(backgroundColor)
    }

    func createQuote() -> Quote? {
        guard let pageNumberValue = Int(pageNumber) else {
            return nil
        }
        if let character = selectedCharacter {
            let quote = Quote(quote: quoteText, book: note.book, speaker: character, pageNumber: pageNumberValue)
            
            character.addQuote(quoteid: quote.id)
            
            return quote
        } else {
            let quote = Quote(quote: quoteText, book: note.book, speaker: Character(), pageNumber: pageNumberValue)
            
            return quote
        }
        
    }
}

/*

struct CharactersView: View {
    var characters: [Character]
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(characters){ character in
                    CharacterCard(character: character)
                }
            }
        }
    }
}*/

struct TermView: View {
    var term: Term
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                Text(term.term)
                    .font(.system(size: 17))
                
                Divider()
                Text(term.meaning)
                    .font(.system(size: 15))
                
            }
            
            ForEach(term.examples) { quote in
                Button(action: {
                    // go to tagged quote
                }){
                    Text(quote.quote)
                    
                }
            }
        }
    }
}

struct Term: Identifiable {
    var id: UUID
    var term: String
    var meaning: String
    var examples: [Quote]
    
    init(id: UUID = UUID(), term: String = "", meaning: String = "", examples: [Quote] = []) {
        self.id = id
        self.term = term
        self.meaning = meaning
        self.examples = examples
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

class Character: Identifiable, Hashable, ObservableObject {
    var id: UUID
    var photo: String
    var name: String
    var description: String
    var references: [UUID]
    var quotes: [UUID]
    var bookid: UUID
    
    init(id: UUID = UUID(), photo: String = "defaultcharacter", name: String = "", description: String = "", references: [UUID] = [], quotes: [UUID] = [], bookid: UUID = UUID()) {
        self.id = id
        self.photo = photo
        self.name = name
        self.description = description
        self.references = references
        self.quotes = quotes
        self.bookid = bookid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
    
    func getAllNotes(user: User, bookid: UUID) -> [Note]{
        var notes: [Note] = []
        for noteid in references {
           
            if let note = user.getNoteByNoteID(bookid: bookid, noteid: noteid){
                notes.append(note)
            }

        }
        return notes
    }
    
        
    func addNoteReference(noteid: UUID){
        references.append(noteid)
    }
    
    func addQuote(quoteid: UUID){
        quotes.append(quoteid)
    }
    
    func getAllQuotes(user: User, bookid: UUID) -> [Quote]{
        var allQuotes: [Quote] = []
        for quoteid in quotes {
           
            if let quote = user.getQuoteByQuoteID(bookid: bookid, quoteid: quoteid){
                allQuotes.append(quote)
            }

        }
        return allQuotes
    }
    
    
}

struct ChapterSummary {
    var keyConcepts: [String]
    var terminology: [Term]
    var characters: [Character]
    var description: String
    
    init(keyConcepts: [String] = [], terminology: [Term] = [], characters: [Character] = [], description: String = "") {
        self.keyConcepts = keyConcepts
        self.terminology = terminology
        self.characters = characters
        self.description = description
    }
}
struct ChapterSummaryView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
            }
            Text("Summary")
                .font(.system(size: 16, weight: .medium))
                .padding(.bottom)
            
            CommonThemeView()
            
            Text("Key concepts: ")
            
            Text("Terminology: ")
            
            Text("People / Characters: ")
    
            Text("Chapter x was about...")
        }
        .font(.system(size: 14))
        
        .padding()
    }
}


struct AllCharactersView: View {
    @Binding var isPresenting: Bool
    @Binding var showCharacter: Bool
    @Binding var selectedCharacter: Character?
    var book: Book
    var user: User
    
    var body: some View {
        let characters = user.getAllBookCharacters(bookid: book.id)
        
        // Use GeometryReader to get the container size
        GeometryReader { geometry in
            // Calculate the number of columns based on the container width
            let columns = Array(repeating: GridItem(.flexible()), count: max(Int(geometry.size.width / 250), 1))
            
            ScrollView {
                Text("People")
                    .font(.system(size: 16, weight: .medium))
                    .padding(.vertical)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(characters) { character in
                        CharacterCard(character: .constant(character), user: user, showCharacter: $showCharacter, selectedCharacter: $selectedCharacter)
                    }
                }
                .padding()
            }
            .padding()
        }
    }
}



struct CharacterCard: View {
    @Binding var character: Character?
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var width = 160.0
    @State var user: User
    @Binding var showCharacter: Bool
    @Binding var selectedCharacter: Character?
    
    var onTapped: (() -> Void)?
    
    var body: some View {
        if let character = character {
            VStack(alignment: .center){
                if let img = UIImage(named: character.photo){
                    Image(uiImage: img)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: width)
                        .clipShape(Circle())
                }
                
                Text(character.name)
                    .font(.system(size: 15, weight: .medium))
                    .padding(.top, 7)
                    .padding(.bottom, 1)
                    .lineLimit(1)
                
                
                
                Text(character.description)
                    .font(.system(size: 13))
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                
                var notes = character.getAllNotes(user: user, bookid: character.bookid)
                var quotes = character.getAllQuotes(user: user, bookid: character.bookid)
                
                HStack{
                    Button(action: {
                        //showCharacter = true
                        // selectedCharacter = character
                        onTapped?()
                    }){
                        if notes.count == 1 {
                            Text("\(notes.count) note")
                                .font(.system(size: 12))
                        } else if notes.count > 1 {
                            Text("\(notes.count) notes")
                                .font(.system(size: 12))
                        }
                    }
                    
                    Button(action: {
                        
                        // showCharacter = true
                        //selectedCharacter = character
                        onTapped?()
                        
                    }){
                        if quotes.count == 1 {
                            Text("\(quotes.count) quote")
                                .font(.system(size: 12))
                        } else if quotes.count > 1 {
                            Text("\(quotes.count) quotes")
                                .font(.system(size: 12))
                        }
                    }
                    
                }
                
                
                
            }
            .frame(width: 160)
            .padding()
            .onTapGesture {
                //showCharacter = true
                //  selectedCharacter = character
                onTapped?()
                
            }
        }
        
        
    }
   
}

struct CharacterView: View {
    @Binding var character: Character?
    var user: User
    @EnvironmentObject var allBooks: Library
    @State var addNew = false
    @State var showNote = false
    @State var selectedNote = Note()
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        
        if let character = character {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Character")
                            .font(.system(size: 14, weight: .medium))
                        Spacer()
                        
                        
                    }
                    .padding(.bottom)
                    HStack {
                        Spacer()
                        CharacterCard(character: $character, user: user, showCharacter: .constant(false), selectedCharacter: .constant(nil))
                        Spacer()
                    }
                    
                    Text("QUOTES")
                        .font(.system(size: 12.5))
                        .opacity(0.7)
                        .padding(.leading)

                    ScrollView(.horizontal){
                        
                        HStack {
                            
                            ForEach(Array(user.getQuotesByBookID(bookid: character.bookid).enumerated()), id: \.element.id) { index, quote in
                                
                                QuoteCard(quote: quote, color: "#00000")
                                    .padding(.leading)
                                
                                
                            }
                            
                        }
                    }
                    
                    let notes = character.getAllNotes(user: user, bookid: character.bookid)
                    Text("NOTES")
                        .font(.system(size: 12.5))
                        .opacity(0.7)
                        .padding(.leading)
                    ListNotes(addNew: $addNew, notes: notes, showNote: $showNote, selectedNote: $selectedNote)
                    
                    
                    
                }
                .padding()
            }
            .background(backgroundColor)
        }
    }
}

struct ListNotes: View {
    @Binding var addNew: Bool
    @EnvironmentObject var userData: UserData
    var notes: [Note]
    @Binding var showNote: Bool
    @Binding var selectedNote: Note
    @State var showBook = false
    @State var selectedBook = Book()
    @State var showPostActions = false
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var selectedChapter: Int? = nil
    @State var showCharacters = false
    @State var showTerms = false
    @State var showImages = false
    @State var showQuotes = false
    @State var searching = false
    @State var pickable = false

    var groupedNotes: [Int: [Note]] {
        Dictionary(grouping: notes, by: { $0.chapterparagraph.0 })
    }

    var body: some View {
        ZStack {
            VStack {
                
                    //SearchNotesBar(isPresenting: $searching, book: book, showToolbar: $showToolbar, showCharacters: $showCharacters, showQuotes: $showQuotes)
                    
                    ForEach(notes) { note in
                        Button(action: {
                            selectedNote = note
                            showNote = true
                        }) {
                            NotePreview(note: note, showNote: $showNote, selectedNote: $selectedNote, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $showPostActions, showProfile: $showProfile, selectedProfile: $selectedProfile)
                        }
                        Divider()
                            .padding(.horizontal)
                    }
                
                Spacer()
            }
            //.padding(.top, UIScreen.main.bounds.height * 0.04)
            .padding(.top)
            .background(backgroundColor)
                

            
            /*.sheet(isPresented: $showQuotes){
                AllQuotesFromBookView(isPresenting: $showQuotes, book: selectedBook)
            }*/
           /* .sheet(isPresented: $showTerms){
                AllTermsFromBookView(isPresenting: $showTerms, book: selectedBook)
            }*/
            
            .onChange(of: notes) { _ in
                selectedChapter = nil
            }
            
            
            /*.sheet(isPresented: $showCharacters) {
                AllCharactersView(isPresenting: $showCharacters, book: book, user: userData.user)
                    .background(backgroundColor)

            }*/
            
        }
    }
}


struct CitationButton: View {
    enum CitationType: String, CaseIterable {
        case abaNavigate = "ABA"
        case chicagoStyle = "CHI"
        case mlaStyle = "MLA"
    }
    
    var citation: Citation
    @State private var selectedCitationType: CitationType = .abaNavigate
    @State private var showAlert = false
    @State private var citationText = ""

    var body: some View {
        HStack {
            Picker("Citation Type", selection: $selectedCitationType) {
                ForEach(CitationType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .opacity(0.7)
                        
                    
                }
            }
            
            .onChange(of: selectedCitationType) { _ in
                updateCitationText()
            }
            
            Text(citationText)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .padding(.vertical)
                .opacity(0.7)
            
            Button(action: {
                copyToClipboard()
            }) {
                Image(systemName: "square.on.square")
                    .padding(.leading, -7)
                    .font(.system(size: 11))
                    .foregroundColor(.black)
                    .opacity(0.7)

            }
        }
        .onAppear {
            updateCitationText()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Copied"), message: Text("Citation copied!"), dismissButton: .default(Text("Ok")))
        }
        .padding()
    }
    
    func updateCitationText() {
        switch selectedCitationType {
        case .abaNavigate:
            citationText = citation.abaNavigate()
        case .chicagoStyle:
            citationText = citation.chicagoStyle()
        case .mlaStyle:
            citationText = citation.mlaStyle()
        }
    }
    
    func copyToClipboard() {
        UIPasteboard.general.string = citationText
        showAlert = true
    }
}

struct ShareButton: View {
    @Binding var sharePage: Bool
   
    var body: some View {
        Button(action: {
            sharePage.toggle()
        }){
            HStack {
                Text("Share")
                
            }
                .font(.system(size: 16))
                .font(.system(size: 16))
                .padding(9)
                /*.background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(.black))
                )*/
        
        }
    }
}

struct PublicNoteView: View {
    @Binding var isPresenting: Bool
    @Binding var note: Note
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var editing = false
    @State var xoffset = 0.0
    @State var draw = false
    @State var addingQuote = false
    @State var addingTerm = false
    @State var isShowingPhotoPicker = false
    @State var selectedImage: UIImage?
    @Binding var fullScreen: Bool
    @State var citing = false
    @State private var drawing = PKDrawing()
    @State private var dynamicHeight: CGFloat = 0
    @State var text = "Thomas Edison and his assistant, William Kennedy Laurie Dickson, are credited with creating the first motion picture camera, the Kinetograph, in the 1890s. \n\nThe Lumière brothers, Auguste and Louis, in France, also played a significant role. They created the Cinématographe, which was both a cam"
    @State var newCharacter = false
    @State var seeImage = false
    @State var selectedImg = UIImage(named: "")
    @State var sidebar = false
    @State var sharePage: Bool = false
    @State var pub = false
    @State var showCover = false
    @State var showCharacter: Bool = false
    @State var selectedCharacter: Character? = nil
    @State var isLiked = false
    @State var selectedProfile = User()
    @State var showProfile = false
    @State var replying = false
    @State var replyTo = Comment()
    @State var showDiscussion = false
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact

        ZStack {
            
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            isPresenting = false
                        }){
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                       
                        if fullScreen {
                            ScrollView(.horizontal){
                                HStack(spacing: 20) {
                                    
                                    
                                    Button(action: {
                                        addTextElement()
                                    }) {
                                        Image(systemName: "textformat")
                                      
                                    }
                                    
                                    Button(action: {
                                        draw.toggle()
                                    }){
                                        Image(systemName: "pencil.and.scribble")
                                            .padding(8)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .foregroundColor(draw ? Color(hex: "#EFEBE0") : Color(.clear))
                                            )
                                    }
                                    
                                    // blue ink, red ink, black ink, purple ink
                                    Circle()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.blue)
                                    
                                    Menu {
                                        AddQuoteButton(addingQuote: $addingQuote)
                                        
                                        AddTermButton(addingTerm: $addingTerm)
           
                                        
                                        Button(action: {
                                            // Action for showing photo picker
                                            isShowingPhotoPicker = true
                                        }) {
                                            Label("Add Photo", systemImage: "photo")
                                        }
                                        
                                        Button(action: {
                                            newCharacter = true
                                        }){
                                            Label("Add Character", systemImage: "person.crop.rectangle")
                                            
                                            
                                        }
                                    } label: {
                                        // Cover image for the dropdown menu
                                        Image(systemName: "plus")
                                            .foregroundColor(.black)
                                        
                                    }
                                   
                                    
                                    
                                    .sheet(isPresented: $isShowingPhotoPicker) {
                                        PhotoPicker(selectedImage: $selectedImage) { image in
                                            if let image = image {
                                                note.elements.append(NoteElement(isImage: true, image: image))
                                            }
                                        }
                                    }
                                    
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                            .scrollIndicators(.hidden)
                            
                            Spacer()
                            HStack {
                                Image(systemName: "arrow.uturn.backward")
                                Image(systemName: "arrow.uturn.forward")
                            }
                            .padding(.trailing)
                            ShareButton(sharePage: $sharePage)

                            
                            
                            
                            
                        }
                    
                    }
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            showDiscussion.toggle()
                        }){
                            Text("Discussion")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.black)
                        }
                        Spacer()

                    }
                    
                }
                //.padding(.horizontal)
                .padding([.top,.horizontal])
                
                //.padding(.horizontal, horizontalSizeClass != .compact ? 20 : 0)
                .padding(.top, fullScreen ? 0 : 12)
                .foregroundColor(.black)
                .background(backgroundColor)
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        
                        let read = userData.user.read(book: note.book)
                        
                        if note.coverShown {
                            HStack {
                                Image(note.book.cover)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .shadow(radius: 0.5)
                                    .padding(.bottom)
                                    .onTapGesture{
                                        //showBook.toggle()
                                    }
                                Spacer()
                            }
                        }
                        
                        HStack {
                            Button(action: {
                                showProfile = true
                                selectedProfile = note.user
                            }){
                                ProfileThumbnail(image: note.user.photo, size: 25)
                                
                                Text("\(note.user.name)")
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.trailing, -1)
                                    .foregroundColor(.black)
                            }
                            Spacer()

                            
                            
                         
                              //  Spacer()
                            
                            
                        }
                        
                        HStack {
                            Text(note.title)
                                .font(.system(size: horizontalSizeClass == .compact ? 16 : 17, weight: .medium))
                                .padding(.top, 2)
                                .padding(.top, note.coverShown ? 0 : 60)
                            
                            Spacer()
                        }
                        
                        
                        ForEach(note.elements) { element in
                            if element.isText, let text = element.text {
                                Text(text)
                                    .font(.system(size: 16))
                                    .lineSpacing(4)
                                    .multilineTextAlignment(.leading)
                                    .padding(note.title != ""  ? .vertical : .bottom)
                                    .padding(.top, note.title == "" ? 2 : 0)
                                //.padding(.horizontal, -5)
                                //.frame(width: UIScreen.main.bounds.width * 0.2) dynamicHeight
                                //.frame(height: dynamicHeight)
                                .padding(.bottom)
                                
                            } else if element.isImage, let image = element.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width * 0.35)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding(.bottom)
                                    .onTapGesture{
                                        seeImage = true
                                        selectedImg = image
                                    }
                                
                            } else if element.isDrawing, let drawing = element.drawing {
                                /* DrawingView(isDrawing: .constant(true), .constant(drawing), onSave: { drawing in
                                 note.elements.append(NoteElement(isDrawing: true, drawing: drawing))
                                 })*/
                            } else if element.isTerm, let term = element.term {
                                TermView(term: term)
                            } else if element.isCharacter, let character = element.character {
                                // Character tag here
                                
                                
                            }
                        }
                        
                        
                        if draw {
                            DrawingView(isDrawing: $draw, drawing: $drawing, onSave: { drawing in
                                note.elements.append(NoteElement(isDrawing: true, drawing: drawing))
                            })
                        }
                        
                        HStack {
                            Text(timeSince(from: note.timestamp))
                                .padding(.vertical, 2)
                                .font(.system(size: 13))
                                .opacity(0.7)
                            Spacer()
                            Text("\(note.likes) likes")
                                .font(.system(size: 13))
                                .opacity(0.7)
                                .padding(.trailing)
                            Text("\(note.comments.count) comments")
                                .font(.system(size: 13))
                                .opacity(0.7)
                                .padding(.trailing)
                            
                            
                            if !isLiked {
                                Button(action: {
                                    isLiked.toggle()
                                    note.likes += 1
                                    
                                }){
                                    Image(systemName: "heart")
                                        .font(.system(size: 19))
                                        .foregroundColor(.black)
                                }
                            } else {
                                Button(action: {
                                    isLiked.toggle()
                                    note.likes -= 1
                                    
                                }){
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 19))
                                        .foregroundColor(.pink)
                                }
                            }
                            
                        }
                        .offset(y: 5)
                        if note.comments.count > 0 {
                            Text("Comments")
                                .padding(.vertical)
                                .font(.system(size: 15))
                        } else {
                            Text("No comments yet")
                                .padding(.vertical)
                                .font(.system(size: 14))
                                .opacity(0.7)
                        }
                        VStack(spacing: 20) {
                            ForEach(note.comments) { comment in
                                if !comment.isReply {
                                    EComment(comment: comment, replying: $replying, replyTo: $replyTo)
                                }
                            }
                        }
                        
                    }
                    .frame(width: 650)
                    .padding(fullScreen ? UIScreen.main.bounds.width * 0.1 : 0)
                    .background(
                        Rectangle()
                            .foregroundColor(fullScreen ? Color(hex: "#EFE9D7").opacity(0.4) : Color(.clear))
                    )
                    .padding(.top, 60)
                    
                    .sheet(isPresented: $addingQuote) {
                        QuoteForm(isPresenting: $addingQuote, note: note)
                            .presentationDetents([.fraction(0.9)])
                    }
                    
                    .sheet(isPresented: $newCharacter){
                        CharacterForm(isPresenting: $newCharacter, note: note)
                    }
                    .padding([.horizontal, .bottom])
                    //.padding(.horizontal, horizontalSizeClass != .compact ? 20 : 0)
                    
                    //.padding(.horizontal, fullScreen ?  UIScreen.main.bounds.width * 0.13 : 0)
                    .padding(.top)
                    .background(backgroundColor)
                    .onTapGesture { }
                    .onLongPressGesture(minimumDuration: 1) { }
                    /*
                    VStack(alignment: .leading){
                        Text("CHARACTERS")
                            .font(.system(size: 12))
                            .opacity(0.8)
                        
                        ScrollView(.horizontal){
                            HStack{

                                ForEach(userData.user.getAllBookCharacters(bookid: note.book.id)){ character in
                                    
                                    CharacterCard(character: .constant(character), width: 80, user: userData.user, showCharacter: $showCharacter, selectedCharacter: $selectedCharacter)
                                    
                                }
                            }
                        }
                        Text("TAGS")
                            .font(.system(size: 12))
                            .opacity(0.8)
                    }
                    .frame(width: 650) */
                    
                    

                }
                .padding(.bottom, 75)
                .scrollIndicators(.hidden)
                
                
            }
            .sheet(isPresented: $sharePage){
                SharePageView(isPresenting: $sharePage, note: $note)
            }
            .background(backgroundColor)
            
            if showDiscussion {
               // DiscussionView(isPresenting: $showDiscussion, posts: note.book.discussion.posts, book: $note.book, user: userData.user, showEReader: .constant(false), color1: .black, showToolbar: .constant(true))

            }
            if !fullScreen {
                VStack {
                    Spacer()
                    CommentField(comments: $note.comments, replying: $replying, replyTo: $replyTo)
                }
                    
                    
                    .foregroundColor(.black/*Color(hex: "#111462")*/)
                    //.padding(.horizontal)
                    .font(.system(size: 16))
                    .padding(.horizontal)
                    //.frame(height: 70)
                    /*
                    .overlay(
                        HStack {
                            Spacer()
                            if !fullScreen {
                                Button(action: {
                                    isPresenting = false
                                    fullScreen = true
                                }){
                                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                                        .font(.system(size: 14))
                                    
                                    
                                }
                                .padding(.trailing, -14)
                                
                            }
                        }
                            .foregroundColor(.black/*Color(hex: "#111462")*/)
                            .padding()
                        
                        
                        
                    )
                    .foregroundColor(.black/*Color(hex: "#111462")*/)
                    .padding()
                    .font(.system(size: 16))
                    .padding(.horizontal)
                    .frame(height: 70)
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(backgroundColor)
                                            )
                     */
                   // .padding(.bottom)
                    
                    
                
            }
            //.padding(.bottom, fullScreen ? 60 : 0)

            
            //if editing {
            //NoteEditor(isPresenting: $editing, note: $note)
            //}
            
            if citing {
                CitationPopUp(citation: Citation(author: note.book.author.name, title: note.book.title, year: Int(note.book.year)!, publisher: "Unknown Publisher"))
            }
            
            if seeImage{
                VStack{
                    Spacer()
                    Image(uiImage: selectedImg!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: UIScreen.main.bounds.height * 0.7)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.bottom)
                    Spacer()
                    
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(Color(.black).opacity(0.5))
                .onTapGesture{
                    seeImage.toggle()
                }
            }
            
            if addingTerm {
                AddTermForm(isPresenting: $addingTerm, note: note)
                    
            }
        }
    
        .offset(x: xoffset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.translation.width > 0 {
                        self.xoffset = gesture.translation.width
                    }
                }
                .onEnded { _ in
                    if self.xoffset > UIScreen.main.bounds.width / 2.2 {
                        self.xoffset = UIScreen.main.bounds.width
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isPresenting = false
                            fullScreen = false
                        }
                    } else {
                        self.xoffset = 0
                    }
                }
        )
        .animation(.easeOut, value: xoffset)
        
    }
    
    
    private func addTextElement() {
        let text = ""
        note.elements.append(NoteElement(isText: true, text: text))
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
            return "Just now"
        }
    }
}

struct AllUserNotes: View {
    @State var user: User
    @Binding var showToolbar: Bool
    @State var selectedNotes: [Note] = []
    @State var selectedBook: Book? = nil
    @State var showNote = false
    @State var selectedNote: Note = Note()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var showRecent = true
    @State var selectedChapter: Int? = nil
    @State var fullScreen = false
    @State var addNew = false
    @State var addBook = false
    @State var newNote = Note()
    @State var showNewNote = false
    @EnvironmentObject var userData: UserData
    @State var addNewNote = false
    @State var shareNotes = false
    @State var uploadPdf = false
    @State var choosingBook = false
    @State var showCharacter: Bool = false
    @State var selectedCharacter: Character? = Character(name: "Alana")
    @EnvironmentObject var navigation: Nav
    @State var showAllNotes = false
    @State var showSideBar: Bool = true
    
    var body: some View {
        HStack {
            if showSideBar {
                NotesSidebar(selectedNote: $selectedNote, showAllNotes: $showAllNotes, selectedBook: $selectedBook, showAll: $showRecent, isPresenting: $showSideBar)
                    .frame(width: UIScreen.main.bounds.width * 0.18)
                    .padding(.top)
            }
           
            VStack {
                if showRecent {
                    ScrollView {
                        RecentNotesView(isPresenting: .constant(true), notes: user.getAllNotes(), showNote: $showNote, selectedNote: $selectedNote, selectedBook: selectedBook ?? Book(), showToolbar: $showToolbar)
                            .padding(.top, UIScreen.main.bounds.height * 0.04)

                    }
                    .scrollIndicators(.hidden)
                } else if showAllNotes {
                    ScrollView {
                        if let book = selectedBook {
                            let notes = user.getNotesByBookID(bookid: book.id)
                            AllNotesView(isPresenting: .constant(true), showToolbar: $showToolbar, addNew: .constant(false), notes: notes, book: selectedBook ?? Book(), showNote: $showNote, selectedNote: $selectedNote, showCharacter: $showCharacter, selectedCharacter: $selectedCharacter)
                                .onChange(of: selectedNotes) { _ in
                                    selectedChapter = nil
                                }
                                .padding(.top, UIScreen.main.bounds.height * 0.04)

                        }
                    }
                    .scrollIndicators(.hidden)
                    
                } else {
                    NoteView(isPresenting: $showNote, note: $selectedNote, fullScreen: .constant(true))
                        .padding(.top)

                }
            }        

                

        }
        .padding(.horizontal)
        .background(backgroundColor)
        
    }
}
struct NoteView: View {
    @Binding var isPresenting: Bool
    @Binding var note: Note
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var editing = false
    @State var xoffset = 0.0
    @State var draw = false
    @State var addingQuote = false
    @State var addingTerm = false
    @State var isShowingPhotoPicker = false
    @State var selectedImage: UIImage?
    @Binding var fullScreen: Bool
    @State var citing = false
    @State private var drawing = PKDrawing()
    @State private var dynamicHeight: CGFloat = 0
    @State var text = "Thomas Edison and his assistant, William Kennedy Laurie Dickson, are credited with creating the first motion picture camera, the Kinetograph, in the 1890s. \n\nThe Lumière brothers, Auguste and Louis, in France, also played a significant role. They created the Cinématographe, which was both a cam"
    @State var newCharacter = false
    @State var seeImage = false
    @State var selectedImg = UIImage(named: "")
    @State var sidebar = false
    @State var sharePage: Bool = false
    @State var pub = false
    @State var showCover = false
    @State var showCharacter: Bool = false
    @State var selectedCharacter: Character? = nil

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact

        ZStack {
                
                GeometryReader { geometry in
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                isPresenting = false
                            }){
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            
                            if fullScreen {
                                ScrollView(.horizontal){
                                    HStack(spacing: 20) {
                                        
                                        
                                        Button(action: {
                                            addTextElement()
                                        }) {
                                            Image(systemName: "textformat")
                                            
                                        }
                                        
                                        Button(action: {
                                            draw.toggle()
                                        }){
                                            Image(systemName: "pencil.and.scribble")
                                                .padding(8)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .foregroundColor(draw ? Color(hex: "#EFEBE0") : Color(.clear))
                                                )
                                        }
                                        
                                        // blue ink, red ink, black ink, purple ink
                                        Circle()
                                            .frame(width: 16, height: 16)
                                            .foregroundColor(.blue)
                                        
                                        Menu {
                                            AddQuoteButton(addingQuote: $addingQuote)
                                            
                                            AddTermButton(addingTerm: $addingTerm)
                                            
                                            
                                            Button(action: {
                                                // Action for showing photo picker
                                                isShowingPhotoPicker = true
                                            }) {
                                                Label("Add Photo", systemImage: "photo")
                                            }
                                            
                                            Button(action: {
                                                newCharacter = true
                                            }){
                                                Label("Add Character", systemImage: "person.crop.rectangle")
                                                
                                                
                                            }
                                        } label: {
                                            // Cover image for the dropdown menu
                                            Image(systemName: "plus")
                                                .foregroundColor(.black)
                                            
                                        }
                                      
                                        
                                        
                                        .sheet(isPresented: $isShowingPhotoPicker) {
                                            PhotoPicker(selectedImage: $selectedImage) { image in
                                                if let image = image {
                                                    note.elements.append(NoteElement(isImage: true, image: image))
                                                }
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                .padding(.horizontal)
                                
                                Spacer()
                            
                                PublicPrivateButton(note: $note)
                                    .padding(.trailing)
                                HStack {
                                    Image(systemName: "arrow.uturn.backward")
                                    Image(systemName: "arrow.uturn.forward")
                                }
                                
                                ShareButton(sharePage: $sharePage)
                                
                                
                                .padding(.trailing)
                                
                                
                                
                                
                                
                                
                            }
                            
                        }
                        if !fullScreen {
                            HStack {
                                Spacer()
                                Text("Note")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                                Spacer()
                                
                            }
                        }
                    }
                    .padding([.top, .horizontal])
                    
                    //.padding(.horizontal, horizontalSizeClass != .compact ? 20 : 0)
                    .padding(.top, fullScreen ? 0 : 12)
                    .foregroundColor(.black)
                    .background(backgroundColor)
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            
                            let read = userData.user.read(book: note.book)
                            
                            if note.coverShown {
                                HStack {
                                    
                                    Image(note.book.cover)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                        .shadow(radius: 0.5)
                                        .padding(.bottom)
                                        .onTapGesture{
                                            note.coverShown.toggle()
                                        }
                                    Spacer()
                                }
                            }
                            
                            HStack {
                                TextField("Title", text: $note.title)
                                    .font(.system(size: horizontalSizeClass == .compact ? 16 : 17, weight: .medium))
                                    .padding(.top, 2)
                                    .padding(.top, note.coverShown ? 0 : 60)
                                
                                Spacer()
                            }
                            
                            
                            ForEach(note.elements) { element in
                                if element.isText, let text = element.text {
                                    NoteTextEditor(text: Binding(
                                        get: { text },
                                        set: { newValue in
                                            if let index = note.elements.firstIndex(where: { $0.id == element.id }) {
                                                note.elements[index].text = newValue
                                            }
                                        }
                                    ), backgroundColor: UIColor(Color(hex: "#FDFAEF")), dynamicHeight: $dynamicHeight)
                                    
                                    .padding(.horizontal, -5)
                                    //.frame(width: UIScreen.main.bounds.width * 0.2) dynamicHeight
                                    .frame(height: dynamicHeight)
                                    .padding(.bottom)
                                    
                                } else if element.isImage, let image = element.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: UIScreen.main.bounds.width * 0.35)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(.bottom)
                                        .onTapGesture{
                                            seeImage = true
                                            selectedImg = image
                                        }
                                    
                                } else if element.isDrawing, let drawing = element.drawing {
                                    /* DrawingView(isDrawing: .constant(true), .constant(drawing), onSave: { drawing in
                                     note.elements.append(NoteElement(isDrawing: true, drawing: drawing))
                                     })*/
                                } else if element.isTerm, let term = element.term {
                                    TermView(term: term)
                                } else if element.isCharacter, let character = element.character {
                                    // Character tag here
                                    
                                    
                                }
                            }
                            
                            
                            if draw {
                                DrawingView(isDrawing: $draw, drawing: $drawing, onSave: { drawing in
                                    note.elements.append(NoteElement(isDrawing: true, drawing: drawing))
                                })
                            }
                            
                            
                            
                        }
                        .frame(width: 650)
                        .padding(fullScreen ? UIScreen.main.bounds.width * 0.1 : 0)
                        .background(
                            Rectangle()
                                .foregroundColor(fullScreen ? Color(hex: "#EFE9D7").opacity(0.4) : Color(.clear))
                        )
                        .padding(.top, 60)
                        
                        .sheet(isPresented: $addingQuote) {
                            QuoteForm(isPresenting: $addingQuote, note: note)
                                .presentationDetents([.fraction(0.9)])
                        }
                        
                        .sheet(isPresented: $newCharacter){
                            CharacterForm(isPresenting: $newCharacter, note: note)
                        }
                        .padding([.horizontal, .bottom])
                        //.padding(.horizontal, horizontalSizeClass != .compact ? 20 : 0)
                        
                        //.padding(.horizontal, fullScreen ?  UIScreen.main.bounds.width * 0.13 : 0)
                        .padding(.top)
                        .background(backgroundColor)
                        .onTapGesture { }
                        .onLongPressGesture(minimumDuration: 1) { }
                        /*
                         VStack(alignment: .leading){
                         Text("CHARACTERS")
                         .font(.system(size: 12))
                         .opacity(0.8)
                         
                         ScrollView(.horizontal){
                         HStack{
                         
                         ForEach(userData.user.getAllBookCharacters(bookid: note.book.id)){ character in
                         
                         CharacterCard(character: .constant(character), width: 80, user: userData.user, showCharacter: $showCharacter, selectedCharacter: $selectedCharacter)
                         
                         }
                         }
                         }
                         Text("TAGS")
                         .font(.system(size: 12))
                         .opacity(0.8)
                         }
                         .frame(width: 650) */
                        
                    }
                    .padding(.bottom, 75)
                    .scrollIndicators(.hidden)
                }
                .sheet(isPresented: $sharePage){
                    SharePageView(isPresenting: $sharePage, note: $note)
                }
                }
                
           

            if sidebar {
                HStack {
                    Spacer()

                    VStack {
                        
                        ScrollView(){
                            VStack(spacing: 50) {
                                
                                Button(action: {
                                    addTextElement()
                                }) {
                                    Image(systemName: "textformat")
                                    /*Text("Text")
                                        .font(.system(size: 14))
                                        .padding(6)
                                    
                                        .background(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(Color.black, lineWidth: 1)
                                            
                                                .foregroundColor(backgroundColor)
                                        )*/
                                }
                                
                                Button(action: {
                                    draw = true
                                }){
                                    Image(systemName: "pencil.line")
                                }
                                AddQuoteButton(addingQuote: $addingQuote)
                                AddTermButton(addingTerm: $addingTerm)
                                
                                Button(action: {
                                    isShowingPhotoPicker = true
                                }) {
                                    Image(systemName: "photo")
                                }
                                .sheet(isPresented: $isShowingPhotoPicker) {
                                    PhotoPicker(selectedImage: $selectedImage) { image in
                                        if let image = image {
                                            note.elements.append(NoteElement(isImage: true, image: image))
                                        }
                                    }
                                }
                                
                                Button(action: {
                                    newCharacter = true
                                }){
                                    Image(systemName: "person.crop.rectangle")
                                    
                                    
                                }
                                
                                
                                
                                
                               
                            }
                        }
                        .padding(.horizontal)
                        
                        
                        Spacer()
                        
                        
                        
                        
                        
                        
                    }
                    .foregroundColor(.black/*Color(hex: "#111462")*/)
                    .padding()
                    .font(.system(size: 16))
                    .frame(width: 40, height: 400)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(backgroundColor)
                            .shadow(radius: 2.5)
                    )
                }
                
            } else if !fullScreen {
                VStack {
                    Spacer()
                    
                    HStack() {
                        Spacer()
                        
                        ScrollView(.horizontal){
                            HStack(spacing: 50) {
                                PublicPrivateButton(note: $note)

                                    
       
                                
                                Button(action: {
                                    addTextElement()
                                }) {
                                    Image(systemName: "textformat")

                                }
                                
                                Button(action: {
                                    draw.toggle()
                                }){
                                    Image(systemName: "pencil.and.scribble")
                                        .padding(8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .foregroundColor(draw ? Color(hex: "#EFEBE0") : Color(.clear))
                                        )
                                }
                                
                                // blue ink, red ink, black ink, purple ink
                                Circle()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.blue)
                                HStack {
                                    Image(systemName: "arrow.uturn.backward")
                                    Image(systemName: "arrow.uturn.forward")
                                }
                                
                                AddQuoteButton(addingQuote: $addingQuote)
                                AddTermButton(addingTerm: $addingTerm)
                                
                                Button(action: {
                                    isShowingPhotoPicker = true
                                }) {
                                    Image(systemName: "photo")
                                }
                                .sheet(isPresented: $isShowingPhotoPicker) {
                                    PhotoPicker(selectedImage: $selectedImage) { image in
                                        if let image = image {
                                            note.elements.append(NoteElement(isImage: true, image: image))
                                        }
                                    }
                                }
                                
                                Button(action: {
                                    newCharacter = true
                                }){
                                    Image(systemName: "person.crop.rectangle")
                                    
                                    
                                }
                                
                                
                                
                                
                               
                                
                            

                                
                            }
                        }
                        .padding(.horizontal)
                        
                        
                        Spacer()
                        
                        
                        
                        
                        
                    }
                    .overlay(
                        HStack {
                            Spacer()
                            if !fullScreen {
                                ShareButton(sharePage: $sharePage)

                                Button(action: {
                                    isPresenting = false
                                    fullScreen = true
                                }){
                                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                                        .font(.system(size: 14))
                                    
                                    
                                }
                                .padding(.trailing, -14)
                                
                            }
                        }
                            .foregroundColor(.black/*Color(hex: "#111462")*/)
                            .padding()
                        
                        
                        
                    )
                    .foregroundColor(.black/*Color(hex: "#111462")*/)
                    .padding()
                    .font(.system(size: 16))
                    .padding(.horizontal)
                    .frame(height: 70)
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(backgroundColor)
                                            )
                    
                }
                .scrollIndicators(.hidden)
            }
            //.padding(.bottom, fullScreen ? 60 : 0)

            
            //if editing {
            //NoteEditor(isPresenting: $editing, note: $note)
            //}
            
            if citing {
                CitationPopUp(citation: Citation(author: note.book.author.name, title: note.book.title, year: Int(note.book.year)!, publisher: "Unknown Publisher"))
            }
            
            if seeImage{
                VStack{
                    Spacer()
                    Image(uiImage: selectedImg!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: UIScreen.main.bounds.height * 0.7)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.bottom)
                    Spacer()
                    
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(Color(.black).opacity(0.5))
                .onTapGesture{
                    seeImage.toggle()
                }
            }
            
            if addingTerm {
                AddTermForm(isPresenting: $addingTerm, note: note)
                    
            }
        }
        .background(backgroundColor)

        .offset(x: xoffset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.translation.width > 0 {
                        self.xoffset = gesture.translation.width
                    }
                }
                .onEnded { _ in
                    if self.xoffset > UIScreen.main.bounds.width / 2.2 {
                        self.xoffset = UIScreen.main.bounds.width
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isPresenting = false
                            fullScreen = false
                        }
                    } else {
                        self.xoffset = 0
                    }
                }
        )
        .animation(.easeOut, value: xoffset)
        
    }
    
    
    private func addTextElement() {
        let text = ""
        note.elements.append(NoteElement(isText: true, text: text))
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
            return "Just now"
        }
    }
}

struct PublicPrivateButton: View {
    @Binding var note: Note
    
    var body: some View {
        if note.isPublished(){
            Text("Public")
                .font(.system(size: 14))
                .foregroundColor(.blue)

        } else {
            Text("Private")
                .font(.system(size: 14))
                .foregroundColor(.blue)


        }
    }
}

struct NotesSidebar: View {
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var selectedNote: Note
    @Binding var showAllNotes: Bool
    @Binding var selectedBook: Book?
    @Binding var showAll: Bool
    @Binding var isPresenting: Bool
    
    var body: some View {
        VStack {
            HStack {
                
                Text("Notes")
                    .font(.system(size: 16, weight: .medium))
                    .padding(.vertical)
                Spacer()
                
                // ShareButton(sharePage: $shareNotes)
                // .padding(.trailing)
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.blue)
                //AddDropdown(addBook: $addBook, addNewNote: $addNewNote, uploadPdf: $uploadPdf)
                //.padding(.trailing)
                Image("menu")
                    .resizable()
                    .foregroundColor(Color.white)

                    .frame(width: 22, height: 22)
                    .opacity(1)
                    .onTapGesture {
                        isPresenting.toggle()
                    }
                
                
            }
            .padding([.top, .horizontal])
            ScrollView {
                
                VStack {
                    Button(action: {
                        showAll = true
                    }){
                        HStack(spacing: 5) {

                            Text("All")
                                .font(.system(size: 13.5, weight: .medium))
                                .lineLimit(1)
                                .padding(.leading, 1)
                                
                            
                            Spacer()
                            /*
                            Image(systemName: "plus")
                            */
                        }
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .padding(.leading)
                        .padding(.vertical)
                    }
                    Divider()
                    
                    ForEach(userData.user.getAllBooks()) { book in
                        if userData.user.hasNotes(bookid: book.id) {
                            SidebarCell(book: book, selectedNote: $selectedNote, showAllNotes: $showAllNotes, selectedBook: $selectedBook, showAll: $showAll)
                        }
                    }
                    Spacer()
                }
                .padding(.top, 60)
                
                
            }
            .scrollIndicators(.hidden)
        }
        .background(backgroundColor)
        .frame(height: UIScreen.main.bounds.height)
        
    }
}

struct SidebarCell: View {
    @State var book: Book
    @State var showNotes = false
    @EnvironmentObject var userData: UserData
    @Binding var selectedNote: Note
    @Binding var showAllNotes: Bool
    @Binding var selectedBook: Book?
    @Binding var showAll: Bool

    var body: some View {
        VStack(alignment: .leading) {
            
            Button(action: {
                showNotes.toggle()
                showAllNotes = true
                selectedBook = book
                showAll = false
            }){
                HStack(spacing: 5) {
                    if showNotes {
                        Image("down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                    } else {
                        Image("down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .rotationEffect(Angle(degrees: -90))

                    }

                    /*
                    Image(book.cover)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .shadow(radius: 0.5)
                    */
                    Text(book.title)
                        .font(.system(size: 13.5, weight: .medium))
                        .lineLimit(1)
                        .padding(.leading, 1)
                        
                    
                    Spacer()
                    /*
                    Image(systemName: "plus")
                    */
                }
                .font(.system(size: 15))
                .foregroundColor(.black)
                .padding(.leading)
                .padding(.vertical)
            }
            Divider()
            
            if showNotes {
                VStack {
                    
                    ForEach(userData.user.getNotesByBookID(bookid: book.id)){ note in
                        VStack(alignment: .leading) {
                            Button(action: {
                                selectedNote = note
                                showAllNotes = false
                                showAll = false
                            }){
                                HStack {
                                    Text(note.title)
                                        .font(.system(size: 12.5))
                                        .lineLimit(1)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                
                            }
                            .padding(.vertical)
                            .padding(.leading, 50)
                            Divider()

                        }
                        
                        
                    }
                }
                

            }
        }
        
    }
}

/*
struct ReadNotesSplit: View {
    @EnvironmentObject var userData: UserData
   // @Binding var book: Book
    @Binding var isPresenting: Bool
    @Binding var showToolbar: Bool
    @EnvironmentObject var sharedData: SharedData
    @State var foregroundColor = Color(.black)
    @State var isShareQuotePresented: Bool = false
    @State var sharedQuote: String = ""
    @State var createQuotePost = false
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var showComments = false
    @State var selectedIndex: Int = 0
    @State var selectedText: String = ""
    @State var isVisible = false
    @State var fontSize = 0.0
    @State var audioModeOn = false
    @State var showNotes = false
    @State var showNote = false
    @State var selectedNote: Note = Note()
    @State var showHighlightKey = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var showHighlightColors = false
    @State var showAllNotes = false
    @State var selectedColor = Color(.yellow)
    @State var index: Int = 0
    @State var start: Int = 0
    @State var end: Int = 0
    @State var isHighlightingActive = false
    @State var selectedChapterIndex = 0
    @State var showSplitScreen: Bool = false
    
    var body: some View {
        HStack{
            /*
            ScrollView {
                GeometryReader { geometry in
                    VStack(alignment: .leading, spacing: 16) {
                        let processedBook = userData.user.applyAnnotationsToBook(ebook: book)
                        
                        ForEach(Array(processedBook.chapters.enumerated()), id: \.element.id) { chapterIndex, chapter in
                            ForEach(Array(chapter.paragraphs.enumerated()), id: \.element.id) { paragraphIndex, paragraph in
                                CustomTextViewRepresentable(
                                    text: .constant(paragraph.text),
                                    fontSize: 17,
                                    foregroundColor: UIColor(foregroundColor),
                                    lineSpacing: 5,
                                    highlightColor: .purple.withAlphaComponent(0.15),
                                    highlightedTextColor: .black,
                                    onShare: { quote in
                                        sharedQuote = quote
                                        if !sharedQuote.isEmpty {
                                            isShareQuotePresented = true
                                        }
                                    },
                                    onComment: { quote in
                                        selectedIndex = paragraphIndex
                                        selectedText = quote
                                        showComments = true
                                    },
                                    onHighlight: { (start, end) in
                                        isHighlightingActive = true
                                        showHighlightColors = true
                                        self.selectedChapterIndex = chapterIndex
                                        self.index = paragraphIndex
                                        self.start = start
                                        self.end = end
                                    }
                                )
                                .frame(height: heightForText(paragraph.text, fontSize: 17, width: geometry.size.width * 0.82, lineSpacing: 5))
                                
                                HStack {
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        CommentButton(index: index, chapterIndex: chapterIndex, showComments: $showComments, selectedIndex: $selectedIndex, ebook: book)
                                        
                                        Button(action: {
                                            showNotes = true
                                            selectedIndex = paragraphIndex
                                            selectedChapterIndex = chapterIndex
                                        }) {
                                            Text("\(book.chapters[chapterIndex].pages[paragraphIndex].notes.count) notes")
                                                .font(.system(size: 12))
                                                .foregroundColor(.black)
                                                .opacity(0.7)
                                        }
                                        .padding(.leading)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal, geometry.size.width * 0.10)
                    .padding(.top, 80)
                    .frame(width: UIScreen.main.bounds.width / 2.1)
                    
                }
            }*/
            
            GeometryReader { geometry in
            
                ZStack {
                    VStack {
                        ScrollView {
/*
                            VStack(alignment: .leading, spacing: 16) {
                                let processedBook = userData.user.applyAnnotationsToBook(ebook: book)

                                ForEach(Array(processedBook.chapters.enumerated()), id: \.element.id) { chapterIndex, chapter in
                                    ForEach(Array(chapter.paragraphs.enumerated()), id: \.element.id) { paragraphIndex, paragraph in
                                       CustomTextViewRepresentable(
                                            text: .constant(paragraph.text),
                                            fontSize: 17,
                                            foregroundColor: UIColor(foregroundColor),
                                            lineSpacing: 5,
                                            highlightColor: .purple.withAlphaComponent(0.15),
                                            highlightedTextColor: .black,
                                            onShare: { quote in
                                                sharedQuote = quote
                                                if !sharedQuote.isEmpty {
                                                    isShareQuotePresented = true
                                                }
                                            },
                                            onComment: { quote in
                                                selectedIndex = paragraphIndex
                                                selectedText = quote
                                                showComments = true
                                            },
                                            onHighlight: { (start, end) in
                                                isHighlightingActive = true
                                                showHighlightColors = true
                                                self.selectedChapterIndex = chapterIndex
                                                self.index = paragraphIndex
                                                self.start = start
                                                self.end = end
                                            }
                                        )
                                       .frame(height: heightForText(paragraph.text, fontSize: 17, width: geometry.size.width * 0.82, lineSpacing: 5))
                                       
                                        HStack {
                                            Spacer()
                                            VStack(alignment: .trailing) {
                                                CommentButton(index: index, chapterIndex: chapterIndex, showComments: $showComments, selectedIndex: $selectedIndex, ebook: book)
                                                
                                                Button(action: {
                                                    showNotes = true
                                                    selectedIndex = paragraphIndex
                                                    selectedChapterIndex = chapterIndex
                                                }) {
                                                    Text("\(book.chapters[chapterIndex].pages[paragraphIndex].notes.count) notes")
                                                        .font(.system(size: 12))
                                                        .foregroundColor(.black)
                                                        .opacity(0.7)
                                                }
                                                .padding(.leading)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.top)
                            .padding(.top, 80)
                            .padding(.horizontal)*/
            
                        }
                        .onAppear {
                            isVisible = true // Set boolean to true when view appears

                            // Use a timer to set boolean to false after 3 seconds
                            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
                                isVisible = false
                            }
                        }
                        .overlay(
                            VStack {
                                VStack {
                                    if isVisible && !audioModeOn {
                                        HStack {
                                            Spacer()
                                            Text(book.title)
                                                .font(.system(size: 15 + fontSize, weight: .medium))
                                                .frame(width: 190)
                                                .lineLimit(1)
                                            Spacer()
                                        }
                                        .foregroundColor(foregroundColor)
                                        .padding()
                                        .padding(.horizontal)
                                        .background(backgroundColor)
                                    }
                                    Spacer()
                                    if isVisible && !audioModeOn {
                                        HStack(alignment: .center) {
                                            ProgressBar(totalPages: book.ebook.getPageCount(), currentPage: book.ebook.getCurrentPage())
                                                .padding()
                                                .padding(.top)

                                            Spacer()

                                            HighlightKeyButton(isPresenting: $showHighlightKey)
                                            
                                            Button(action: {
                                                isPresenting.toggle()
                                            }){
                                                Image(systemName: "square.split.2x1")
                                            }
                                            Button(action: {
                                                audioModeOn = true
                                            }){
                                                Image(systemName: "play.fill")
                                            }
                                            .font(.system(size: 16))
                                            .padding()
                                            .foregroundColor(.black)
                                        }
                                        .padding(.horizontal)
                                        .frame(height: 70)
                                        .background(backgroundColor)
                                        
                                    }
                                    if audioModeOn {
                                        ScrollView {
                                            
                                            AudioPlayBar(isPresenting: $audioModeOn, book: book)
                                                .padding(.bottom, 60)
                                        }
                                    }
                                }
                                .onAppear {
                                    isVisible = true // Set boolean to true when view appears

                                    // Use a timer to set boolean to false after 3 seconds
                                    Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
                                        isVisible = false
                                    }
                                }
                            }
                        )
                        .onTapGesture {
                            isVisible.toggle()
                        }
                        .sheet(isPresented: $showComments) {
                            CommentsView( chapterIndex: selectedChapterIndex, index: selectedIndex, isPresenting: $showComments, book: book, initialCommentText: $selectedText)
                                .presentationDetents([.fraction(0.9)])
                        }
                        .sheet(isPresented: $showNotes) {
                            NotesView(isPresenting: $showNotes, showToolbar: $showToolbar, notes: book.ebook.pages[selectedIndex].notes, paragraph: book.ebook.pages[selectedIndex].text, showNote: $showNote, selectedNote: $selectedNote)
                                .presentationDetents([.fraction(0.9)])
                        }
                        .sheet(isPresented: $showAllNotes) {
                            ListNotes(addNew: .constant(false), notes: userData.user.getAllNotes(), showNote: $showNote, selectedNote: $selectedNote)
                         // AllNotesView(isPresenting: $showAllNotes, showToolbar: $showToolbar, addNew: .constant(false), notes: userData.user.getAllNotes(), book: book, showNote: $showNote, selectedNote: $selectedNote)
                                //.presentationDetents([.fraction(0.9)])
                        }
                        .background(backgroundColor)
                    }
                    
                   
                    if showHighlightKey {
                        HighlightKeyView(isPresenting: $showHighlightKey)
                    }
                    /*if showNote {
                        NoteView(isPresenting: $showNote, note: selectedNote)
                    }*/
                    if showHighlightColors {
                        HighlightColorPicker(isPresenting: $showHighlightColors, showKey: $showHighlightKey, chapterIndex: selectedChapterIndex, index: index, start: start, end: end, isHighlightingActive: $isHighlightingActive)
                    }
                }
                .background(backgroundColor)
            
                .frame(width: UIScreen.main.bounds.width / 2.1)
            }
            NotesPickerView(user: userData.user, selectedNotes: userData.user.getNotesByBookID(bookid: book.id), showToolbar: $showToolbar, selectedBook: $book)
                    .frame(width: UIScreen.main.bounds.width / 2.1)
            
        }
        .background(backgroundColor)

    }
    func heightForText(_ text: String, fontSize: CGFloat, width: CGFloat, lineSpacing: CGFloat) -> CGFloat {
        let textView = UITextView()
        textView.text = text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: fontSize)
        ]

        textView.attributedText = NSAttributedString(string: text, attributes: attributes)
        let size = textView.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
}
 */
/*
struct AllCharacters: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}*/

struct AddDropdown: View {
    @Binding var addBook: Bool
    @Binding var addNewNote: Bool
    @Binding var uploadPdf: Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        
        Menu {
            Button(action: {
                addBook.toggle()
            }){
                Text("Add Book")
                    .font(.system(size: 18))
            }
            .frame(width: 200, height: 100)
            
            Button(action: {
                
            }){
                Text("Upload PDF")
                    .font(.system(size: 18))
            }
            .frame(width: 200, height: 100)
            
            Button(action: {
                addNewNote.toggle()
            }){
                Text("Add Note")
                    .font(.system(size: 18))
            }
            .frame(width: 200, height: 100)
        
        } label: {
            // Cover image for the dropdown menu
            Image(systemName: "plus")
                .foregroundColor(.blue)
                .font(.system(size: 16, weight: .medium))
            
        }
        
        .foregroundColor(.black)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(backgroundColor)
        )
        
        
    }
}
struct AddView: View {
    @Binding var addBook: Bool
    @Binding var addNewNote: Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        VStack {
            Button(action: {
                addBook.toggle()
            }){
                Text("Add Book")
                    .font(.system(size: 18))
            }
            .frame(width: 200, height: 100)
            
            Button(action: {
                
            }){
                Text("Upload PDF")
                    .font(.system(size: 18))
            }
            .frame(width: 200, height: 100)
            
            Button(action: {
                addNewNote.toggle()
            }){
                Text("Add Note")
                    .font(.system(size: 18))
            }
            .frame(width: 200, height: 100)
        
        }
        .frame(width: 300, height: 400)
        .foregroundColor(.black)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(backgroundColor)
        )
        
        
    }
}
class NoteElement: Identifiable, Hashable {
    var id: UUID
    var isText: Bool
    var isImage: Bool
    var isDrawing: Bool
    var isQuote: Bool
    var isTerm: Bool
    var isCharacter: Bool
    var text: String?
    var image: UIImage?
    var drawing: PKDrawing?
    var quote: Quote?
    var term: Term?
    var character: Character?
    
    init(id: UUID = UUID(), isText: Bool = false, isImage: Bool = false, isDrawing: Bool = false, isQuote: Bool = false, isTerm: Bool = false, isCharacter: Bool = false, text: String? = nil, image: UIImage? = nil, drawing: PKDrawing? = nil, quote: Quote? = nil, term: Term? = nil, character: Character? = nil) {
        self.id = id
        self.isText = isText
        self.isImage = isImage
        self.isDrawing = isDrawing
        self.isQuote = isQuote
        self.isTerm = isTerm
        self.isCharacter = isCharacter
        self.text = text
        self.image = image
        self.drawing = drawing
        self.quote = quote
        self.term = term
        self.character = character
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        if isText, let text = text {
            hasher.combine(text)
        }
        if isImage, let image = image {
            hasher.combine(image.hashValue)
        }
        if isDrawing, let drawing = drawing {
            hasher.combine(drawing.dataRepresentation())
        }
    }
    
    static func ==(lhs: NoteElement, rhs: NoteElement) -> Bool {
        return lhs.id == rhs.id
    }
}




/*
struct NoteView: View {
    @Binding var isPresenting: Bool
    @State private var noteElements: [NoteElementType] = []
    @State var note: Note
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var editing = false
    @State var xoffset = 0.0
    @State var text = ""
    @State var draw = false
    @State var addingQuote = false
    @State var addingTerm = false
    @State var isShowingPhotoPicker = false
    @State var selectedImage: UIImage?
    @State var fullScreen = false
    @State var citing = false
    @State private var drawing = PKDrawing()


    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        isPresenting = false
                    }){
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    if !editing {
                        Text(timeSince(from: note.timestamp))
                            .font(.system(size: 13))
                            .opacity(0.7)
                            .padding(.trailing)
                        
                        Image(systemName: "ellipsis")
                            .font(.system(size: 16))
                    } else {
                        Button(action: {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }){
                            Text("Done")
                        }
                    }
                }
                .foregroundColor(.black)

                let read = userData.user.read(book: note.book)

                Image(note.book.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .shadow(radius: 0.5)
                    .padding(.top, 70)
                    .padding(.bottom)

                if note.title != "" {
                    Text(note.title)
                        .font(.system(size: horizontalSizeClass == .compact ? 16 : 17, weight: .medium))
                        .padding(.top, 2)
                }
                
                ForEach(noteElements) { element in
                    switch element {
                    case .text(let text):
                        @State var description = text
                        NoteTextEditor(text: $description, backgroundColor: UIColor(Color(hex: "#FDFAEF")))
                            .padding(.horizontal, -5)
                            .font(.system(size: horizontalSizeClass == .compact ? 14 : 15))
                            .lineSpacing(4)
                            .multilineTextAlignment(.leading)
                            .padding(note.title != ""  ? .vertical : .bottom)
                            .padding(.top, note.title == "" ? 2 : 0)
                            .onTapGesture {
                                editing = true
                            }
                    case .image(let image):
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                    case .drawing(let drawing):
                        CanvasView(drawing: drawing)
                    }
                }
/*
                NoteTextEditor(text: $note.description, backgroundColor: UIColor(Color(hex: "#FDFAEF")))
                    .padding(.horizontal, -5)
                    .font(.system(size: horizontalSizeClass == .compact ? 14 : 15))
                    .lineSpacing(4)
                    .multilineTextAlignment(.leading)
                    .padding(note.title != ""  ? .vertical : .bottom)
                    .padding(.top, note.title == "" ? 2 : 0)
                    .onTapGesture {
                        editing = true
                    }
*/
                
                
                if draw {
                    DrawingView(isDrawing: $draw, drawing: $drawing, onSave: { drawing in
                                        noteElements.append(.drawing(drawing))
                                    })
                }
                /*
                if note.quote.quote != "" {
                    QuoteView2(quote: note.quote)
                }

                */
                Spacer()

                HStack(spacing: 60) {
                    Button(action: {
                        draw = true
                    }){
                        Image(systemName: "pencil.line")
                    }
                    AddQuoteButton(addingQuote: $addingQuote)
                    AddTermButton(addingTerm: $addingTerm)

                    Button(action: {
                        isShowingPhotoPicker = true
                    }) {
                        Image(systemName: "photo")

                    }
                    .sheet(isPresented: $isShowingPhotoPicker) {
                        PhotoPicker(image: $selectedImage)
                        if let image = selectedImage {
                             noteElements.append(.image(image))
                         }
                    }

                    Button(action: {
                        // Add text action
                    }) {
                        Text("Text")
                            .font(.system(size: 14))
                        //Image(systemName: "textformat.size.smaller")
                    }
                    Button(action: {
                        citing = true
                    }){
                        Text("Cite")
                            .font(.system(size: 14))

                    }
                    Spacer()
                    Button(action: {
                        fullScreen = true
                    }){
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .font(.system(size: 14))
                            .padding(.trailing, -12)
                    }

                }
                .font(.system(size: 18))
            }
            .sheet(isPresented: $addingQuote) {
                QuoteForm(isPresenting: $addingQuote, note: note)
                    .presentationDetents([.fraction(0.9)])
            }
            .sheet(isPresented: $addingTerm) {
                AddTermForm(isPresenting: $addingTerm, note: note)
                    .presentationDetents([.fraction(0.9)])
            }
            .padding()
            .padding(.horizontal, horizontalSizeClass != .compact ? 20 : 0)
            .padding(.top)
            .background(backgroundColor)
            .onTapGesture { }
            .onLongPressGesture(minimumDuration: 1) { }

            .offset(x: xoffset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width > 0 {
                            self.xoffset = gesture.translation.width
                        }
                    }
                    .onEnded { _ in
                        if self.xoffset > UIScreen.main.bounds.width / 2.2 {
                            self.xoffset = UIScreen.main.bounds.width
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                isPresenting = false
                            }
                        } else {
                            self.xoffset = 0
                        }
                    }
            )
            .animation(.easeOut, value: xoffset)
            
            if editing {
                NoteEditor(isPresenting: $editing, note: $note)
            }
            
            if citing {
                CitationPopUp(citation: Citation(author: note.book.author.name, title: note.book.title, year: Int(note.book.year)!, publisher: "Unknown Publisher"))
            }
        }
    }
    
    private func addTextElement() {
        let text = "New Text"
        noteElements.append(.text(text))
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
            return "Just now"
        }
    }
}*/


/*
enum NoteElementType: Identifiable, Hashable {
    case text(String)
    case image(UIImage)
    case drawing(PKDrawing)
    
    var id: UUID {
        switch self {
        case .text(let text):
            return UUID(uuidString: String(text.hashValue)) ?? UUID()
        case .image(let image):
            return UUID(uuidString: String(image.hashValue)) ?? UUID()
        case .drawing(let drawing):
            return UUID(uuidString: drawing.dataRepresentation().hashValue.description) ?? UUID()
        }
    }
    
    static func == (lhs: NoteElementType, rhs: NoteElementType) -> Bool {
        switch (lhs, rhs) {
        case (.text(let text1), .text(let text2)):
            return text1 == text2
        case (.image(let image1), .image(let image2)):
            return image1.pngData() == image2.pngData()
        case (.drawing(let drawing1), .drawing(let drawing2)):
            return drawing1.dataRepresentation() == drawing2.dataRepresentation()
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .text(let text):
            hasher.combine(text)
        case .image(let image):
            hasher.combine(image.pngData())
        case .drawing(let drawing):
            hasher.combine(drawing.dataRepresentation())
        }
    }
}*/
struct QuoteView2: View {
    var quote: Quote
    var body: some View {
        VStack(alignment: .leading){
            Text("\"\(quote.quote)\"")
            Text("——— \(quote.speaker.name)")
            Text("chapter \(quote.chapter), page \(quote.pageNumber)")
                .font(.system(size: 12))
                .opacity(0.7)
        }
        .foregroundColor(Color(.blue).opacity(0.7))
        .font(.system(size: 15))
    }
}

struct QuoteCard: View {
    var quote: Quote
    var color: String
    var body: some View {
        Button(action: {
            
        }){
            
                    VStack(alignment: .leading) {
                        /*Text(quote.title)
                            .padding(.bottom)
                            .font(.system(size: 16, weight: .medium))
                            .multilineTextAlignment(.leading)*/
                        HStack {
                            Text("\"")
                                .font(.custom("Georgia", size: 20))
                            Spacer()

                        }
                        
                        Text(quote.quote)
                            .font(.custom("Georgia-Italic", size: 14))
                            //.font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                            .lineLimit(5)
                            .lineSpacing(3)
                        
                        Button(action: {
                            
                        }){
                            Text("page \(quote.pageNumber)")
                                .font(.system(size: 12.5))
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 2)
                        
                        Button(action: {
                            
                        }){
                            Text("- \(quote.speaker.name)")
                                .font(.system(size: 12.5))
                                .foregroundColor(.blue)
                        }
                        
                    }
                        .foregroundColor(.black)
                        .frame(width: 200)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(Color(hex: "#ECE8DA").opacity(0.3))
                                //.stroke(Color.gray.opacity(0.9), lineWidth: 0.9)
                        )
                
        }
        .padding(.vertical)
    }
}
struct CitationPopUp: View {
    var citation: Citation
    var backgroundColor = Color(hex: "#FDFAEF")
    var body: some View{
        VStack {
            CitationButton(citation: citation)
        }
        .frame(width: UIScreen.main.bounds.width * 0.35)
        .background(backgroundColor)
    }
}

/*
 CitationButton(citation: Citation(author: note.book.author.name, title: note.book.title, year: Int(note.book.year)!, publisher: "Unknown Publisher"))
 */

struct AddTermButton: View {
    @Binding var addingTerm: Bool
    
    var body: some View {
        Button(action :{
            addingTerm = true
        }){
            Label("Add Term", systemImage: "character.book.closed")
        }
    }
}

struct AddTermForm: View {
    @Binding var isPresenting: Bool
    @ObservedObject var note: Note
    @State private var term: String = ""
    @State private var meaning: String = ""
    @State private var examples: [Quote] = []
    @State private var newQuoteText: String = ""
    @State private var newSpeaker: String = ""
    @State private var newChapter: String = ""
    @State private var newPageNumber: String = ""
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var userData: UserData
    // Dummy book and character for initialization
    let book = Book(title: "Sample Book")
    let character = Character(name: "Sample Character")

    var body: some View {
        ZStack {
            VStack {
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color(.black).opacity(0.6))
            .onTapGesture {
                isPresenting.toggle()
            }
            VStack {
                HStack {
                    Text("Term: ")
                    TextField("Enter term", text: $term)
                }
                .padding(.vertical)
                HStack {
                    Text("Meaning: ")
                    TextField("Enter meaning", text: $meaning)
                }
                .padding(.bottom)
                
                /*
                 ForEach(examples.indices, id: \.self) { index in
                 VStack(alignment: .leading) {
                 Text("Quote \(index + 1): \(examples[index].quote)")
                 Text("Speaker: \(examples[index].speaker.name)")
                 Text("Chapter: \(examples[index].chapter)")
                 Text("Page Number: \(examples[index].pageNumber)")
                 }
                 .padding(.vertical, 5)
                 
                 
                 VStack(alignment: .leading) {
                 TextField("Enter quote", text: $newQuoteText)
                 TextField("Enter speaker's name", text: $newSpeaker)
                 TextField("Enter chapter number", text: $newChapter)
                 .keyboardType(.numberPad)
                 TextField("Enter page number", text: $newPageNumber)
                 .keyboardType(.numberPad)
                 Button(action: {
                 if let newQuote = createQuote() {
                 examples.append(newQuote)
                 clearNewQuoteFields()
                 }
                 }) {
                 Text("Add Example")
                 .frame(maxWidth: .infinity)
                 .foregroundColor(.white)
                 .padding()
                 .background(Color.blue)
                 .cornerRadius(8)
                 }
                 }
                 .padding(.vertical, 10)
                 }*/
                Spacer()
                
                Button(action: {
                    let newTerm = Term(term: term, meaning: meaning, examples: examples)
                    note.elements.append(NoteElement(isTerm: true, term: newTerm))
                    isPresenting = false
                    userData.user.addTerm(bookid: note.book.id, term: newTerm)
                    print("New Term created: \(newTerm)")
                    // Perform any additional actions with the new term
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(8)
                }
            }
            .padding()
            .frame(width: 500, height: 700)
            .background(backgroundColor)
            
            
            
            
        }
    }

    func createQuote() -> Quote? {
        guard let chapterNumber = Int(newChapter), let pageNumberValue = Int(newPageNumber) else {
            return nil
        }
        let quote = Quote(quote: newQuoteText, book: book, speaker: character, chapter: chapterNumber, pageNumber: pageNumberValue)
        return quote
    }

    func clearNewQuoteFields() {
        newQuoteText = ""
        newSpeaker = ""
        newChapter = ""
        newPageNumber = ""
    }
}
struct SearchCharactersBar: View {
    @State var searchText = ""
    @State var searched = false
    @State var placeholder = "Search your characters"
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks: Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    @State var showList = false
    @State var selectedList = List(id: UUID(), title: "", books: [])
    @EnvironmentObject var userData: UserData
    @State var xoffset = 0.0
    //@State var database: [Book]
    @Binding var selectedCharacter: Character?
    @State var book: Book
    

    var body: some View {
        VStack {
            ZStack {
                TextField(placeholder, text: $searchText)
                    .onTapGesture {
                        isTextFieldFocused = true
                    }
                    .font(.system(size: 16.5))
                    .foregroundColor(.black)
                    .padding(10)
                    .padding(.vertical, 2)
                    .padding(.leading, 30)
                    .onSubmit {
                        searched = true
                        isTextFieldFocused = false
                    }
                    .onChange(of: searchText) { _ in
                        searched = false
                        isGenre = false
                    }
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            Spacer()
                        }
                    )
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .padding(3)
                HStack {
                    Spacer()
                    if searchText != "" || isTextFieldFocused {
                        Button("Cancel") {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            searchText = ""
                            isTextFieldFocused = false
                        }
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                        .padding(.trailing)
                    }
                }
                .padding(.trailing)
            }
            Spacer()
        
               // ScrollView {
            let characters = userData.user.getAllBookCharacters(bookid: book.id)
                var filteredCharacters: [Character] {
                    if searchText.isEmpty {
                        return characters
                    } else {
                        return characters.filter { character in
                            character.name.localizedCaseInsensitiveContains(searchText)
                        }
                    }
                }
                if !characters.isEmpty {
                    let columns = splitCharactersList(characters: characters, into: 3)
                
                    GeometryReader { geometry in
                        ScrollView{
                            VStack {
                                
                                HStack(alignment: .top, spacing: 10) { // Adjust spacing as necessary
                                    ForEach(0..<3) { columnIndex in
                                        LazyVStack(spacing: 20) {
                                            ForEach(columns[columnIndex], id: \.self) { character in
                                                
                                                VStack(alignment: .leading) {
                                                    CharacterCard(character: .constant(character), user: userData.user, showCharacter: .constant(false), selectedCharacter: .constant(nil), onTapped: {
                                                        selectedCharacter = character

                                                        
                                                    })
                                                        
                                                    
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                                
                                            }
                                            
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                
                            }
                        }
                        .background(backgroundColor)
                        }
                    }
                        
                        
        }
            
                .padding(.top)

             //   }
            
        
        .background(backgroundColor)
    }
    private func splitCharactersList(characters: [Character], into columnCount: Int) -> [[Character]] {
        var columns: [[Character]] = Array(repeating: [], count: columnCount)
        for (index, character) in characters.enumerated() {
            let columnIndex = index % columnCount
            columns[columnIndex].append(character)
        }
        return columns
    }
}


struct CharacterForm: View {
        @Binding var isPresenting: Bool
        @ObservedObject var note: Note
        
        @State private var name: String = ""
        @State private var description: String = ""
        @State private var selectedImage: UIImage? = nil
        @State private var isShowingPhotoPicker = false
        @EnvironmentObject var userData: UserData
        @State var selectedCharacter: Character? = nil
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        VStack {
            HStack {
                Text("CHOOSE CHARACTER")
                    .font(.system(size: 14))
                    .opacity(0.7)
                Spacer()
            }
            SearchCharactersBar(selectedCharacter: $selectedCharacter, book: note.book)
            
            
            if selectedCharacter == nil {
                HStack {
                    
                    Text("NEW CHARACTER")
                        .font(.system(size: 14))
                        .opacity(0.7)
                    Spacer()
                }
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    
                    Button(action: {
                        isShowingPhotoPicker = true
                    }) {
                        Text("Select Photo")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.blue)
                            .padding()
                            .cornerRadius(8)
                    }
                
                
                
                Button(action: {
                    
                    
                    let newCharacter = Character( name: name, description: description, bookid: note.book.id)
                    if let image = selectedImage {
                        newCharacter.photo = saveImageToDocuments(image: image)
                    }
                    newCharacter.addNoteReference(noteid: note.id)
                    note.elements.append(NoteElement(isCharacter: true, character: newCharacter)) // Assuming NoteElement takes a name for the term
                    isPresenting = false
                    
                    print("New character created: \(newCharacter)")
                    
                    userData.user.addCharacter(bookid: note.book.id, character: newCharacter)
                    
                    // Perform any additional actions with the new term
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            } else {
                
                Button(action: {
                    if let character = selectedCharacter {
                        character.addNoteReference(noteid: note.id)
                        note.elements.append(NoteElement(isCharacter: true, character: character))
                        isPresenting = false
                        
                        
                    }
                }){
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            
        }
        .padding()
                .sheet(isPresented: $isShowingPhotoPicker) {
                    PhotoPicker(selectedImage: $selectedImage) { image in
                        selectedImage = image
                    }
                }
                .background(backgroundColor)

        
    }
    private func saveImageToDocuments(image: UIImage) -> String {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return "" }
        let filename = UUID().uuidString + ".jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        try? data.write(to: url)
        return url.path // Return the local path
    }
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

}

struct AudioPlayBar: View {
    @Binding var isPresenting: Bool
    @State private var isPlaying = false
    @State private var progress: Double = 0.0 // To track the progress of the audiobook
    @State private var volume: Double = 0.0 // To conrol the volume

    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var book = Book()
    
    var body: some View {
        VStack {
            VStack {
                /*
                 Text("Ch. 3")
                 .font(.system(size: 15, weight: .medium))
                 .lineLimit(1)
                 Spacer()*/
                Image(book.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 0.5)
                    .padding(.top, 70)
                    .padding(.bottom)
                
               
                Spacer()
                HStack {
                    VStack(alignment: .leading){
                        Text(book.title)
                            .font(.system(size: 18, weight: .medium))

                        Text(book.author.name)
                            .font(.system(size: 13))
                        
                        Text("CH 1")
                            .font(.system(size: 12))
                        
                    }
                    Spacer()
                }
                SlideableProgressView(value: $progress)
                    
                HStack {
                    Text("00:00")
                        .font(.system(size: 13))
                    Spacer()
                    Text("45:00") // Example total time
                        .font(.system(size: 13))
                    
                }
                .padding(.top)
                

                
            }
            
            
            HStack {
                Button(action: {
                    // Previous action
                }) {
                    Image(systemName: "gobackward.15")
                }
                .padding(.leading, UIScreen.main.bounds.width * 0.2)
                Spacer()
                
                Button(action: {
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 35))
                }
                
                Spacer()
                
                Button(action: {
                    // Next action
                }) {
                    Image(systemName: "goforward.15")

                }
                .padding(.trailing, UIScreen.main.bounds.width * 0.2)

            }
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.bottom)
            HStack {
                Image(systemName: "volume")
                    .font(.system(size: 14))
                SlideableProgressView(value: $volume)
                Image(systemName: "speaker.wave.2")
                    .font(.system(size: 14))

            }
            
            Button("Read Mode"){
                isPresenting = false
            }
            .font(.system(size: 16))
            .padding()
            .foregroundColor(.white)
            .background(.black)
            .cornerRadius(10)
        }
        .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
        .padding(.horizontal)
        .padding(.vertical)
        .padding()
        .background(backgroundColor)
    }
}

struct SlideableProgressView: View {
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background track
                Capsule()
                    .frame(height: 4)
                    .foregroundColor(Color.gray.opacity(0.5))
                
                // Progress track
                Capsule()
                    .frame(width: geometry.size.width * CGFloat(value), height: 4)
                    .foregroundColor(.blue)
                
                // Thumb
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.blue)
                    .offset(x: geometry.size.width * CGFloat(value) - 8)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                let newValue = min(max(0, gesture.location.x / geometry.size.width), 1)
                                value = newValue
                            }
                    )
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 30) // Adjust height to fit the slider and thumb
    }
}



struct CommentsView: View {
    @State var chapterIndex: Int
    @Binding var index: Int
    @Binding var isPresenting: Bool
    @State var replying = false
    @State var replyTo = Comment()
    @ObservedObject var book: Book
    @Binding var initialCommentText: String  // Binding for initial comment text
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        
        VStack {
            ScrollView {
                HStack {
                    Spacer()

                    Text("Comments")
                        .font(.system(size: 15))
                    Spacer()
                }
                .padding(.top)
                
                HStack {
                    Spacer()
                    Text(book.title)
                        .font(.system(size: 14, weight: .medium))
                        .padding(.trailing, -2)
                    
                    Text("page \(index + 1)")
                        .font(.system(size: 13))

                    Spacer()
                }
                .padding(.bottom)
                VStack(spacing: 14) {
                    let comments = book.ebook.pages[index].comments
                    HStack(alignment: .top) {
                                            
                        Text(book.ebook.pages[index].text)
                                .lineLimit(3)
                                .font(.system(size: 13))
                                .opacity(0.7)
                                .lineSpacing(4)
                        }
                        .padding(.bottom, 30)
                    
                        HStack {
                            ReactionView(ebook: book.ebook, index: index)
                            Spacer()
                            
                            
                        }
                        .padding(.bottom)
                    
                    ForEach(comments) { comment in
                        if !comment.isReply {
                            EComment(comment: comment, replying: $replying, replyTo: $replyTo)
                        }
                    }
                }
                .padding()
            }
            Spacer()
            ReaderCommentField(book: book, commentIndex: index, chapterIndex: chapterIndex, replying: $replying, replyTo: $replyTo, initialCommentText: $initialCommentText)
        }
        //.frame(width: UIScreen.main.bounds.width)
        .background(lightModeController.getBackgroundColor())
        .foregroundColor(lightModeController.getForegroundColor())
    }
}

struct ReviewCommentSection: View {
    @State var review: Review
    @State var comments: [Comment]
    @State var replying = false
    @State var replyTo = Comment()
    
    var body: some View {
        
        VStack{
                ForEach(comments) { comment in
                    if !comment.isReply {
                        EComment(comment: comment, replying: $replying, replyTo: $replyTo)
                    }
                }
            
            ReviewCommentField(review: review, replying: $replying, replyTo: $replyTo)
            
        }
    }
}

struct ReviewCommentField: View {
    @State private var comment: String = ""
    @State var review: Review
    @EnvironmentObject var userData: UserData
    @Binding var replying: Bool
    @Binding var replyTo: Comment
    @State var initialCommentText: String = ""
    @State var selectedImage: String? = nil
    @State var showReactionLibrary = false
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        VStack {
            
            if !showReactionLibrary {
                
                HStack{
                    Button(action: {
                        showReactionLibrary.toggle()
                    }) {
                        HStack{
                            Text("MEMES")
                                .font(.system(size:13.5, weight: .medium))
                                .foregroundColor(lightModeController.getForegroundColor())
                        }
                        
                    }
                    .padding(3)
                    .padding(.horizontal, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.black.opacity(0.4), lineWidth: 0.6)
                            .fill(showReactionLibrary ? Color(.blue).opacity(0.2) : Color(.gray).opacity(0.1))
                        
                    )
                    .padding(.trailing, 10)
                    Spacer()

                    //ReactionButtons(ebook: book.ebook, index: commentIndex)
                    
                    
                }
            }
            
            if showReactionLibrary && selectedImage == nil {
                ReactionLibraryView(isPresenting: $showReactionLibrary, selectedImage: $selectedImage)
            }
                
        
            HStack {
                HighlightedText(text: initialCommentText, frameWidth: 320, lineSpacing: 2.0)
                    .padding(.bottom)
                Spacer()
            }
        }
        .padding(.horizontal, 4)
        .padding(.horizontal)
        
        if replying {
            HStack {
                Text("Replying to \(replyTo.user.name)")
                    .font(.system(size: 14, weight: .medium))
                Button(action: { replying.toggle() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        
        if let img = selectedImage {
            HStack(alignment: .top) {
                
                    Image(img)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(5)
                        .onTapGesture {
                            selectedImage = nil
                        }
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 7))
                        .foregroundColor(Color(.gray).opacity(0.2))
                        .padding(.leading, -4)
                        .onTapGesture {
                            selectedImage = nil
                        }
                
                Spacer()
            }
            .padding(.leading, 20)

        }
        
        HStack(alignment: .bottom) {
            ProfileThumbnail(image: userData.user.photo, size: 25)
                .padding(.bottom)
         
                
                TextField("Leave a comment...", text: $comment)
                    .padding(.bottom)
                    .padding(.horizontal, 4)
                    .cornerRadius(5)
                    .font(.system(size: 16))
                    .padding(.trailing)
                    .overlay(
                        HStack{
                            Spacer()
                            if !comment.isEmpty || selectedImage != nil{
                                Button(action: {
                                    submitComment()
                                }) {
                                    Image(systemName: "arrow.up.circle.fill")
                                        .font(.system(size: 15))
                                        .opacity(0.7)
                                }
                            }
                        }
                    )
        }
        .padding(.bottom)
        .padding(.horizontal)
        .background(lightModeController.getBackgroundColor())
        .foregroundColor(lightModeController.getForegroundColor())    }

    private func submitComment() {
        var newComment = Comment(id: UUID(), user: userData.user, comment: comment, likes: 0, timestamp: Date(), isReply: false)
        
        if let react_image = selectedImage {
            newComment.addImage(image: react_image)
        }
        
        if replying {
            newComment.replyTo = replyTo
            newComment.isReply = true
            replyTo.replies.append(newComment)
        }
        if !initialCommentText.isEmpty{
            newComment.hasQuote = true
            newComment.quote = Quote2(quote: initialCommentText, book: review.rating.book)
        }
        review.addComment(comment: newComment)
        
        replying = false
        comment = ""
        initialCommentText = ""
        selectedImage = nil
        showReactionLibrary = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
}

struct ReaderCommentField: View {
    @State private var comment: String = ""
    @ObservedObject var book: Book
    @State var commentIndex: Int
    @State var chapterIndex: Int
    @EnvironmentObject var userData: UserData
    @Binding var replying: Bool
    @Binding var replyTo: Comment
    @Binding var initialCommentText: String  // Binding for initial comment text
    @State var selectedImage: String? = nil
    @State var showReactionLibrary = false
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        VStack {
            
            if !showReactionLibrary {
                
                HStack{
                    Button(action: {
                        showReactionLibrary.toggle()
                    }) {
                        HStack{
                            Text("MEMES")
                                .font(.system(size:13.5, weight: .medium))
                                .foregroundColor(lightModeController.getForegroundColor())
                        }
                        
                    }
                    .padding(3)
                    .padding(.horizontal, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.black.opacity(0.4), lineWidth: 0.6)
                            .fill(showReactionLibrary ? Color(.blue).opacity(0.2) : Color(.gray).opacity(0.1))
                        
                    )
                    .padding(.trailing, 10)
                    
                    ReactionButtons(ebook: book.ebook, index: commentIndex)
                    
                    
                }
            }
            
            if showReactionLibrary && selectedImage == nil {
                ReactionLibraryView(isPresenting: $showReactionLibrary, selectedImage: $selectedImage)
            }
                
        
            HStack {
                HighlightedText(text: initialCommentText, frameWidth: 320, lineSpacing: 2.0)
                    .padding(.bottom)
                Spacer()
            }
        }
        .padding(.horizontal, 4)
        .padding(.bottom)
        .padding(.horizontal)
        
        if replying {
            HStack {
                Text("Replying to \(replyTo.user.name)")
                    .font(.system(size: 14, weight: .medium))
                Button(action: { replying.toggle() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        
        if let img = selectedImage {
            HStack(alignment: .top) {
                
                    Image(img)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(5)
                        .onTapGesture {
                            selectedImage = nil
                        }
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 7))
                        .foregroundColor(Color(.gray).opacity(0.2))
                        .padding(.leading, -4)
                        .onTapGesture {
                            selectedImage = nil
                        }
                
                Spacer()
            }
            .padding(.leading, 20)

        }
        
        HStack(alignment: .bottom) {
            ProfileThumbnail(image: userData.user.photo, size: 25)
                .padding(.bottom)
         
                
                TextField("Leave a comment...", text: $comment)
                    .padding(.bottom)
                    .padding(.horizontal, 4)
                    .cornerRadius(5)
                    .font(.system(size: 16))
                    .padding(.trailing)
                    .overlay(
                        HStack{
                            Spacer()
                            if !comment.isEmpty || selectedImage != nil{
                                Button(action: {
                                    submitComment()
                                }) {
                                    Image(systemName: "arrow.up.circle.fill")
                                        .font(.system(size: 15))
                                        .opacity(0.7)
                                }
                            }
                        }
                    )
        }
        .padding(.bottom)
        .padding(.horizontal)
        .background(lightModeController.getBackgroundColor())
        .foregroundColor(lightModeController.getForegroundColor())    }

    private func submitComment() {
        var newComment = Comment(id: UUID(), user: userData.user, comment: comment, likes: 0, timestamp: Date(), isReply: false)
        
        if let react_image = selectedImage {
            newComment.addImage(image: react_image)
        }
        
        if replying {
            newComment.replyTo = replyTo
            newComment.isReply = true
            replyTo.replies.append(newComment)
        }
        if !initialCommentText.isEmpty{
            newComment.hasQuote = true
            newComment.quote = Quote2(quote: initialCommentText, book: book)
        }
        replying = false
        book.ebook.pages[commentIndex].addComment(index: commentIndex, comment: newComment)
        comment = ""
        initialCommentText = ""
        selectedImage = nil
        showReactionLibrary = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct CommentButton: View {
    var index: Int
    @Binding var showComments: Bool
    @Binding var selectedIndex: Int
    @ObservedObject var ebook: SphereEBook

    var body: some View {
        Button(action: {
            selectedIndex = index
            showComments = true
        }) {
            Text("\(formatLargeNumber(ebook.pages[index].comments.count)) comments")
                .font(.system(size: 14))
                .opacity(0.7)
                .padding(3)
                .padding(.horizontal, 6)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.black.opacity(0.4), lineWidth: 0.6)
                        .fill(Color(.gray).opacity(0.1))
                    
                )
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
}

struct NewNote: View {
    @State var header = ""
    @State var text = ""
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Header (optional)", text: $header)
            CustomTextEditor(text: $text, placeholder: "Text...")
            
            Button(action: { }){
                Text("Done")
            }
        }
        .padding()
        .background(Color(hex: "#ECE8DA"))

       
    }
}

struct NoteView2: View {
    //@State var notes: [Note]
    @EnvironmentObject var lightModeController: LightModeController
    @State var searchText = ""
    @State private var searched = false

    @State var placeholder = "Search book notes..."
    @State var isTextFieldFocused = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                /*Image("down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)*/
                /*
                if !lightModeController.isDarkMode(){
                    Image("Sphere-Dark-Logo-Text-250px")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 85)
                        .padding()
                    
                } else {
                    Image("Sphere-Light-Logo-Text-250px")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 85)
                        .padding()
                    
                    
                }*/
                Spacer()
            }
            .padding(.top)
            HStack {
                TextField(placeholder, text: $searchText)
                    .onTapGesture {
                        // When the TextField is tapped, set isTextFieldFocused to true
                        isTextFieldFocused = true
                    }
                    .font(.system(size: 16.5))
                    .foregroundColor(lightModeController.getForegroundColor())
            
                    .padding(10)
                    .padding(.vertical, 2)
                    .padding(.leading, 30)
                    .onSubmit {
                        searched = true
                        isTextFieldFocused = false
                    }
                    .onChange(of: searchText){
                        searched = false
                        
                    }
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(lightModeController.getForegroundColor())
                                .padding(.leading, 10)
                            Spacer()
                        }
                    )
                    .background(lightModeController.getForegroundColor().opacity(0.05))
                    .cornerRadius(10)
                    .padding(3)
                    .padding(searchText != "" ? .leading : .horizontal)

                
                if searchText != "" || isTextFieldFocused {
                    Button("Cancel") {
                        // Close keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        // Empty search text
                        searchText = ""
                        isTextFieldFocused = false

                    }
                    .foregroundColor(lightModeController.getForegroundColor())
                    .font(.system(size: 14))
                    .padding(.trailing)
                }
            }
            HStack {
      
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("Two Nurses, Smoking")
                                .font(.system(size: 17, weight: .medium))
                            Spacer()
                            ChapterDropdown(selectedChapter: "All Chapters")

                        }
                        /*Text("Chapter 1")
                            .font(.subheadline)
                       */
                        Text("Header 1")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.vertical)
                        
                        NoteBodyText(text: "Don’t let other people bother you! You don’t have to prove yourself to anyone. In this life, you just have you. Treat yourself with kindness love and respect. Radiate positive energy. But don’t let youself be walked all over. Don’t let other people bother you! You don’t have to prove yourself to anyone. In this life, you just have you. Treat yourself with kindness love and respect. Radiate positive energy. But don’t let youself be walked all over. Don’t let other people bother you! You don’t have to prove yourself to anyone. In this life, you just have you. Treat yourself with kindness love and respect. Radiate positive energy. But don’t let youself be walked all over.")
                            .font(.system(size: 14))
                        
                        Text("Header 2")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.vertical)

                        
                        NoteBodyText(text: "Don’t let other people bother you! You don’t have to prove yourself to anyone. In this life, you just have you. Treat yourself with kindness love and respect. Radiate positive energy. But don’t let youself be walked all over.")
                            .font(.system(size: 14))
                        
                        Text("Header 3")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.vertical)

                        
                        NoteBodyText(text: "Don’t let other people bother you! You don’t have to prove yourself to anyone. In this life, you just have you. Treat yourself with kindness love and respect. Radiate positive energy. But don’t let youself be walked all over. Don’t let other people bother you! You don’t have to prove yourself to anyone. In this life, you just have you. Treat yourself with kindness love and respect. Radiate positive energy. But don’t let youself be walked all over.")
                            .font(.system(size: 14))
                        
                        
                        Text("Header 4")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.vertical)

                        
                        NoteBodyText(text: "Don’t let other people bother you! You don’t have to prove yourself to anyone. In this life, you just have you. Treat yourself with kindness love and respect. Radiate positive energy. But don’t let youself be walked all over. Don’t let other people bother you! You don’t have to prove yourself to anyone. In this life, you just have you. Treat yourself with kindness love and respect. Radiate positive energy. But don’t let youself be walked all over. Don’t let other people bother you! You don’t have to prove yourself to anyone. In this life, you just have you. Treat yourself with kindness love and respect. Radiate positive energy. But don’t let youself be walked all over. Don’t let other people bother you! You don’t have to prove yourself to anyone. In this life, you just have you. Treat yourself with kindness love and respect. Radiate positive energy. But don’t let youself be walked all over.")
                            .font(.system(size: 14))

                        
                    }

                    .padding(.trailing)
                }
                Spacer()
          
            }
            .padding(.top, 40)
            .padding()
            
        }
        .padding(.horizontal)
        .padding(.horizontal)
        .background(lightModeController.getBackgroundColor())

    }
}

struct NoteBodyText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 15))
            .lineLimit(7)
            .lineSpacing(4)
            .multilineTextAlignment(.leading)
    }
}

struct ChapterButton: View {
    var number: Int = 1
    var body: some View {
        Button(action: {
            
        }){
            Text("Chapter \(number)")
                .font(.system(size: 14, weight: .semibold))

        }
    }
}
// add animation goes into the notes tab

struct AIAssistantButton: View {
    @Binding var showAssistant: Bool
    //@ObservedObject var ebook: SphereEBook
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        Button(action: {
            showAssistant.toggle()
        }) {
            Image(systemName: "sparkle")
                .font(.system(size: 14))
                .frame(width: 42, height: 38)
                .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#ECE8DA").opacity(0.5))
                .cornerRadius(10)
        }
        .background(lightModeController.getBackgroundColor())

    }
}

struct AIChatBoxView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        VStack(alignment: .leading) {
            // Chatbox header
            HStack {
                Image(systemName: "sparkle")
                Spacer()
            }
            .padding()
            .foregroundColor(lightModeController.getBackgroundColor().opacity(0.7))
            .background(lightModeController.getForegroundColor())
            
            /*
            // Chatbox body - You can replace this with dynamic content
            ScrollView {
                Text("How can I assist you?")
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding()
            }
            */
            
            // Quick actions
            HStack {
                // Quick action: Recap
                Button(action: {
                    // Add your forget functionality here
                }) {
                  
                    Text("Recap")
                            
                    .font(.subheadline)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lightModeController.getForegroundColor().opacity(0.4)
                    )
                        )
                }
                
                

                // Quick action: Summarize
                
                Button(action: {
                    // Add your summarize functionality here
                }) {
                    Text("Bookmark this page")
                        .font(.subheadline)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lightModeController.getForegroundColor().opacity(0.4))
)                }
                
                Button(action: {
                    // Add your summarize functionality here
                }) {
                    Text("Summarize this page")
                        .font(.subheadline)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lightModeController.getForegroundColor().opacity(0.4))
)                }
            }
            .font(.system(size: 14))
            .padding([.leading, .trailing, .bottom])
/*
            // Create new note button
            Button(action: {
                // Add your create note functionality here
            }) {
                Text("Create new note")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }*/
        }
        .foregroundColor(lightModeController.getForegroundColor())
        .background(lightModeController.getBackgroundColor())
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}

struct CustomTextViewRepresentable: UIViewRepresentable {
    @Binding var text: String
    var fontSize: CGFloat
    var foregroundColor: UIColor
    var lineSpacing: CGFloat
    var highlightColor: UIColor
    var highlightedTextColor: UIColor
    var onShare: (String) -> Void  // Callback for sharing the quote
    var onComment: (String) -> Void  // Callback for commenting
    var onHighlight:  (Int, Int) -> Void
    
    func makeUIView(context: Context) -> UITextView {
        let textView = CustomTextView()
        textView.font = UIFont(name: "Baskerville", size: fontSize)
        textView.backgroundColor = .clear
        textView.isSelectable = true
        textView.isEditable = false
        textView.delegate = context.coordinator
        textView.onShare = onShare  // Assign the callback
        textView.onComment = onComment  // Assign the callback
        textView.onHighlight = onHighlight
        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        textView.attributedText = createAttributedString(from: text)
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
    }

    private func createAttributedString(from text: String) -> NSAttributedString {
        let parsedText = parseText(text)
        let attributedString = NSMutableAttributedString()

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        for (substring, isHighlighted) in parsedText {
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: paragraphStyle,
                .font: UIFont(name: "Baskerville", size: fontSize),
                .foregroundColor: isHighlighted ? highlightedTextColor : foregroundColor,
                .backgroundColor: isHighlighted ? highlightColor : UIColor.clear
            ]

            let attributedSubstring = NSAttributedString(string: substring, attributes: attributes)
            attributedString.append(attributedSubstring)
        }

        return attributedString
    }

    private func parseText(_ text: String) -> [(String, Bool)] {
        var result: [(String, Bool)] = []
        let pattern = "(<hi>.*?</hi>)"
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let nsString = text as NSString
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: nsString.length))

        var lastRangeEnd = 0
        var isHighlighted = false

        for match in matches {
            let matchRange = match.range
            if matchRange.location > lastRangeEnd {
                let normalText = nsString.substring(with: NSRange(location: lastRangeEnd, length: matchRange.location - lastRangeEnd))
                result.append((normalText, isHighlighted))
            }
            
            let highlightedText = nsString.substring(with: matchRange)
            if highlightedText.hasPrefix("<hi>") && highlightedText.hasSuffix("</hi>") {
                result.append((highlightedText.replacingOccurrences(of: "<hi>", with: "").replacingOccurrences(of: "</hi>", with: ""), true))
                isHighlighted = false
            } else if highlightedText.hasPrefix("<hi>") {
                result.append((highlightedText.replacingOccurrences(of: "<hi>", with: ""), true))
                isHighlighted = true
            } else if highlightedText.hasSuffix("</hi>") {
                result.append((highlightedText.replacingOccurrences(of: "</hi>", with: ""), true))
                isHighlighted = false
            } else {
                result.append((highlightedText, isHighlighted))
            }
            
            lastRangeEnd = matchRange.location + matchRange.length
        }

        if lastRangeEnd < nsString.length {
            /*let (normalText, isHighlighted) = secondParse(nsString.substring(from: lastRangeEnd))*/
            
            result += secondParse(nsString.substring(from: lastRangeEnd))
        }

        return result
    }
    
    private func secondParse(_ text: String)  -> [(String, Bool)]  {
        var result: [(String, Bool)] = []
        let pattern = "(<hi>.*?</hi>)|(<hi>.*)|(.*?</hi>)"
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let nsString = text as NSString
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: nsString.length))

        var lastRangeEnd = 0
        var isHighlighted = false

        for match in matches {
            let matchRange = match.range
            if matchRange.location > lastRangeEnd {
                let normalText = nsString.substring(with: NSRange(location: lastRangeEnd, length: matchRange.location - lastRangeEnd))
                result.append((normalText, isHighlighted))
            }
            
            let highlightedText = nsString.substring(with: matchRange)
            if highlightedText.hasPrefix("<hi>") && highlightedText.hasSuffix("</hi>") {
                result.append((highlightedText.replacingOccurrences(of: "<hi>", with: "").replacingOccurrences(of: "</hi>", with: ""), true))
                isHighlighted = false
            } else if highlightedText.hasPrefix("<hi>") {
                result.append((highlightedText.replacingOccurrences(of: "<hi>", with: ""), true))
                isHighlighted = true
            } else if highlightedText.hasSuffix("</hi>") {
                result.append((highlightedText.replacingOccurrences(of: "</hi>", with: ""), true))
                isHighlighted = false
            } else {
                result.append((highlightedText, isHighlighted))
            }
            
            lastRangeEnd = matchRange.location + matchRange.length
        }

        if lastRangeEnd < nsString.length {
            let normalText = nsString.substring(from: lastRangeEnd)
            result.append((normalText, isHighlighted))
        }

        return result
    }
    
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextViewRepresentable

        init(_ parent: CustomTextViewRepresentable) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class CustomTextView: UITextView {
    var onShare: ((String) -> Void)?
    var onComment: ((String) -> Void)?
    var onHighlight: ((Int, Int) -> Void)?
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(commentThisText) || action == #selector(quoteThisTextSave) || action == #selector(quoteThisTextShare) || action == #selector(highlightThisText) {
            return true
        }
        return false
    }

    override func becomeFirstResponder() -> Bool {
        let menu = UIMenuController.shared
        let commentItem = UIMenuItem(title: "Comment", action: #selector(commentThisText))
        let shareQuote = UIMenuItem(title: "Share Quote", action: #selector(quoteThisTextShare))
        let saveQuote = UIMenuItem(title: "Note", action: #selector(quoteThisTextSave))
        let highlight = UIMenuItem(title:"Highlight", action: #selector(highlightThisText))

        menu.menuItems = [highlight, shareQuote, saveQuote, commentItem]
        menu.update()
        return super.becomeFirstResponder()
    }

    @objc func commentThisText() {
        if let range = Range(self.selectedRange, in: self.text) {
            let selectedText = String(self.text[range])
            onComment?(selectedText)  // Call the callback with the selected text
        }
    }

    @objc func quoteThisTextShare() {
        if let range = Range(self.selectedRange, in: self.text) {
            let selectedText = String(self.text[range])
            onShare?(selectedText)  // Call the callback with the selected text
        }
    }


    @objc func highlightThisText() {
        if let range = Range(self.selectedRange, in: self.text) {
            let selectedText = String(self.text[range])
            //onHighlight?(selectedText)  // Call the callback with the selected text
            print("HIGHLIGHT action triggered: \(selectedText)")
            
            // Get the start and end indices of the highlighted range
            let startIndex = range.lowerBound
            let endIndex = range.upperBound
            
            // Calculate the offsets from the start of the string
            let startOffset = self.text.distance(from: self.text.startIndex, to: startIndex)
            let endOffset = self.text.distance(from: self.text.startIndex, to: endIndex)
            onHighlight?(startOffset, endOffset)
            print("Start index: \(startOffset), End index: \(endOffset - 1)")
        }
    }

    @objc func quoteThisTextSave() {
        print("Save Quote action triggered")
    }
}

struct NotesView: View {
    @Binding var isPresenting: Bool
    @Binding var showToolbar: Bool
    var notes: [Note]
    @State var paragraph: String
    @Binding var showNote: Bool
    @Binding var selectedNote: Note

    @State var showBook = false
    @State var selectedBook = Book()
    @State var showPostActions = false
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var fullScreen = false
    @State var sharePage = false
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    HStack {
                        Text("Notes")
                            .font(.system(size: 16))
                        Spacer()
                    }
                    .padding()
                    HStack(alignment: .top) {
                        Image(systemName: "paragraphsign")
                            .font(.system(size: 14))
                            .padding(.trailing)
                        Text(paragraph)
                            .lineLimit(3)
                            .font(.system(size: 13))
                            .opacity(0.7)
                            .lineSpacing(4)
                    }
                    .padding(.bottom, 30)
                    .padding(.horizontal)
                    ForEach(notes) { note in
                        Button(action: {
                            selectedNote = note
                            showNote = true
                        }){
                            NotePreview(note: note, showNote: $showNote, selectedNote: $selectedNote, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $showPostActions, showProfile: $showProfile, selectedProfile: $selectedProfile)
                        }
                        Divider()
                            .padding(.horizontal)
                    }
                }
                Spacer()
            }
            
            .padding(.top, UIScreen.main.bounds.height * 0.04)
            .sheet(isPresented: $sharePage){
                SharePageView(isPresenting: $sharePage, note: .constant(Note()))
            }
            .background(backgroundColor)
            
            if showNote {
                NoteView(isPresenting: $showNote, note: $selectedNote, fullScreen: $fullScreen)
                    .onAppear {
                        showToolbar = false
                    }
                
            }
            
        }
        .background(backgroundColor)
    }
}

struct NotePreview: View {
    
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State private var color1: UIColor? = nil
    @State private var color2: UIColor? = nil
    
    @State private var selectedImageIndex = 0
    @State var isLiked : Bool = false
    @State var note = Note()
    
    @Binding var showNote : Bool
    @Binding var selectedNote: Note
    @State private var scale: CGFloat = 0.1 // Start with a smaller scale
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @Binding var showPostActions : Bool
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @State var coverShown: Bool = true
    @State var inDiscussionView = false
    @EnvironmentObject var userData: UserData
    @State var description = ""
    @State var showCover = false
    @State var pub = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        HStack(alignment: .top){
            if showCover {
                Button(action: { showNote = true }){
                    Image(note.book.cover)
                        .resizable()
                        .aspectRatio(contentMode: .fit) // Changed to .fill to ensure the image covers the area
                        .frame(height: iPadOrientation ? UIScreen.main.bounds.height * 0.1 : 80 )
                        .clipped() // This ensures the image is clipped to the frame bounds
                        .cornerRadius(2) // Apply corner radius directly to the image
                        .shadow(radius: 0.5)
                        .padding(.top)
                        .padding(.trailing, 1)
                    
                }
            }
            VStack {
                if pub {
                    HStack {
                        Button(action: {
                            showProfile = true
                            selectedProfile = note.user
                        }){
                            ProfileThumbnail(image: note.user.photo, size: 25)
                            
                            Text("\(note.user.name)")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.trailing, -1)
                        }
                        Spacer()
                        
                        
                        
                        if coverShown {
                            Spacer()
                        }
                        
                    }
                    .padding(.top)
                }
                Button(action: {
                    selectedBook = note.book
                    showBook = true
                    
                    
                }){
                    
                    
                    VStack(alignment: .leading) {
                        let read = userData.user.read(book: note.book)
                        
                        if note.spoiler == false || read {
                            
                            if note.title != "" {
                                Text(note.title)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 2)
                                
                            }
                            
                            
                            Text(description)
                                .font(.system(size: 15))
                                .lineLimit(7)
                                .lineSpacing(4)
                                .multilineTextAlignment(.leading)
                                .padding(note.title != ""  ? .vertical : .bottom)
                                .padding(.top, note.title == "" ? 2 : 0)
                            
                            
                        } else {
                            
                            SpoilerAlert()
                        }
                        
                        HStack {
                            Text(timeSince(from: note.timestamp))
                                .padding(.vertical, 2)
                                .font(.system(size: 13))
                                .opacity(0.7)
                            
                            
                            Spacer()
                            Text("Chapter 3")
                                .padding(.vertical, 2)
                                .font(.system(size: 12))
                                .opacity(0.7)
                                .padding(.leading)
                            //notes.quotes.count
                            
                            /*  Text("2 characters")
                             .padding(.vertical, 2)
                             .font(.system(size: 12))
                             .opacity(0.7)
                             .padding(.trailing)
                             Text("4 quotes")
                             .padding(.vertical, 2)
                             .font(.system(size: 12))
                             .opacity(0.7)*/
                            
                            
                            
                            
                        }
                        .offset(y: 5)
                        
                    }
                    .onTapGesture {
                        selectedNote = note
                        showNote = true
                    }
                    .onLongPressGesture(minimumDuration: 1){
                        selectedNote = note
                        showPostActions = true
                    }
                }
            }
            .onAppear {
                for element in note.elements {
                    if element.isText {
                        description = element.text ?? ""
                        break
                    }
                }
            }
            
            /*
             .simultaneousGesture(
             TapGesture().onEnded {
             // This will be triggered on tap before the long press can finish.
             // Put your regular tap action here.
             selectedPost = post
             showPost = true
             
             }
             )
             .simultaneousGesture(
             LongPressGesture(minimumDuration: 1).onEnded { _ in
             selectedPost = post
             showPostActions = true
             
             }
             )
             */
            
            
            .foregroundColor(.black)
            .padding()
            //.padding(.vertical)
            .background(backgroundColor)
            
            
            
            
        }
        //.padding(.horizontal)
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
                return "Just now"
            }
        }
        
        
    
}

struct PublicNotePreview: View {
    
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State private var color1: UIColor? = nil
    @State private var color2: UIColor? = nil
    
    @State private var selectedImageIndex = 0
    @State var isLiked : Bool = false
    @State var note = Note()
    
    @Binding var showNote : Bool
    @Binding var selectedNote: Note
    @State private var scale: CGFloat = 0.1 // Start with a smaller scale
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @Binding var showPostActions : Bool
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @State var coverShown: Bool = true
    @State var inDiscussionView = false
    @EnvironmentObject var userData: UserData
    @State var description = ""
    @State var showCover = false
    @State var pub = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        HStack(alignment: .top){
            if showCover {
                Button(action: { showNote = true }){
                    Image(note.book.cover)
                        .resizable()
                        .aspectRatio(contentMode: .fit) // Changed to .fill to ensure the image covers the area
                        .frame(height: iPadOrientation ? UIScreen.main.bounds.height * 0.1 : 80 )
                        .clipped() // This ensures the image is clipped to the frame bounds
                        .cornerRadius(2) // Apply corner radius directly to the image
                        .shadow(radius: 0.5)
                        .padding(.top)
                        .padding(.trailing, 1)
                    
                }
            }
            VStack {
                
                    HStack {
                        Button(action: {
                            showProfile = true
                            selectedProfile = note.user
                        }){
                            ProfileThumbnail(image: note.user.photo, size: 25)
                            
                            Text("\(note.user.name)")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.trailing, -1)
                        }
                        Spacer()
                        
                        
                        
                        if coverShown {
                            Spacer()
                        }
                        
                    }
                    .padding(.top)
                
                Button(action: {
                    selectedBook = note.book
                    showBook = true
                    
                    
                }){
                    
                    
                    VStack(alignment: .leading) {
                        let read = userData.user.read(book: note.book)
                        
                        if note.spoiler == false || read {
                            
                            if note.title != "" {
                                Text(note.title)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 2)
                                
                            }
                            
                            
                            Text(description)
                                .font(.system(size: 15))
                                .lineLimit(7)
                                .lineSpacing(4)
                                .multilineTextAlignment(.leading)
                                .padding(note.title != ""  ? .vertical : .bottom)
                                .padding(.top, note.title == "" ? 2 : 0)
                            
                            
                        } else {
                            
                            SpoilerAlert()
                        }
                        
                        HStack {
                            Text(timeSince(from: note.timestamp))
                                .padding(.vertical, 2)
                                .font(.system(size: 13))
                                .opacity(0.7)
                            
                            Text("Chapter \(note.chapterparagraph.0)")
                                .padding(.vertical, 2)
                                .font(.system(size: 11))
                                .opacity(0.7)
                                .padding(.leading)
                            Spacer()
                            Text("\(note.likes) likes")
                                .font(.system(size: 13))
                                .opacity(0.7)
                                .padding(.trailing)
                            Text("\(note.comments.count) comments")
                                .font(.system(size: 13))
                                .opacity(0.7)
                                .padding(.trailing)
                            
                            
                            if !isLiked {
                                Button(action: {
                                    isLiked.toggle()
                                    note.likes += 1
                                    
                                }){
                                    Image(systemName: "heart")
                                        .font(.system(size: 19))
                                        .foregroundColor(.black)
                                }
                            } else {
                                Button(action: {
                                    isLiked.toggle()
                                    note.likes -= 1
                                    
                                }){
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 19))
                                        .foregroundColor(.pink)
                                }
                            }
                            
                        }
                        .offset(y: 5)
                        
                    }
                    .onTapGesture {
                        selectedNote = note
                        showNote = true
                    }
                    .onLongPressGesture(minimumDuration: 1){
                        selectedNote = note
                        showPostActions = true
                    }
                }
            }
            .onAppear {
                for element in note.elements {
                    if element.isText {
                        description = element.text ?? ""
                        break
                    }
                }
            }
            
            /*
             .simultaneousGesture(
             TapGesture().onEnded {
             // This will be triggered on tap before the long press can finish.
             // Put your regular tap action here.
             selectedPost = post
             showPost = true
             
             }
             )
             .simultaneousGesture(
             LongPressGesture(minimumDuration: 1).onEnded { _ in
             selectedPost = post
             showPostActions = true
             
             }
             )
             */
            
            
            .foregroundColor(.black)
            .padding()
            //.padding(.vertical)
            .background(backgroundColor)
            
            
            
            
        }
        //.padding(.horizontal)
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
                return "Just now"
            }
        }
        
        
    
}





