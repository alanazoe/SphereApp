//
//  ActivityView.swift
//  sphere
//
//  Created by Alana Greenaway on 3/31/24.
//

import SwiftUI


struct ActivitySheet: View {
    @Binding var isPresenting: Bool
    @State var user: User
    @State var book: Book
    @State var activity: [Note]
    @State var review: Review?
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var showAuthor = false
    @State var selectedAuthor = Author()
    @State var showReview = false
    @State var selectedReview = Review()
    @State var showPost = false
    @State var selectedPost = Note()
    @State var showBook = false
    @State var selectedBook = Book()
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var postActions = false
    @State var showQuote = false
    @State var selectedQuote = Quote2()
    @EnvironmentObject var sphereUsers: SphereUsers
    var body: some View {
        VStack {
            HStack{
                Text("\(user.name) on \(book.title)")
                    .font(.system(size: 16))
                    .padding()
                Spacer()
            }
            ScrollView {
                VStack {
                    if let review = review {
                        ReviewPreview(review: review, showBook: $showBook, selectedBook: $selectedBook, showReview: $showReview, selectedReview: $selectedReview, showProfile: $showProfile, selectedProfile: $selectedProfile)
                    }
                    
                    ForEach(activity) { post in
                        VStack {
                            PostPreview(post: post, showPost: $showPost, selectedPost: $selectedPost, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $postActions, showProfile: $showProfile, selectedProfile: $selectedProfile, coverShown: false, inDiscussionView: false)
                                
                        }
                        Divider()
                            .padding()
                    }
                }
                .padding(.top, 20)
            }
            .padding(.bottom, 90)
        }
        .background(backgroundColor)

    }
}

struct NewPostButton: View {
    @Binding var createPost: Bool
    
    var body: some View {
        
        Button(action: {createPost.toggle()}){
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 50, height: 50)
                .foregroundColor(.black)
                .overlay(
                Image(systemName: "plus")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
            )
        }
    }
}


struct WritePostView: View {
    @Binding var isPresenting: Bool
    @StateObject private var newPost = Note()
    @State private var selectedBooks: [Book] = []
    @State private var showBookSelection = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var allBooks: Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    
    var body: some View {
        VStack() {
            HStack{
                Button("Cancel"){
                    isPresenting = false
                }
                Spacer()
                Button("Post"){
                    isPresenting = false
                }
            }
            .padding(.horizontal)
            
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .top) {
                        Text("New Post")
                            .font(.system(size: 28, weight: .medium))
                        Spacer()
                        Button(action: {
                            showBookSelection.toggle()
                        }) {
                            HStack {
                                if selectedBooks.isEmpty {
                                    Text("Select Book")
                                        .foregroundColor(.black)
                                        .font(.system(size: 15))
                                } else {
                                    Image(selectedBooks[0].cover)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: UIScreen.main.bounds.width / 9)
                                        .clipped()
                                        .cornerRadius(5)
                                }
                                
                                
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                        .sheet(isPresented: $showBookSelection) {
                            SearchSelectBooksBar(database: allBooks.library, selectedBooks: $selectedBooks)
                        }
                        
                        TextField("Title", text: $newPost.title)
                        .font(.system(size: 20, weight: .medium))
                            .padding(.vertical)
                            .background(backgroundColor)
                            .cornerRadius(10)
                        
                        PostTextEditor(text: $newPost.description, backgroundColor: UIColor(backgroundColor))
                            .frame(height: 450)
                            .padding(.leading, -8)
                        
                        
                        
                        Toggle(isOn: $newPost.spoiler) {
                            Text("Contains Spoilers")
                        }
                        .padding()
                        
                        
                        
                        Spacer()
                    }
                }
                .padding()
                .background(backgroundColor)
                
            }
        .background(backgroundColor)

                
    }
}
    
    
    struct FeedView: View {
        @State var showPost = false
        @State var selectedPost = Note()
        @State var showNotificationView = false
        @State var showBook = false
        @State var selectedBook = Book()
        @State private var refreshID = UUID()
        @State var showReview = false
        @State var selectedReview = Review()
        @State var isLiked = false
        @State var showQuote = false
        @State var selectedQuote = Quote2()
        @State var create = false
        @State var backgroundColor = Color(hex: "#FDFAEF")
        @State var postActions = false
        @State var showProfile = false
        @State var selectedProfile = User()
        @State var showList: Bool = false
        @State var selectedList: List = List()
        @State var showEReader = false
        @Binding var showToolbar: Bool
        @State var showAuthor = false
        @State var selectedAuthor = Author()
        @EnvironmentObject var userData: UserData
        @State var createPost = false
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        @State var showReader = false
        @EnvironmentObject var lightModeController: LightModeController
        @EnvironmentObject var sphereUsers: SphereUsers
        
        var body: some View {
            
            let iPadOrientation = horizontalSizeClass != .compact
            
                ZStack {
                    VStack {
                        ZStack {
                            HStack {
                                if !lightModeController.isDarkMode(){
                                    Image("Sphere-Dark-Logo-Text-250px")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80)
                                        .padding()
                                    
                                } else {
                                    Image("Sphere-Light-Logo-Text-250px")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80)
                                        .padding()
                                    
                                    
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 5)
                            .padding(.top)
                            .padding(.horizontal)
                            
                            /*
                             HStack {
                             
                             Text("Sphere")
                             .padding(.vertical)
                             .font(.system(size: 20, weight: .medium))
                             .opacity(1) // Fade out when showSearchBar is true
                             
                             Spacer()
                             
                             Button(action: {showNotificationView = true}){
                             Image(systemName: "bell")
                             .font(.system(size: 18, weight: .medium))
                             .padding()
                             .foregroundColor(.black)
                             
                             }
                             
                             }
                             .padding(.horizontal)
                             */
                            HStack {
                                
                                Spacer()
                                
                                Button(action: {showNotificationView = true}){
                                    Image(systemName: "bell")
                                        .font(.system(size: 16, weight: .medium))
                                        .padding()
                                        .foregroundColor(.black)
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                        }
                        ScrollView {
                            VStack(spacing: 40) {
                                ForEach(userData.user.feed, id: \.id) { feedItem in
                                    VStack {
                                    
                                        if feedItem.type == .post{
                                            PostPreview(post: feedItem.post!, showPost: $showPost, selectedPost: $selectedPost, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $postActions, showProfile: $showProfile, selectedProfile: $selectedProfile, coverShown: false, inDiscussionView: false)
                                            //.foregroundColor(.black)
                                            
                                            
                                        }  else if feedItem.type == .list {
                                            UserSharedList(list: feedItem.list!, showList: $showList, selectedList: $selectedList, showProfile: $showProfile, selectedProfile: $selectedProfile)
                                            
                                        } else if feedItem.type == .read {
                                            
                                            UserRead(post: feedItem.post!, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $postActions, showProfile: $showProfile, selectedProfile: $selectedProfile)
                                                .background(lightModeController.getBackgroundColor())

                                        } else if feedItem.type == .review {
                                            ReviewPreview(review: feedItem.review!, showBook: $showBook, selectedBook: $selectedBook, showReview: $showReview, selectedReview: $selectedReview, showProfile: $showProfile, selectedProfile: $selectedProfile)
                                                .background(lightModeController.getBackgroundColor())
                                            
                                            
                                        } else if feedItem.type == .quote {
                                            QuotePrev(showBook: $showBook, selectedBook: $selectedBook, showQuote: $showQuote, selectedQuote: $selectedQuote, showProfile: $showProfile, selectedProfile: $selectedProfile, showAuthor: $showAuthor, selectedAuthor: $selectedAuthor, quote: feedItem.quote!)
                                        }
                                      
                                        
                                        
                                        
                                    }
                                    .padding(.horizontal, iPadOrientation ? 30 : 0)
                                    
                                }
                                
                            }
                        }
                        .padding(.bottom, 60)
                        .id(refreshID) // Use the refresh trigger to force a refresh
                        .refreshable {
                            // Trigger a refresh without actually changing the comments
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                
                                self.refreshID = UUID() // Changing the ID forces the view to refresh
                            }
                        }
                        .sheet(isPresented: $showBook)  {
                            ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar)
                            
                        }
                    }
                    .padding(.top, 20)
                    .background(lightModeController.getBackgroundColor())
                    .foregroundColor(lightModeController.getForegroundColor())
                    .sheet(isPresented: $postActions){
                        PostActions(post: selectedPost, isPresenting: $postActions)
                            .presentationDetents([.fraction(0.4)])
                    }
                    
                    VStack {
                        Spacer()
                        HStack{
                            Spacer()
                            NewPostButton(createPost: $createPost)
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 90)
                    }
                    
                 
                    if showList {
                        if let user = sphereUsers.getUserById(userId: selectedList.user){
                            ListView(isPresenting: $showList, list: $selectedList, user: user)
                                .background(lightModeController.getBackgroundColor())
                                .foregroundColor(lightModeController.getForegroundColor())
                        }
                    }
                     
                    if showPost {
                        Rectangle()
                            .ignoresSafeArea()
                            .opacity(0.2)
                        
                        
                        PostView(post: $selectedPost, isPresenting: $showPost, showToolbar: $showToolbar)
                        
                        
                    }
                    
                    if showNotificationView {
                        NotificationView(showNotificationView: $showNotificationView)
                    }
                    
                    
                    
                    if showReview {
                        Rectangle()
                            .ignoresSafeArea()
                            .opacity(0.2)
                        
                        ReviewView(isPresenting: $showReview, review: $selectedReview)
                        
                        
                    }
                    
                    if showQuote {
                        Rectangle()
                            .ignoresSafeArea()
                            .opacity(0.2)
                        QuoteView(isLiked: $isLiked, showingQuote: $showQuote, quote: selectedQuote, showEReader: $showEReader, showToolbar: $showToolbar)
                    }
                    
                    if create {
                        
                        CreateView(create: $create)
                            .animation(.easeInOut)
                        
                    }
                    
                    if showProfile{
                        ProfileView(user: selectedProfile, isPresenting: $showProfile, showToolbar: $showToolbar)
                    }
                    
                    if showAuthor {
                        AuthorView(author: $selectedAuthor, showToolbar: $showToolbar, isPresenting: $showAuthor)
                    }
                    
                    if createPost {
                        WritePostView(isPresenting: $createPost)
                    }
                    
                    
                }
  
        }
    }
    /*
     struct FeedView2: View {
     @State var showPost = false
     @State var selectedPost = Post()
     
     @State var showNotificationView = false
     @State var showBook = false
     @State var selectedBook = Book()
     
     
     @State private var refreshID = UUID()
     @State var showReview = false
     @State var selectedReview = Review()
     @State var isLiked = false
     @State var showQuote = false
     @State var selectedQuote = Quote()
     @State var create = false
     @State var backgroundColor = Color(hex: "#FDFAEF")
     @State var postActions = false
     @State var showProfile = false
     @State var selectedProfile = User()
     
     @State var showEReader = false
     @Binding var showToolbar: Bool
     @EnvironmentObject var userData: UserData
     
     var body: some View {
     
     NavigationView {
     
     ZStack {
     VStack {
     HStack {
     
     Text("Sphere")
     .padding()
     .font(.system(size: 20, weight: .medium))
     .opacity(1) // Fade out when showSearchBar is true
     
     Spacer()
     
     Button(action: {showNotificationView = true}){
     Image(systemName: "bell")
     .font(.system(size: 18, weight: .medium))
     .padding()
     .foregroundColor(.black)
     
     }
     
     }
     .padding(.horizontal)
     ScrollView {
     VStack {
     ForEach(userData.user.feed, id: \.id) { feedItem in
     VStack {
     Text("Post")
     
     
     }
     
     }
     
     }
     }
     
     .id(refreshID) // Use the refresh trigger to force a refresh
     .refreshable {
     // Trigger a refresh without actually changing the comments
     DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
     
     self.refreshID = UUID() // Changing the ID forces the view to refresh
     }
     }
     }
     
     .background(backgroundColor)
     
     .sheet(isPresented: $postActions){
     PostActions(post: selectedPost, isPresenting: $postActions)
     .presentationDetents([.fraction(0.4)])
     }
     
     if showPost {
     Rectangle()
     .ignoresSafeArea()
     .opacity(0.2)
     PostView(post: $selectedPost, showingPost: $showPost, showEReader: $showEReader, showToolbar: $showToolbar)
     
     
     }
     
     if showNotificationView {
     NotificationView(showNotificationView: $showNotificationView)
     }
     
     if showBook {
     ContentView(viewController:  isPresenting: $showBook, showToolbar: $showToolbar)
     
     }
     
     if showReview {
     Rectangle()
     .ignoresSafeArea()
     .opacity(0.2)
     
     ReviewView(review: $selectedReview, showingReview: $showReview, showEReader: $showEReader, showToolbar: $showToolbar)
     
     
     }
     
     if showQuote {
     Rectangle()
     .ignoresSafeArea()
     .opacity(0.2)
     QuoteView(isLiked: $isLiked, post: $selectedPost, showingQuote: $showQuote, quote: selectedQuote, showEReader: $showEReader)
     }
     
     if create {
     
     CreateView(create: $create)
     .animation(.easeInOut)
     
     }
     
     if showProfile{
     ProfileView(user: selectedProfile, showToolbar: $showToolbar, isPresenting: $showProfile)
     }
     
     
     
     }
     }
     .navigationBarHidden(true)
     }
     }*/
    
    struct DiscussionPreview: View {
        var body: some View {
            VStack{
                HStack {
                    VStack {
                        Text("Discussion")
                        Text("x New Posts")
                        
                    }
                    Spacer()
                    
                }
                .padding(.horizontal)
            }
        }
    }
    
    struct PostActions: View {
        @State var post : Note
        @Binding var isPresenting : Bool
        
        var body: some View {
            VStack(alignment: .leading){
                Text("Save")
                    .font(.system(size: 14, weight: .medium))
                Divider()
                    .padding(.vertical, 2)
                Text("Share")
                    .font(.system(size: 14, weight: .medium))
                
                HStack {
                    Circle()
                        .frame(width: 30)
                    Circle()
                        .frame(width: 30)
                    Circle()
                        .frame(width: 30)
                    Circle()
                        .frame(width: 30)
                }
                Divider()
                    .padding(.vertical, 2)
                
                Text("Copy Link")
                    .font(.system(size: 14, weight: .medium))
                
                Divider()
                    .padding(.vertical, 2)
                
                Text("Includes Spoilers")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.orange)
                
                Divider()
                    .padding(.vertical, 2)
                Text("Report")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.red)
                
                Divider()
                    .padding(.vertical, 2)
                Text("Hide")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.red)
                
            }
            .padding(.horizontal)
        }
    }
    struct LikedDiscussionNotification: View {
        @ObservedObject var user = User()
        @State var post: Note = Note()
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack(){
                    ProfileThumbnail(image: "tia-williams", size: 55)
                    
                    Text("\(user.name) liked your post \(post.title)")
                        .font(.system(size: 14, weight: .medium))
                    
                    Spacer()
                }
                
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            
        }
    }
    
    struct RepliedToYourComment: View {
        @ObservedObject var user = User()
        @State var post: Note = Note()
        
        var body: some View {
            HStack(alignment: .top){
                ProfileThumbnail(image: "tia-williams", size: 55)
                VStack(alignment: .leading) {
                    
                    
                    
                    Text("\(user.name) replied to your comment:")
                        .font(.system(size: 14, weight: .medium))
                    
                    
                    Spacer()
                    Text("\"The reply goes here\"")
                        .font(.system(size: 14))
                        .padding(.top)
                }
                .padding(.top)
                
                Spacer()
                
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            
        }
    }
    struct LikedComment: View {
        @ObservedObject var user = User()
        @State var post: Note = Note()
        
        var body: some View {
            HStack(alignment: .top){
                ProfileThumbnail(image: "tia-williams", size: 55)
                VStack(alignment: .leading) {
                    
                    
                    
                    Text("\(user.name) liked your comment: \"Your comment\" ")
                        .font(.system(size: 14, weight: .medium))
                    
                    
                    
                }
                .padding(.top)
                
                Spacer()
                
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            
        }
    }
    
    struct LikedPost: View {
        @ObservedObject var user = User()
        @State var post: Note = Note()
        
        var body: some View {
            HStack(alignment: .top){
                ProfileThumbnail(image: "tia-williams", size: 55)
                VStack(alignment: .leading) {
                    
                    
                    
                    Text("\(user.name) liked your post:")
                        .font(.system(size: 14, weight: .medium))
                    
                    
                    Spacer()
                    Text("\"Your post\"")
                        .font(.system(size: 14))
                        .padding(.top)
                }
                .padding(.top)
                
                Spacer()
                
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            
        }
    }
    struct CommentedPostView: View {
        @ObservedObject var user = User()
        @State var post: Note = Note()
        
        var body: some View {
            HStack(alignment: .top){
                ProfileThumbnail(image: "tia-williams", size: 55)
                VStack(alignment: .leading) {
                    
                    
                    
                    Text("\(user.name) commented on your post \(post.title):")
                        .font(.system(size: 14, weight: .medium))
                    
                    
                    
                    Spacer()
                    Text("\"The comment goes here\"")
                        .font(.system(size: 14))
                        .padding(.top)
                }
                
                .padding(.top)
                
                Spacer()
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            
        }
    }
    struct NotificationView: View {
        @ObservedObject var user = User()
        
        @Binding var showNotificationView : Bool
        @State var create = false
        var body: some View {
            
            var book = Book()
            
            NavigationView {
                VStack{
                    HStack {
                        Button(action: {showNotificationView = false}) {               Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                        }
                        .transaction({ transaction in
                            transaction.disablesAnimations = true
                        })
                        .padding(.leading)
                        
                        Text("Notifications")
                            .padding()
                            .font(.system(size: 16, weight: .medium))
                            .opacity(1) // Fade out when showSearchBar is true
                        
                        Spacer()
                        
                        
                    }
                    
                    ScrollView {
                        VStack{
                            RepliedToYourComment()
                            Divider()
                            LikedDiscussionNotification(user: user)
                            
                            Divider()
                            CommentedPostView(user: user)
                            
                            Divider()
                            LikedComment()
                            Divider()
                            LikedPost()
                            
                        }
                        .padding(.top, 40)
                    }
                    
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
    
    struct AddedNotification: View {
        @ObservedObject var user: User
        @State var book: Book
        @Binding var showBook : Bool
        @Binding var selectedBook : Book
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack(){
                    ProfileThumbnail(image: "tia-williams", size: 35)
                    
                    Text("\(user.name)")
                        .font(.system(size: 14, weight: .medium))
                    
                    Text("added")
                        .font(.system(size: 14))
                        .padding(.horizontal, -4)
                    
                    Button(action: {
                        showBook = true
                        selectedBook = book
                    }){
                        Text("\(book.title)")
                            .font(.system(size: 14, weight: .medium))
                            .italic()
                    }
                    Spacer()
                }
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            
        }
    }
    
    struct LeftDiscussionNotification: View {
        @ObservedObject var user: User
        @State var book: Book
        @State var post: Note = Note()
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack(alignment: .top){
                    ProfileThumbnail(image: "tia-williams", size: 45)
                    
                    //             Text("\(user.name) left discussion post on \(book.title)")
                    
                    VStack(alignment: .leading){
                        
                        Text("\(user.name) on \(book.title)")
                            .font(.system(size: 14, weight: .medium))
                            .lineLimit(1)
                        
                        Spacer()
                        Image(book.cover)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .cornerRadius(3.0)
                        
                        
                        Text(post.title)
                            .font(.system(size: 15, weight: .medium))
                            .lineLimit(1)
                            .padding(.bottom)
                            .padding(.top)
                        Text(post.description)
                            .font(.system(size: 14))
                            .lineLimit(5)
                        
                    }
                    .padding(.top)
                    Spacer()
                }
                
                
                /*
                 Image(book.cover)
                 .resizable()
                 .scaledToFit()
                 .frame(width: 100)
                 .cornerRadius(3.0)
                 .padding(.leading, 55)
                 .padding(.leading)
                 */
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
    }
    
    struct RatedNotification: View {
        @ObservedObject var user: User
        @State var book: Book
        var body: some View {
            
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    ProfileThumbnail(image: "tia-williams", size: 45)
                    VStack(alignment: .leading){
                        Text("\(user.name) rated \(book.title)")
                            .font(.system(size: 14, weight: .medium))
                        Text("My Favorite Sphere First Read")
                            .font(.system(size: 15, weight: .medium))
                            .padding(.bottom, 2)
                            .padding(.top)
                        
                        
                        HStack{
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.orange)
                                .opacity(1)
                            
                            Text("4.5")
                                .padding(.leading, -5)
                                .font(.system(size: 13, weight: .medium))
                        }
                        
                        
                        Text("I read a lot and enjoy many of my Sphere \"free reads\", but of all so far I would say this is my absolute favorite. It sucked me in within the first few pages and I either didn't want to put it down at night or couldn't wait to start it again the next day. I will for sure be followiwng this author for anything new she has!!")
                            .font(.system(size: 14))
                            .lineLimit(5)
                            .padding(.vertical)
                        
                        Text("Feb 13 2024")
                            .padding(.vertical, 2)
                            .font(.system(size: 12))
                            .opacity(0.7)
                        
                        
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                }
                
                /*Image(book.cover)
                 .resizable()
                 .scaledToFit()
                 .frame(width: 100)
                 .cornerRadius(3.0)
                 .padding(.leading, 55)
                 .padding(.leading)*/
                
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            
        }
    }
    
    struct FinishedNotification: View {
        @ObservedObject var user: User
        @State var book: Book
        @Binding var showBook : Bool
        @Binding var selectedBook : Book
        
        var body: some View {
            VStack(alignment: .leading){
                HStack(){
                    ProfileThumbnail(image: "tia-williams", size: 35)
                    
                    Text("\(user.name)")
                        .font(.system(size: 14, weight: .medium))
                    
                    Text("finished")
                        .font(.system(size: 14))
                        .padding(.horizontal, -4)
                    
                    Button(action: {
                        showBook = true
                        selectedBook = book
                    }){
                        Text("\(book.title)")
                            .font(.system(size: 14, weight: .medium))
                            .italic()
                    }
                    Spacer()
                }
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            
        }
    }
    
    struct StartedNotification: View {
        @ObservedObject var user: User
        @State var book: Book
        var body: some View {
            VStack(alignment: .leading){
                HStack(){
                    ProfileThumbnail(image: "tia-williams", size: 55)
                    
                    Text("\(user.name) started reading \(book.title)")
                        .font(.system(size: 14, weight: .medium))
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            
        }
    }


/*
struct ListDisplay: View {
    @State var list : [View]
    var body: some View {
        
    }
}*/
/*
#Preview {
    //ActivityView()
    @State var showNotificationView = true

    return FeedView()
    //NotificationView(showNotificationView: $showNotificationView)
}
*/
