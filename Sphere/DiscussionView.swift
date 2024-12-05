//
//  DiscussionView.swift
//  media discussion
//
//  Created by Alana Greenaway on 2/13/24.
//

import SwiftUI
import RichTextKit
import UIKit

struct DiscussionView: View {
    @Binding var isPresenting : Bool
    @State var isPresentingCreatePost = false
    @Binding var book : Book
    @State var showPost = false
    @State var selectedPost = Note()
    @State var isLiked = false
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var showBook = false
    @State var selectedBook = Book()
    @State var showPostActions = false
    @State var post = Note()
    @State var color1: UIColor? = nil
    @State var showProfile = false
    @State var selectedProfile = User()
    //@State var createPost = false
    @State var xoffset = 0.0
    @Binding var showToolbar : Bool
    @State var selectedChapter: Int? = nil
    @State var chooseChapter: Bool = false
    @State var searching: Bool = false
    @State var publishPost = false
    @EnvironmentObject var lightModeController: LightModeController
    @EnvironmentObject var userData: UserData
    @State var showSpoilerPopup: Bool = true
    var groupedNotes: [Int: [Note]] {
        Dictionary(grouping: book.discussion.posts, by: { $0.chapterparagraph.0 })
    }
    
    var body: some View {
        AnimateView(showView: $isPresenting){
            
            ZStack {
                VStack{
                    HStack() {
                        Button(action: {isPresenting.toggle()}){
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .transaction({ transaction in
                            transaction.disablesAnimations = true
                        })
                        Spacer()
                        SortByButton()
                            .padding(.trailing)
                        DiscussionSearchButton()
                        
                        
                        
                        
                    }
                    .foregroundColor(lightModeController.getForegroundColor())
                    .padding()
                    .background(lightModeController.getBackgroundColor())
                    ScrollView{
                        VStack {
                            
                            MiniBookPreview(book: book, showBook: $showBook, bookHeight: 50.0, cornerRadius: 4.0, titleFontSize: 18, inline: false)
                                .padding(.bottom, -4)
                                .padding(.horizontal, UIScreen.main.bounds.width * 0.025)
                            /*
                            HStack {
                                SortByButton()
                                Spacer()
                                
                                Text("\(book.getReadersString()) readers")
                                    .font(.system(size: 12))
                                    .opacity(0.8)
                                    .padding(.trailing, 8)
                                Text("\(book.discussion.posts.count) posts")
                                    .font(.system(size: 12))
                                    .opacity(0.8)
                            }
                            .padding(.horizontal)
                            */
                            HStack {
                                Spacer()
                                
                                Text("\(book.discussion.posts.count) posts")
                                    .font(.system(size: 12))
                                    .opacity(0.8)
                            }
                            .padding(.horizontal)
                            /*
                             VStack(alignment: .leading) {
                             HStack{
                             Text(book.title)
                             .font(.system(size: 20, weight: .medium))
                             .padding(.leading)
                             Spacer()
                             
                             }
                             
                             HStack{
                             if book.discussion.posts.count > 1 {
                             Text("\(book.discussion.posts.count) posts")
                             .font(.system(size: 12))
                             .opacity(0.7)
                             .padding(.leading)
                             } else if book.discussion.posts.count == 1 {
                             Text("1 post")
                             .font(.system(size: 12))
                             .opacity(0.7)
                             .padding(.leading)
                             }
                             Spacer()
                             
                             }
                             
                             }
                             .padding(.vertical)
                             */
                            
                            if book.discussion.posts.count == 0 {
                                SphereAutoMessage(message: "No posts yet")
                                    .padding(.top)
                            } else {
                                ForEach(book.discussion.posts) { post in
                                    MiniPostPreview3(post: post, showPost: $showPost, selectedPost: $selectedPost)
                                        //.padding(.bottom, 1)
                                }
                            }
                        }
                        .padding(.bottom, 80)
                        
                        
                    }
                    DiscussionCommentBar(book: book)
                }
                
                .background(lightModeController.getBackgroundColor())
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
                if showPost {
                    
                    PostView(post: $selectedPost, isPresenting: $showPost, showToolbar: $showToolbar)
                    //  ReviewView(review: $selectedReview, showingReview: , showEReader: <#T##Binding<Bool>#>, showToolbar: <#T##Binding<Bool>#>)
                }
                

                
            }
        }
    }
    
    
}

struct SortByButton: View {
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        Button(action: {
            
        }){
            SortIcon()
            /*
            Text("Sort By")
                .padding(.horizontal)
                .padding(.vertical, 6)
                .font(.system(size: 12, weight: .medium))
                .opacity(0.7)
                .foregroundColor(lightModeController.getForegroundColor())
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(lightModeController.getForegroundColor().opacity(0), lineWidth: 0.6)
                        .fill(Color(hex: "#fffffc").opacity(0.7))
                    )
                 */
        }

    }
}

struct CreatePost: View {
    @Binding var isPresenting: Bool
    @State private var title: String = ""
    @Binding var book: Book
    @State var description: String = ""
    @EnvironmentObject var userData: UserData
    @State private var attributedText = NSMutableAttributedString(string: "")
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State private var text = NSAttributedString(string: "Body...")
    
    @StateObject var context = RichTextContext()
    @State var fontName = ".SFUI"

    @State var isReview: Bool = false
    @State var rating: Float = -1.0
    @State var initialRating: Float = 5.0
    @State var showRateView = false
    @State private var dynamicHeight: CGFloat = 0
    @EnvironmentObject var lightModeController: LightModeController
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
       // GeometryReader { geometry in
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        isPresenting = false
                    }) {
                        Text("Cancel")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    Button(action: {
                  
                            addPost()
                        
                        isPresenting = false
                    }) {
                        Text("Post")
                            .font(.system(size: 15, weight: .medium))
                            .padding(.horizontal)
                            .padding(.vertical, 8)

                            .background(Color(.blue).opacity(0.5))
                            .cornerRadius(40)

                    }
                }
                .padding()
                VStack{
                    
                    HStack(alignment: .center) {
                        Image(book.cover)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                            .cornerRadius(4)
                            .padding(5)
                            .onTapGesture {
                               
                            }
                        
                        /* .background(
                         RoundedRectangle(cornerRadius: 14)
                         .foregroundColor(.white)
                         )*/
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(book.title)")
                                    .font(.custom("Baskerville", size: 16.5))
                                //.bold()
                                Spacer()
                                
                                
                            }
                            HStack(alignment: .top) {
                                Text("BY")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size:10.5, weight:.medium))
                                    .opacity(0.5)
                                
                                Text("\(book.author.name)")
                                    .padding(.leading, -2)
                                    .font(.system(size:13.5, weight:.medium))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                //.textCase(.uppercase)
                                Spacer()
                                
                                
                            }
                            .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                            
                            
                            
                            
                        }
                        .frame(height: 70)
                        
                    }
                    .padding(25)
                    .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                        .fill(Color(hex: "#fffef8"))
                                
                    )
                    .background(
                        VStack{
                            Spacer()
                            HStack{
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 1, height: 40)
                                    .padding(.leading)
                                    .padding(.leading)
                                    .padding(.top, 10)
                                    .opacity(0.5)
                                Spacer()
                            }
                        }
                            .offset(y: 15)
                        
                    )
                    .padding(.bottom, 4)
                    VStack(alignment: .leading){
                        HStack{
                            /*Text(review.rating.book.title)
                             .font(.custom("Georgia", size: 14.5))
                             .bold()
                             .lineLimit(1)
                             .frame(width: 190, alignment: .leading)*/
                            
                            ProfileThumbnail(image: userData.user.photo, size: 30)
                            Text("\(userData.user.name)")
                                .font(.system(size: 14, weight: .medium))
                                .padding(.trailing, -4)
                           
                            Spacer()
                            
                        }
                        .padding(.vertical, 8)
                        
                        VStack(alignment: .leading){
                            Text("Title")
                                .font(.system(size: 16))
                                .padding(.bottom, -3)
                            TextField("", text: $title)
                                .font(.system(size: 16.5))
                                .foregroundColor(lightModeController.getForegroundColor())
                                .padding(.leading, 2)
                                .padding(10)
                                .background(lightModeController.getBackgroundColor())
                                .cornerRadius(14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.black, lineWidth: 0.5)
                                        .padding(.horizontal, 2)// Thin black border
                                )
                        }

                        
                        NoteTextEditor(text: $description, backgroundColor: UIColor(Color(hex: "#fffef8")), dynamicHeight: $dynamicHeight, placeholder: "Post to discussion")
                            .padding(.horizontal, -5)
                            .frame(height: dynamicHeight)
                            .padding(.bottom)
                            .font(.system(size: 18, weight: .medium))
                        
                    }
                    .padding(25)
                    .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                        .fill(Color(hex: "#fffef8"))
                    )
                    
                }
                .onAppear {
                    if userData.user.hasReviewed(bookid: book.id) {
                        let rev = userData.user.getReviewByID(bookid: book.id)
                        title = rev?.title ?? ""
                        description = rev?.description ?? ""
                    }
                    context.fontSize = 30
                }
                .sheet(isPresented: $showRateView) {
                    RateView(media: book, isPresenting: $showRateView, rating: $rating, initialRating: $initialRating)
                        .presentationDetents([.fraction(0.8)])
                        .background(backgroundColor)
                }
                
                
            }
            
        }
        .background(lightModeController.getBackgroundColor())
       
   
    }

    private func addPost() {
        let newPost = Note(id: UUID(), user: userData.user, title: title, description: description, likes: 0, comments: [], timestamp: Date(), book: book)
        book.addPost(post: newPost)
        userData.sendToFeed(item: FeedItem(id: UUID(), type: .post, post: newPost))
    }

    private func addReview() {
        let newReview = Review(rating: Rating(user: userData.user, book: book, stars: rating), title: title, description: description)
        book.addReview(review: newReview)
        userData.user.addReview(review: newReview)
    }
}

struct DiscussionCommentBar: View {
    @State private var dynamicHeight: CGFloat = 0
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController
    @State var description: String = ""
    @State var createNewPost = false
    @State var book: Book
    var body: some View {
            HStack(alignment: .top) {
                ProfileThumbnail(image: userData.user.photo , size: 40)
                Button(action: {
                    createNewPost.toggle()
                }){
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 20)
                        .overlay(
                            //Image(systemName: "plus")
                            HStack {
                                Text("Post to discussion")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .medium))
                                    .opacity(0.5)
                                Spacer()
                            }

                        )
                        .foregroundColor(lightModeController.getBackgroundColor())
                }
                .sheet(isPresented: $createNewPost){
                    CreatePost(isPresenting: $createNewPost, book: $book)
                }
                /*NoteTextEditor(text: $description, backgroundColor: UIColor(Color(lightModeController.getBackgroundColor())), dynamicHeight: $dynamicHeight, placeholder: "Post to discussion")
                    //.padding(.horizontal, -5)
                    .frame(height: dynamicHeight)
                    .font(.system(size: 18, weight: .medium))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                             )*/
                
            }
            .padding()
            .background(lightModeController.getBackgroundColor())
            
        
    }
}

struct DiscussionSpoilerPopup: View {
    @Binding var isPresenting: Bool
    @Binding var isPresentingDiscussion: Bool
    @EnvironmentObject var userData: UserData
    @State var book: Book
    var body: some View {
        VStack{
            
            HStack {
         
                Text("\"\(book.title)\"")
                    .font(.system(size: 17, weight: .medium))
                    .lineLimit(1)
                 
                Spacer()
            }
            .padding(.vertical)
            
            Text("Sphere discussions contain spoilers")
                .padding(.top, UIScreen.main.bounds.height * 0.3)
            
            Spacer()
            
            Button(action: {
                userData.user.changeBookStatus(book: book, newStatus: .read)
                isPresenting.toggle()

            }){
                RoundedRectangle(cornerRadius: 40)
                    .overlay(
                        HStack {
                            Text("Mark as")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                            Text("Read")
                                .padding(8)
                                .background(Color.green)
                                .cornerRadius(10)
                                .padding(.leading, -3)
                        }
                    )
                    .frame(height: 38)
                    .foregroundColor(Color(.black).opacity(0.7))
            }
            
            Button(action: {
                isPresenting.toggle()
            }){
                RoundedRectangle(cornerRadius: 40)
                    .overlay(
                        Text("View Anyway")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    )
                    .frame(height: 38)
                    .foregroundColor(Color(.black).opacity(0.7))
            }
            Button(action: {
                isPresentingDiscussion.toggle()
            }){
                RoundedRectangle(cornerRadius: 40)
                    .overlay(
                        Text("Go Back")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    )
                    .frame(height: 38)
                    .foregroundColor(Color(.black).opacity(0.7))
            }

        }
        .padding()
    }
}

struct DiscussionViewCell: View {
    /*@State var isPresentingCreatePost = false
    @State var isLiked = false */
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @ObservedObject var user : User
    @Binding var showPost : Bool
    @Binding var selectedPost : Note
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @State var post : Note
    @Binding var showPostActions : Bool
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @Binding var isLiked : Bool


    
    var body: some View {
        
        
        
        VStack(alignment: .leading) {
            
            
            PostPreview(post: post, showPost: $showPost, selectedPost: $selectedPost, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $showPostActions, showProfile: $showProfile, selectedProfile: $selectedProfile, coverShown: false, inDiscussionView: true)
                .padding(.horizontal, -12)

            
            
        }
        .background(backgroundColor)
        
    }
}


struct DynamicHeightTextEditor: UIViewRepresentable {
    @Binding var text: String
    var minHeight: CGFloat
    var maxHeight: CGFloat
    var backgroundColor = UIColor(Color(hex: "#FDFAEF"))
    var placeholder = ""

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = backgroundColor
        textView.text = text
        textView.delegate = context.coordinator
        textView.isScrollEnabled = false

        // Set the font size and line spacing
        let font = UIFont.systemFont(ofSize: 17)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        textView.typingAttributes = attributes

        // Add placeholder label
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = UIFont.systemFont(ofSize: 17)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(placeholderLabel)

        // Position placeholder label
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8)
        ])

        // Hide placeholder label when text is entered
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: textView, queue: .main) { _ in
            placeholderLabel.isHidden = !textView.text.isEmpty
        }

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.backgroundColor = backgroundColor
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: DynamicHeightTextEditor

        init(_ parent: DynamicHeightTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
            textView.invalidateIntrinsicContentSize()
        }
    }
}

struct DynamicHeightTextView: View {
    @Binding var text: String
    var minHeight: CGFloat
    var maxHeight: CGFloat

    @State private var contentHeight: CGFloat = 0

    var body: some View {
        DynamicHeightTextEditor(text: $text, minHeight: minHeight, maxHeight: maxHeight, placeholder: "Enter text here...")
            .frame(height: min(max(contentHeight, minHeight), maxHeight))
            .background(GeometryReader {
                Color.clear.preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
            })
            .onPreferenceChange(ViewHeightKey.self) { newHeight in
                contentHeight = newHeight
            }
            .background(Color(hex: "#FDFAEF"))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(height: min(max(contentHeight, minHeight), maxHeight))

            )
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}






private var placeholderLabelKey: UInt8 = 0

extension UITextView {
    var placeholderLabel: UILabel? {
        get {
            return objc_getAssociatedObject(self, &placeholderLabelKey) as? UILabel
        }
        set {
            objc_setAssociatedObject(self, &placeholderLabelKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

struct NoteTextEditor: UIViewRepresentable {
    @Binding var text: String
    var backgroundColor: UIColor = UIColor(.white)
    @Binding var dynamicHeight: CGFloat
    var placeholder: String = "Text here..."
    var lineBuffer: CGFloat = 7 // Add a buffer to the height calculation

    func makeUIView(context: Context) -> UITextView {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.delegate = context.coordinator
        /*textView.isScrollEnabled = false
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.textContainer.widthTracksTextView = true*/

        let font = UIFont.systemFont(ofSize: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4.2
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        textView.typingAttributes = attributes

        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        textView.addSubview(placeholderLabel)
        textView.placeholderLabel = placeholderLabel
        textView.translatesAutoresizingMaskIntoConstraints = false

        // Layout constraints
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            placeholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -5)
        ])

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        recalculateHeight(view: uiView)
        uiView.placeholderLabel?.isHidden = !text.isEmpty
    }

    private func recalculateHeight(view: UIView) {                DispatchQueue.main.async {
            let font = UIFont.systemFont(ofSize: 16)
            let lineHeight = font.lineHeight + 4.2 // Add line spacing
            let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            let numberOfLines = newSize.height / lineHeight
            let adjustedHeight = newSize.height + (self.lineBuffer * numberOfLines)
            if self.dynamicHeight != adjustedHeight {
                self.dynamicHeight = adjustedHeight
            }
    }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: NoteTextEditor

        init(_ parent: NoteTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
            self.parent.recalculateHeight(view: textView)
            textView.placeholderLabel?.isHidden = !textView.text.isEmpty
        }
    }
}









struct CustomTextEditor: UIViewRepresentable {
    @Binding var text: String
    @State var backgroundColor = UIColor(Color(hex: "#ECE8DA"))
    var placeholder = ""
    
    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = backgroundColor

        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.delegate = context.coordinator

        let font = UIFont.systemFont(ofSize: 17)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        textView.typingAttributes = attributes

        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(placeholderLabel)

        let characterCountLabel = UILabel()
        characterCountLabel.font = UIFont.systemFont(ofSize: 12)
        characterCountLabel.textColor = UIColor.darkGray
        characterCountLabel.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(textView)
        containerView.addSubview(characterCountLabel)

        // Layout constraints
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: containerView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            characterCountLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 4),
            characterCountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            characterCountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        ])

        // Placeholder label constraints
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8)
        ])

        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: textView, queue: .main) { _ in
            placeholderLabel.isHidden = !textView.text.isEmpty
            characterCountLabel.text = "\(textView.text.count) / 150"
        }

        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let textView = uiView.subviews.first(where: { $0 is UITextView }) as? UITextView {
            textView.text = text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextEditor

        init(_ parent: CustomTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let currentText = textView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
            return updatedText.count <= 150
        }
    }
}


struct PostTextEditor: UIViewRepresentable {
    @Binding var text: String
    var backgroundColor = UIColor(Color(hex: "#ECE8DA"))
    var placeholder = "Your thoughts here..."
    
    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = backgroundColor

        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.delegate = context.coordinator

        let font = UIFont.systemFont(ofSize: 17)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        textView.typingAttributes = attributes

        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(placeholderLabel)

        let characterCountLabel = UILabel()
        characterCountLabel.font = UIFont.systemFont(ofSize: 12)
        characterCountLabel.textColor = UIColor.darkGray
        characterCountLabel.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(textView)
        containerView.addSubview(characterCountLabel)

        // Layout constraints
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: containerView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            characterCountLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 4),
            characterCountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            characterCountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        ])

        // Placeholder label constraints
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8)
        ])

        context.coordinator.placeholderLabel = placeholderLabel
        context.coordinator.textView = textView

        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let textView = context.coordinator.textView {
            textView.text = text
            context.coordinator.updatePlaceholderVisibility()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: PostTextEditor
        var placeholderLabel: UILabel?
        var textView: UITextView?

        init(_ parent: PostTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
            updatePlaceholderVisibility()
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            updatePlaceholderVisibility()
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            updatePlaceholderVisibility()
        }

        func updatePlaceholderVisibility() {
            if let textView = textView, let placeholderLabel = placeholderLabel {
                placeholderLabel.isHidden = !textView.text.isEmpty
            }
        }
    }
}


       
/*
 {
     @Binding var text: String
     //@State var secondaryColor = Color(hex: "#291F00").opacity(0.05)
     var backgroundColor = UIColor(Color(hex: "#ECE8DA"))
     var placeholder = ""
     func makeUIView(context: Context) -> UITextView {
         let textView = UITextView()
         textView.backgroundColor = backgroundColor
         textView.text = text
         
         // Set the font size and line spacing
         let font = UIFont.systemFont(ofSize: 17) // Font size 18
         let paragraphStyle = NSMutableParagraphStyle()
         paragraphStyle.lineSpacing = 8 // Line spacing 8
         let attributes: [NSAttributedString.Key: Any] = [
             NSAttributedString.Key.font: font,
             NSAttributedString.Key.paragraphStyle: paragraphStyle
         ]
         textView.typingAttributes = attributes
         
         textView.delegate = context.coordinator
         
         // Add placeholder label
         let placeholderLabel = UILabel()
         placeholderLabel.text = placeholder // Placeholder text
         placeholderLabel.font = UIFont.systemFont(ofSize: 18) // Placeholder font size
         placeholderLabel.textColor = UIColor.lightGray // Placeholder color
         placeholderLabel.numberOfLines = 0 // Allow multiple lines
         placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
         textView.addSubview(placeholderLabel)
         
         // Position placeholder label
         NSLayoutConstraint.activate([
             placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
             placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8)
         ])
         
         // Hide placeholder label when text is entered
         NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: textView, queue: .main) { _ in
             placeholderLabel.isHidden = !textView.text.isEmpty
         }
         
         return textView
     }




     func updateUIView(_ uiView: UITextView, context: Context) {
         uiView.backgroundColor = backgroundColor
         uiView.text = text
     }

     func makeCoordinator() -> Coordinator {
         Coordinator(self)
     }

     class Coordinator: NSObject, UITextViewDelegate {
         var parent: CustomTextEditor

         init(_ parent: CustomTextEditor) {
             self.parent = parent
         }

         func textViewDidChange(_ textView: UITextView) {
             self.parent.text = textView.text
         }
     }
 }
 */

struct CreateReview: View {
    @Binding var isPresenting: Bool
    @State private var title: String = ""
    @Binding var book: Book
    @State var description: String = ""
    @EnvironmentObject var userData: UserData
    @State private var attributedText = NSMutableAttributedString(string: "")
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State private var text = NSAttributedString(string: "Body...")
    
    @StateObject var context = RichTextContext()
    @State var fontName = ".SFUI"

    @State var isReview: Bool = false
    @State var rating: Float = -1.0
    @State var initialRating: Float = 5.0
    @State var showRateView = false
    @Binding var showToolbar: Bool
    @State private var dynamicHeight: CGFloat = 0
    @EnvironmentObject var lightModeController: LightModeController
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
       // GeometryReader { geometry in
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        isPresenting = false
                        showToolbar = true
                    }) {
                        Text("Cancel")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    Button(action: {
                        if isReview {
                            addReview()
                        } else {
                            addPost()
                        }
                        isPresenting = false
                        showToolbar = true
                    }) {
                        Text("Post")
                            .font(.system(size: 15, weight: .medium))
                            .padding(.horizontal)
                            .padding(.vertical, 8)

                            .background(Color(.blue).opacity(0.5))
                            .cornerRadius(40)

                    }
                }
                .padding()
                VStack{
                    
                    HStack(alignment: .center) {
                        Image(book.cover)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                            .cornerRadius(4)
                            .padding(5)
                            .onTapGesture {
                               
                            }
                        
                        /* .background(
                         RoundedRectangle(cornerRadius: 14)
                         .foregroundColor(.white)
                         )*/
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(book.title)")
                                    .font(.custom("Baskerville", size: 16.5))
                                //.bold()
                                Spacer()
                                
                                
                            }
                            HStack(alignment: .top) {
                                Text("BY")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size:10.5, weight:.medium))
                                    .opacity(0.5)
                                
                                Text("\(book.author.name)")
                                    .padding(.leading, -2)
                                    .font(.system(size:13.5, weight:.medium))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                //.textCase(.uppercase)
                                Spacer()
                                
                                
                            }
                            .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                            
                            
                            
                            
                        }
                        .frame(height: 70)
                        
                    }
                    .padding(25)
                    .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                        .fill(Color(hex: "#fffef8"))
                                
                    )
                    .background(
                        VStack{
                            Spacer()
                            HStack{
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 1, height: 40)
                                    .padding(.leading)
                                    .padding(.leading)
                                    .padding(.top, 10)
                                    .opacity(0.5)
                                Spacer()
                            }
                        }
                            .offset(y: 15)
                        
                    )
                    .padding(.bottom, 4)
                    VStack(alignment: .leading){
                        HStack{
                            /*Text(review.rating.book.title)
                             .font(.custom("Georgia", size: 14.5))
                             .bold()
                             .lineLimit(1)
                             .frame(width: 190, alignment: .leading)*/
                            
                            ProfileThumbnail(image: userData.user.photo, size: 30)
                            Text("\(userData.user.name)")
                                .font(.system(size: 14, weight: .medium))
                                .padding(.trailing, -4)
                            Text("rated")
                                .font(.system(size: 14))
                                .padding(.trailing, -4)
                            
                            /*Text("\(review.rating.book.title)")
                             .font(.custom("Georgia", size: 14))
                             .bold()
                             .padding(.trailing, -4)
                             */
                            Button(action: {
                                initialRating = rating
                                showRateView = true
                            }) {
                                ReviewStar(rating: rating)
                            }
                            Spacer()
                            
                        }
                        .padding(.vertical, 8)
                        
                        
                        NoteTextEditor(text: $description, backgroundColor: UIColor(Color(hex: "#fffef8")), dynamicHeight: $dynamicHeight, placeholder: "Post your review")
                            .padding(.horizontal, -5)
                            .frame(height: dynamicHeight)
                            .padding(.bottom)
                            .font(.system(size: 18, weight: .medium))
                        
                    }
                    .padding(25)
                    .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                        .fill(Color(hex: "#fffef8"))
                    )
                    
                }
                .onAppear {
                    if userData.user.hasReviewed(bookid: book.id) {
                        let rev = userData.user.getReviewByID(bookid: book.id)
                        title = rev?.title ?? ""
                        description = rev?.description ?? ""
                    }
                    context.fontSize = 30
                    showToolbar = false
                }
                .sheet(isPresented: $showRateView) {
                    RateView(media: book, isPresenting: $showRateView, rating: $rating, initialRating: $initialRating)
                        .presentationDetents([.fraction(0.8)])
                        .background(backgroundColor)
                }
                
                
            }
            
        }
        .background(lightModeController.getBackgroundColor())
            .onDisappear {
                showToolbar = true
            }
   
    }

    private func addPost() {
        let newPost = Note(id: UUID(), user: userData.user, title: title, description: description, likes: 0, comments: [], timestamp: Date(), book: book)
        book.addPost(post: newPost)
        userData.sendToFeed(item: FeedItem(id: UUID(), type: .post, post: newPost))
    }

    private func addReview() {
        let newReview = Review(rating: Rating(user: userData.user, book: book, stars: rating), title: title, description: description)
        book.addReview(review: newReview)
        userData.user.addReview(review: newReview)
    }
}



struct RichTextEditor1: View {
    @Binding var attributedText: NSMutableAttributedString
    @State private var isBold = false
    @State private var isItalic = false
    @State private var isUnderline = false
    @State var backgroundColor = Color(hex: "#FDFAEF")
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isBold.toggle()
                }) {
                    Image(systemName: "bold")
                }
                .padding()
                .background(isBold ? Color.blue.opacity(0.3) : Color.clear)
                .cornerRadius(5)
                
                Button(action: {
                    isItalic.toggle()
                }) {
                    Image(systemName: "italic")
                }
                .padding()
                .background(isItalic ? Color.blue.opacity(0.3) : Color.clear)
                .cornerRadius(5)
                
                Button(action: {
                    isUnderline.toggle()
                }) {
                    Image(systemName: "underline")
                }
                .padding()
                .background(isUnderline ? Color.blue.opacity(0.3) : Color.clear)
                .cornerRadius(5)
            }
            
            TextView(attributedText: $attributedText, isBold: isBold, isItalic: isItalic, isUnderline: isUnderline)
                .font(.system(size: 15))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(backgroundColor)
        }
    }
}

struct TextView: UIViewRepresentable {
    @Binding var attributedText: NSMutableAttributedString
    var isBold: Bool
    var isItalic: Bool
    var isUnderline: Bool
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.font = UIFont.systemFont(ofSize: 18)
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18),
            .foregroundColor: UIColor.black
        ]
        var updatedText = NSMutableAttributedString(string: attributedText.string, attributes: attributes)
        if isBold {
            updatedText = applyStyle(attribute: .font, value: UIFont.boldSystemFont(ofSize: 18), to: updatedText)
        }
        if isItalic {
            updatedText = applyStyle(attribute: .font, value: UIFont.italicSystemFont(ofSize: 18), to: updatedText)
        }
        if isUnderline {
            updatedText = applyStyle(attribute: .underlineStyle, value: NSUnderlineStyle.single.rawValue, to: updatedText)
        }
        uiView.attributedText = updatedText
    }
    
    private func applyStyle(attribute: NSAttributedString.Key, value: Any, to attributedText: NSMutableAttributedString) -> NSMutableAttributedString {
        let selectedRange = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(attribute, in: selectedRange, options: []) { (value, range, _) in
            if let value = value as? UIFont {
                let updatedFontDescriptor = value.fontDescriptor.withSymbolicTraits(value.fontDescriptor.symbolicTraits.union([.traitBold]))
                let updatedFont = UIFont(descriptor: updatedFontDescriptor!, size: value.pointSize)
                attributedText.addAttribute(attribute, value: updatedFont, range: range)
            } else if let _ = value as? NSUnderlineStyle {
                attributedText.removeAttribute(attribute, range: range)
            }
        }
        return attributedText
    }
}

/*

struct TextView: UIViewRepresentable {
    @Binding var attributedText: NSMutableAttributedString
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.font = UIFont.systemFont(ofSize: 18)
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = attributedText
    }
}
*/
extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
    
    func withoutTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let currentTraits = self.fontDescriptor.symbolicTraits
        let newTraits = currentTraits.subtracting(traits)
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(newTraits) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}




struct TextView1: UIViewRepresentable {
    
    @Binding var attributedText: NSMutableAttributedString
    var allowsEditingTextAttributes: Bool = false
    var font: UIFont?
    var isBold: Bool
    var isItalic: Bool
    var isUnderline: Bool

    func makeUIView(context: Context) -> UITextView {
        UITextView()
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        if isBold {
            attributes[.font] = UIFont.boldSystemFont(ofSize: uiView.font?.pointSize ?? 18)
        }
        /*
        if isItalic {
            if let currentFont = uiView.font {
                let italicDescriptor = currentFont.fontDescriptor.withSymbolicTraits(.traitItalic)
                if let italicFont = UIFont(descriptor: italicDescriptor, size: currentFont.pointSize) {
                    attributes[.font] = italicFont
                }
            }
        }*/
        
        if isUnderline {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        attributedText.setAttributes(attributes, range: NSRange(location: 0, length: attributedText.length))
        
        uiView.attributedText = attributedText
        uiView.allowsEditingTextAttributes = allowsEditingTextAttributes
        uiView.font = font
    }
}

