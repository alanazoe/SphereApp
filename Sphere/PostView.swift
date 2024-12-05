//
//  PostView.swift
//  media discussion
//
//  Created by Alana Greenaway on 1/28/24.
//

import SwiftUI

struct PostView: View {
    
    @State var isLiked = false
    @Binding var post: Note
    @State var backgroundColor = Color(hex: "#FDFAEF")
    
    @State private var selectedImageIndex = 0
    
    @Binding var isPresenting: Bool
    
    @State private var refreshID = UUID()
    @State var xoffset = 0.0
    @State var showContent = false
    @State var showProfile = false
    @State var selectedProfile = User()
    @EnvironmentObject var lightModeController: LightModeController

    @Binding var showToolbar: Bool
    
    @State private var showHeart = false
    @State var replying = false
    @State var replyTo = Comment()
    
    @State private var hideTopBar = false
    @State var revealed = false
    @EnvironmentObject var userData: UserData
    @State var showBook =  false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
            
            ZStack {
                
                
                    
                    VStack(){
                        HStack() {
                            Button(action: {isPresenting.toggle()}){
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .transaction({ transaction in
                                transaction.disablesAnimations = true
                            })
                            Spacer()
                            
                            
                        }
                        .foregroundColor(lightModeController.getForegroundColor())
                        //.ignoresSafeArea()
                        .padding()
                        .background(lightModeController.getBackgroundColor())
                        
                       
                        /*
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
                         */
                       // .padding(.bottom, 4)
                         
                        VStack(alignment: .leading){
                            ScrollView {
                                
                                HStack(alignment: .center) {
                                    Image(post.book.cover)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 35)
                                        .cornerRadius(4)
                                        .padding(5)
                                        .onTapGesture {
                                            showBook.toggle()
                                        }
                                    
                                    /* .background(
                                     RoundedRectangle(cornerRadius: 14)
                                     .foregroundColor(.white)
                                     )*/
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("\(post.book.title)")
                                                .font(.custom("Baskerville", size: 14.5))
                                            //.bold)
                                            
                                            
                                        }
                                        HStack(alignment: .top) {
                                            Text("BY")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size:10.5, weight:.medium))
                                                .opacity(0.5)
                                            
                                            Text("\(post.book.author.name)")
                                                .padding(.leading, -2)
                                                .font(.system(size:13.5, weight:.medium))
                                                .multilineTextAlignment(.center)
                                                .lineLimit(1)
                                            //.textCase(.uppercase)
                                            
                                            
                                            
                                        }
                                        .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                                        
                                        
                                        
                                        
                                    }
                                    .frame(height: 35)
                                    Spacer()
                                    AddToListButton(book: $post.book, fontSize: 12.5)
                                    
                                }
                                .padding(15)
                                .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                                    .fill(Color(hex: "#fffef8"))
                                            
                                )
                                .onTapGesture {
                                    showBook.toggle()
                                }
                                .padding([.horizontal, .bottom])
                                .padding(.top, 2)
                                
                                VStack(alignment: .leading) {
                                    HStack{
                                        /*Text(review.rating.book.title)
                                         .font(.custom("Georgia", size: 14.5))
                                         .bold()
                                         .lineLimit(1)
                                         .frame(width: 190, alignment: .leading)*/
                                        
                                        ProfileThumbnail(image: post.user.photo, size: 30)
                                        Text("\(post.user.name)")
                                            .font(.system(size: 14, weight: .medium))
                                            .padding(.trailing, -4)
                                        
                                        Spacer()
                                        Text(timeSince(from: post.timestamp))
                                        //.padding(.vertical, 2)
                                            .font(.system(size: 11))
                                            .opacity(0.7)
                                        
                                    }
                                    .padding(.vertical, 8)
                                    
                                    HStack {
                                        Text(post.title)
                                            .font(.system(size: 16.5, weight: .medium))
                                            .lineSpacing(4)
                                            .lineLimit(2)
                                            .padding(.bottom, 4)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    Text(post.description)
                                        .font(.system(size: 15.5))
                                        .lineSpacing(4)
                                    
                                    HStack {
                                        if post.likes > 0 {
                                            Text("\(post.likes) likes")
                                                .padding(.trailing)
                                        }
                                        if post.comments.count > 1 {
                                            Text("\(post.comments.count) comments")
                                        } else if post.comments.count == 1 {
                                            Text("1 comment")

                                        }
                                        Spacer()
                                        UpvoteDownvote(post: $post)
                                        
                                    }
                                    .font(.system(size: 12.5))
                                    .opacity(0.7)
                                    .padding(.top)
                                    .padding(.trailing)
                                }
                                .padding(25)
                                .background(Color(hex: "#fffef8"))
                                .overlay(
                                    VStack{
                                        Divider()
                                            .opacity(0.7)
                                        Spacer()
                                        Divider()
                                            .opacity(0.7)
                                    }
                                )

                                    VStack(spacing: 14) {
                                        
                                        Divider()
                                            .padding(.vertical)
                                            .opacity(0.7)
                                        ForEach(post.comments) { comment in
                                            if !comment.isReply {
                                                EComment(comment: comment, replying: $replying, replyTo: $replyTo)
                                            }
                                        }
                                    }
                                    
                               
                                
                                
                            }
                            
                        }

                        CommentField(comments: $post.comments, replying: $replying, replyTo: $replyTo)
                    }
                    .sheet(isPresented: $showBook){
                        ContentView(book: $post.book, isPresenting: $showBook, showToolbar: .constant(true))
                    }
                    /*.sheet(isPresented: $showReview){
                        ReviewView(isPresenting: $showReview, review: $review)
                    }*/
                    
             
                /*
                
                VStack {
                    ZStack {
                        HStack {
                            Button(action: { showingPost = false }) {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.leading)
                            }
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.trailing)
                            }
                            Button(action: {}) {
                                Image(systemName: "square.and.arrow.up")
                                    .padding(.trailing)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                            }
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 4)
                        .padding(.top)
                        .background(backgroundColor)
                        .opacity(hideTopBar ? 0 : 1)
                        .animation(.easeInOut(duration: 0.3), value: hideTopBar)
                    }
                    
                    
                        
                        ScrollView {
                            GeometryReader { geometry in
                                Color.clear
                                    .preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .global).minY)
                            }
                            .frame(height: 0)
                            
                            VStack {
                                
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading) {
                                        Button(action: {
                                            selectedProfile = post.user
                                            showProfile = true
                                        }) {
                                            HStack {
                                                ProfileThumbnail(image: post.user.photo, size: 30)
                                                
                                                Text("\(post.user.name)")
                                                    .font(.system(size: 15, weight: .medium))
                                                    .padding(.trailing, -1)
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        
                                        Tag(tag: "Chapter 2")
                                    }
                                    
                                    Spacer()
                                    Button(action: { showContent = true }) {
                                        Image(post.book.cover)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 100)
                                            .clipped()
                                            .cornerRadius(6)
                                            .shadow(radius: 0.5)
                                    }
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                
                                VStack(alignment: .leading) {
                                    let read = userData.user.read(book: post.book)
                                    if !read && post.spoiler && !revealed {
                                        Button(action: {
                                            revealed = true
                                        }){
                                            SpoilerAlert()
                                        }
                                    } else {
                                        Text(post.title)
                                            .font(.system(size: 17, weight: .medium))
                                            .padding(.vertical, 2)
                                        
                                        Text(post.description)
                                            .font(.system(size: 16))
                                            .lineSpacing(4)
                                            .padding(.vertical)
                                            .multilineTextAlignment(.leading)
                                    }
                                    HStack {
                                        Text(timeSince(from: post.timestamp))
                                            .padding(.vertical, 2)
                                            .font(.system(size: 12))
                                            .opacity(0.7)
                                        
                                        Spacer()
                                        Text("\(post.likes) likes")
                                            .font(.system(size: 12))
                                            .padding(.vertical, 2)
                                            .opacity(0.7)
                                            .padding(.trailing)
                                        
                                        if post.comments.count > 0 {
                                            Text("\(post.comments.count) comments")
                                                .font(.system(size: 13))
                                                .opacity(0.7)
                                                .padding(.trailing)
                                        }
                                        if !isLiked {
                                            Button(action: {
                                                isLiked.toggle()
                                                post.likes += 1
                                            }) {
                                                Image(systemName: "heart")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(.black)
                                            }
                                        } else {
                                            Button(action: { isLiked.toggle() }) {
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(.pink)
                                            }
                                        }
                                        
                                    }
                                    .offset(y: 15)
                                    .padding(.bottom)
                                    
                                    Divider()
                                        .padding(.bottom)
                                        .padding(.top)
                                    VStack(spacing: 14) {
                                        ForEach(post.comments) { comment in
                                            if !comment.isReply {
                                                EComment(comment: comment, replying: $replying, replyTo: $replyTo)
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                            .background(backgroundColor)
                            
                        }
                        .coordinateSpace(name: "scroll")
                        .onPreferenceChange(ScrollOffsetKey.self) { value in
                            withAnimation {
                                hideTopBar = value < -50
                            }
                        }
                        .padding(.bottom, 70)
                        .id(refreshID)
                        .refreshable {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.refreshID = UUID()
                            }
                        }
                        //.padding(.bottom, 30)
                        .overlay(
                            VStack {
                                Spacer()
                                CommentField(comments: $post.comments, replying: $replying, replyTo: $replyTo)
                            }
                        )
                    
                }
                

                if showHeart {
                    HeartView()
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                }

                if showContent {
                    ContentView(book: $post.book, isPresenting: $showContent, showToolbar: $showToolbar)
                }
                
                if showProfile {
                    ProfileView(user: post.user, isPresenting: $showProfile, showToolbar: $showToolbar)
                }
                 */
            }
            //.frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
        .onAppear {
            showToolbar = false
        }
        .onDisappear {
            showToolbar = true
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
    }
    
    func timeSince(from date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
        
        if let year = components.year, year > 0 {
            return "\(year) y"
        } else if let month = components.month, month > 0 {
            return "\(month) mon"
        } else if let day = components.day, day  > 0 {
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

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct MiniRatingPreview: View {
    @State var rating: Rating
    @Binding var showBook: Bool
    @EnvironmentObject var lightModeController: LightModeController
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var bookHeight = 50.0
    var titleFontSize = 16.0
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        VStack {
            HStack(alignment: .center) {
                Image(rating.book.cover)
                    .resizable()
                    .scaledToFit()
                    .frame(height: bookHeight)
                    .cornerRadius(4)
                    .padding(5)
                    .onTapGesture {
                        showBook.toggle()
                    }
                
                /* .background(
                 RoundedRectangle(cornerRadius: 14)
                 .foregroundColor(.white)
                 )*/
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(rating.book.title)")
                            .font(.custom("Baskerville", size: titleFontSize))
                            .padding(.bottom, 2)
                        
                        
                        
                    }
                    HStack(alignment: .top) {
                        Text("BY")
                            .multilineTextAlignment(.center)
                            .font(.system(size:10.5, weight:.medium))
                            .opacity(0.5)
                        
                        Text("\(rating.book.author.name)")
                            .padding(.leading, -2)
                            .font(.system(size:13.5, weight:.medium))
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        //.textCase(.uppercase)
                    }
                    .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                    
                }
                .frame(height: bookHeight)
                Spacer()
                AddToListButton(book: $rating.book, fontSize: 12.5)
                
            }
                Divider()
                    .opacity(0.8)
                HStack{
                    /*Text(review.rating.book.title)
                     .font(.custom("Georgia", size: 14.5))
                     .bold()
                     .lineLimit(1)
                     .frame(width: 190, alignment: .leading)*/
                    
                    ProfileThumbnail(image: rating.user.photo, size: 30)
                    Text("\(rating.user.name)")
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
                    ReviewStars(rating: rating.stars)
                    Spacer()
                    
                }
                .padding(.vertical, 8)
            
        }
        .padding(15)
        //.frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
        .background(RoundedRectangle(cornerRadius: 10)
            .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
            .fill(Color(hex: "#fffef8"))
                    
        )
        .onTapGesture {
            showBook.toggle()
        }
        .padding(.top, 2)
        .sheet(isPresented: $showBook){
            ContentView(book: $rating.book, isPresenting: $showBook, showToolbar: .constant(false))
        }
        
    }
}


struct MiniBookPreview: View {
    @State var book: Book
    @Binding var showBook: Bool
    @EnvironmentObject var lightModeController: LightModeController
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var bookHeight = 60.0
    var cornerRadius = 4.0
    var titleFontSize = 18.0
    var inline = false
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        HStack(alignment: .center) {
            Image(book.cover)
                .resizable()
                .scaledToFit()
                .frame(height: bookHeight)
                .cornerRadius(cornerRadius)
                .padding(5)
                .onTapGesture {
                    showBook.toggle()
                }
            
            /* .background(
             RoundedRectangle(cornerRadius: 14)
             .foregroundColor(.white)
             )*/
            VStack(alignment: .leading) {
                HStack {
                    Text("\(book.title)")
                        .font(.custom("Baskerville", size: titleFontSize))
                        .padding(.bottom, 2)
                        //.bold()
                                                           
                    if inline {
                        
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
                                
                                
                                
                            }
                            .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                            
                            
                        
                    }
                    
                }
                if !inline {
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
                        
                        
                        
                    }
                    .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                    
                    
                }
                
            }
            .frame(height: bookHeight)
            Spacer()
            AddToListButton(book: $book, fontSize: 12.5)
            
        }
        .padding(bookHeight < 31 ? 8 : 15)
        .padding(.horizontal, bookHeight < 31 ? 7 : 0)

        //.frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
        .background(RoundedRectangle(cornerRadius: 10)
            .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
            .fill(Color(hex: "#fffef8"))
                    
        )
        .onTapGesture {
            showBook.toggle()
        }
        .padding(.bottom)
        .padding(.top, 2)
        .sheet(isPresented: $showBook){
            ContentView(book: $book, isPresenting: $showBook, showToolbar: .constant(false))
        }
        
    }
}




struct HeartView: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 1.0
    @State private var offset: CGFloat = 0.0

    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .foregroundColor(.pink)
            .frame(width: 100, height: 100)
            .scaleEffect(scale)
            .opacity(opacity)
            .offset(y: offset)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.0)) {
                    self.scale = 1.5
                    self.opacity = 0.0
                    self.offset = -200
                }
            }
    }
}


struct QuoteView: View {
    
    @Binding var isLiked : Bool

       // @Binding var user: User
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State private var media: Book = Book()

        @State private var selectedImageIndex = 0
    
    @Binding var showingQuote : Bool
    
    @State private var refreshID = UUID()
    @State var xoffset = 0.0
    @State var showContent = false
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var quote : Quote2
    @Binding var showEReader: Bool
    @State var replying = false
    @State var replyTo = Comment()
    @State private var showHeart = false
    @Binding var showToolbar: Bool
    @State var showAuthor: Bool = false
    @State var selectedAuthor: Author = Author()
    @EnvironmentObject var userData: UserData

    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack {
                    ZStack {
                        HStack {
                            Button(action: { showingQuote = false }) {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.leading)
                            }
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.trailing)
                            }
                            Button(action: {}) {
                                Image(systemName: "square.and.arrow.up")
                                    .padding(.trailing)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                            }
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 4)
                        .padding(.top)
                        .background(backgroundColor)
                        //.opacity(hideTopBar ? 0 : 1)
                        //.animation(.easeInOut(duration: 0.3), value: hideTopBar)
                    }
                    
                    
                        
                        ScrollView {
                            GeometryReader { geometry in
                                Color.clear
                                    .preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .global).minY)
                            }
                            .frame(height: 0)
                            
                            VStack {
                                
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading) {
                                        Button(action: {
                                            selectedProfile = quote.user
                                            showProfile = true
                                        }) {
                                            HStack {
                                                ProfileThumbnail(image: quote.user.photo, size: 30)
                                                
                                                Text("\(quote.user.name)")
                                                    .font(.system(size: 15, weight: .medium))
                                                    .padding(.trailing, -1)
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        
                                        Tag(tag: "Chapter 2")
                                    }
                                    
                                    Spacer()
                                    Button(action: { showContent = true }) {
                                        Image(quote.book.cover)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 100)
                                            .clipped()
                                            .cornerRadius(6)
                                            .shadow(radius: 0.5)
                                    }
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                
                                VStack(alignment: .leading) {
                                    /*
                                    let read = userData.user.read(book: post.book)
                                    if !read && post.spoiler && !revealed {
                                        Button(action: {
                                            revealed = true
                                        }){
                                            SpoilerAlert()
                                        }
                                    } else {
                                        */
                                    
                                    HighlightedText(text: quote.quote, frameWidth: 315)
                                            //.lineLimit(7)
                                            
                                    /* ——— */
                                    
                                    HStack{
                                        Spacer()
                                        HStack {
                                            Button(action: {
                                                showAuthor = true
                                                selectedAuthor = quote.book.author
                                            }){
                                                Text("\(quote.book.author.name), ")
                                            }
                                            Button(action: { showContent = true
                                                
                                            }){
                                                Text("\(quote.book.title)")
                                                    .underline(true, color: .black)
                                                    .padding(.leading, -4)
                                            }
                                                
                                        }
                                            .font(.system(size: 12.5))
                                            .foregroundColor(.black)
                                            .padding(.vertical)
                                            .padding(.trailing, 4)
                                    }
                                        Text(quote.title)
                                            .font(.system(size: 17, weight: .medium))
                                            .padding(.vertical, 2)
                                        
                                        Text(quote.description)
                                            .font(.system(size: 16))
                                            .lineSpacing(4)
                                            .padding(.vertical)
                                            .multilineTextAlignment(.leading)
                                    //}
                                    HStack {
                                        Text(timeSince(from: quote.timestamp))
                                            .padding(.vertical, 2)
                                            .font(.system(size: 12))
                                            .opacity(0.7)
                                        
                                        Spacer()
                                        Text("\(quote.likes) likes")
                                            .font(.system(size: 12))
                                            .padding(.vertical, 2)
                                            .opacity(0.7)
                                            .padding(.trailing)
                                        
                                        if quote.comments.count > 0 {
                                            Text("\(quote.comments.count) comments")
                                                .font(.system(size: 13))
                                                .opacity(0.7)
                                                .padding(.trailing)
                                        }
                                        if !isLiked {
                                            Button(action: {
                                                isLiked.toggle()
                                                quote.likes += 1
                                            }) {
                                                Image(systemName: "heart")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(.black)
                                            }
                                        } else {
                                            Button(action: { isLiked.toggle() }) {
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(.pink)
                                            }
                                        }
                                        
                                    }
                                    .offset(y: 15)
                                    .padding(.bottom)
                                    
                                    Divider()
                                        .padding(.bottom)
                                        .padding(.top)
                                    VStack(spacing: 14) {
                                        ForEach(quote.comments) { comment in
                                            if !comment.isReply {
                                                EComment(comment: comment, replying: $replying, replyTo: $replyTo)
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                            .background(backgroundColor)
                            
                        }
                        .coordinateSpace(name: "scroll")
                    /*
                        .onPreferenceChange(ScrollOffsetKey.self) { value in
                            withAnimation {
                                hideTopBar = value < -50
                            }
                        }*/
                        .padding(.bottom, 70)
                        .id(refreshID)
                        .refreshable {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.refreshID = UUID()
                            }
                        }
                        //.padding(.bottom, 30)
                        .overlay(
                            VStack {
                                Spacer()
                                CommentField(comments: $quote.comments, replying: $replying, replyTo: $replyTo)
                            }
                        )
                    
                }
                .background(backgroundColor)
                .gesture(
                    TapGesture(count: 2)
                        .onEnded {
                            withAnimation {
                                showHeart = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    showHeart = false
                                }
                            }
                            if !isLiked {
                                isLiked.toggle()
                                quote.likes += 1
                            }
                        }
                )

                if showHeart {
                    HeartView()
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                }

                if showContent {
                    ContentView(book: $media, isPresenting: $showContent, showToolbar: $showToolbar)
                }
                
                if showProfile {
                    ProfileView(user: quote.user, isPresenting: $showProfile, showToolbar: $showToolbar)
                }
            }
        }
        .onAppear {
            showToolbar = false
        }
        .onDisappear {
            showToolbar = true
        }
        .navigationBarHidden(true)
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
                            showingQuote = false
                        }
                    } else {
                        self.xoffset = 0
                    }
                }
        )
        .animation(.easeOut, value: xoffset)
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
        } else if let second = components.second, second > 0 {
            return "\(second) s"
        } else {
            return "Just now"
        }
    }

 
}

struct IndentedQuoteView: View {
    var text: String
    var highlightColor: Color = Color.purple.opacity(0)//0.15)
    var textColor: Color = Color.black
    var frameWidth: CGFloat = 300
    var lineSpacing: CGFloat = 0
    var fontSize: CGFloat = 15.0

    private func splitTextIntoLines(text: String, frameWidth: CGFloat, font: UIFont) -> [String] {
        var lines: [String] = []
        var currentLine: String = ""
        var currentWidth: CGFloat = 0

        let words = text.split(separator: " ", omittingEmptySubsequences: false)
        
        for word in words {
            if word.contains("\n") {
                let subWords = word.split(separator: "\n", omittingEmptySubsequences: true)
                for subWord in subWords {
                    let wordWidth = (subWord as NSString).size(withAttributes: [.font: font]).width
                    let spaceWidth = (" " as NSString).size(withAttributes: [.font: font]).width
                    
                    if currentWidth + wordWidth > frameWidth {
                        lines.append(currentLine)
                        currentLine = String(subWord)
                        currentWidth = wordWidth
                    } else {
                        if !currentLine.isEmpty {
                            currentLine += " "
                            currentWidth += spaceWidth
                        }
                        currentLine += subWord
                        currentWidth += wordWidth
                    }
                    
                    lines.append(currentLine)
                    
                    currentLine = ""
                    currentWidth = 0
                }
            } else {
                let wordWidth = (word as NSString).size(withAttributes: [.font: font]).width
                let spaceWidth = (" " as NSString).size(withAttributes: [.font: font]).width
                
                if currentWidth + wordWidth + spaceWidth > frameWidth {
                    lines.append(currentLine)
                    currentLine = String(word)
                    currentWidth = wordWidth
                } else {
                    if !currentLine.isEmpty {
                        currentLine += " "
                        currentWidth += spaceWidth
                    }
                    currentLine += word
                    currentWidth += wordWidth
                }
            }
        }
        
        if !currentLine.isEmpty {
            lines.append(currentLine)
        }
        
        return lines
    }

    private func calculateHeight(for lines: [String], fontSize: CGFloat, lineSpacing: CGFloat) -> CGFloat {
        let lineHeight = UIFont.systemFont(ofSize: fontSize).lineHeight
        let padding: CGFloat = 4 // Adjust the padding if necessary
        return CGFloat(lines.count) * (lineHeight + padding) + CGFloat(lines.count - 1) * lineSpacing
    }

    var body: some View {
        let font = UIFont.systemFont(ofSize: fontSize)
        let lines = splitTextIntoLines(text: text, frameWidth: frameWidth, font: font)
        let totalHeight = calculateHeight(for: lines, fontSize: fontSize, lineSpacing: lineSpacing)

        return HStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 0.8, height: totalHeight * 0.85)
                .foregroundColor(.black)
                .opacity(0.6)
                .padding(.trailing, 4)
            
            VStack(alignment: .leading, spacing: lineSpacing) {
                ForEach(lines, id: \.self) { line in
                    Text(line)
                        .font(.custom("Georgia", size: fontSize))

                        //.font(.system(size: fontSize))
                        .foregroundColor(textColor)
                        .opacity(0.8)
                        .padding(.vertical, 2) // Adjust padding here if necessary
                        .background(highlightColor.cornerRadius(2))
                        .padding(.horizontal, -4)
                }
            }
        }
        .frame(width: frameWidth)
    }
}


struct HighlightedText: View {
    var text: String
    var highlightColor: Color = Color.purple.opacity(0.15)
    var textColor: Color = Color.black
    var frameWidth: CGFloat = 300
    var lineSpacing: CGFloat = 5.0
    var fontSize: CGFloat = 15.0

    private func splitTextIntoLines(text: String, frameWidth: CGFloat, font: UIFont) -> [String] {
        var lines: [String] = []
        var currentLine: String = ""
        var currentWidth: CGFloat = 0

        let words = text.split(separator: " ", omittingEmptySubsequences: false)
        
        for word in words {
            if word.contains("\n") {
                let subWords = word.split(separator: "\n", omittingEmptySubsequences: true)
                for subWord in subWords {
                    let wordWidth = (subWord as NSString).size(withAttributes: [.font: font]).width
                    let spaceWidth = (" " as NSString).size(withAttributes: [.font: font]).width
                    
                    if currentWidth + wordWidth > frameWidth {
                        lines.append(currentLine)
                        currentLine = String(subWord)
                        currentWidth = wordWidth
                    } else {
                        if !currentLine.isEmpty {
                            currentLine += " "
                            currentWidth += spaceWidth
                        }
                        currentLine += subWord
                        currentWidth += wordWidth
                    }
                    
                    lines.append(currentLine)
                    
                    currentLine = ""
                    currentWidth = 0
                }
            } else {
                let wordWidth = (word as NSString).size(withAttributes: [.font: font]).width
                let spaceWidth = (" " as NSString).size(withAttributes: [.font: font]).width
                
                if currentWidth + wordWidth + spaceWidth > frameWidth {
                    lines.append(currentLine)
                    currentLine = String(word)
                    currentWidth = wordWidth
                } else {
                    if !currentLine.isEmpty {
                        currentLine += " "
                        currentWidth += spaceWidth
                    }
                    currentLine += word
                    currentWidth += wordWidth
                }
            }
        }
        
        if !currentLine.isEmpty {
            lines.append(currentLine)
        }
        
        return lines
    }

    private func calculateHeight(for lines: [String], fontSize: CGFloat, lineSpacing: CGFloat) -> CGFloat {
        let lineHeight = UIFont.systemFont(ofSize: fontSize).lineHeight
        let padding: CGFloat = 4 // Adjust the padding if necessary
        return CGFloat(lines.count) * (lineHeight + padding) + CGFloat(lines.count - 1) * lineSpacing
    }

    var body: some View {
        let font = UIFont.systemFont(ofSize: fontSize)
        let lines = splitTextIntoLines(text: text, frameWidth: frameWidth, font: font)
        let totalHeight = calculateHeight(for: lines, fontSize: fontSize, lineSpacing: lineSpacing)

        return
            VStack(alignment: .leading, spacing: lineSpacing) {
                ForEach(lines, id: \.self) { line in
                    Text(line)
                        .font(.system(size: fontSize))
                        .foregroundColor(textColor)
                        .padding(.vertical, 2) // Adjust padding here if necessary
                        .background(highlightColor.cornerRadius(2))
                        .padding(.horizontal, -4)
                }
            }
        
            .frame(width: frameWidth)
    }
}



struct ReviewView: View {
    @Binding var isPresenting: Bool
    @Binding var review: Review
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var lightModeController: LightModeController
    @State var isLiked : Bool = false
    @EnvironmentObject var userData: UserData
    @State var showBook: Bool = false
    @State var replying = false
    @State var replyTo = Comment()
    @State var showShare = false
    @State var xoffset = 0.0

    
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        VStack() {
            VStack {
                HStack() {
                    Button(action: {isPresenting.toggle()}){
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .transaction({ transaction in
                        transaction.disablesAnimations = true
                    })
                    Spacer()
                    
                    
                }
                .foregroundColor(lightModeController.getForegroundColor())
                //.ignoresSafeArea()
                .padding()
                .background(lightModeController.getBackgroundColor())
                
                ScrollView {
                    VStack(alignment: .center){
                        
                        HStack(alignment: .center) {
                            Image(review.rating.book.cover)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 35)
                                .cornerRadius(4)
                                .padding(5)
                                .onTapGesture {
                                    showBook.toggle()
                                }
                            
                            /* .background(
                             RoundedRectangle(cornerRadius: 14)
                             .foregroundColor(.white)
                             )*/
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(review.rating.book.title)")
                                        .font(.custom("Baskerville", size: 14.5))
                                    //.bold)
                                    
                                    
                                }
                                HStack(alignment: .top) {
                                    Text("BY")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size:10.5, weight:.medium))
                                        .opacity(0.5)
                                    
                                    Text("\(review.rating.book.author.name)")
                                        .padding(.leading, -2)
                                        .font(.system(size:13.5, weight:.medium))
                                        .multilineTextAlignment(.center)
                                        .lineLimit(1)
                                    //.textCase(.uppercase)
                                    
                                    
                                    
                                }
                                .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                                
                                
                                
                                
                            }
                            .frame(height: 35)
                            Spacer()
                            AddToListButton(book: $review.rating.book, fontSize: 12.5)
                            
                        }
                        .padding(15)
                        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                            .fill(Color(hex: "#fffef8"))
                                    
                        )
                        .onTapGesture {
                            showBook.toggle()
                        }
                        .padding([.horizontal, .bottom])
                        .padding(.top, 2)
                        VStack {
                            
                            
                            HStack{
                                
                                
                                ProfileThumbnail(image: review.rating.user.photo, size: 30)
                                Text("\(review.rating.user.name)")
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
                                ReviewStar(rating: review.rating.stars)
                                Spacer()
                                Text(timeSince(from: review.timestamp))
                                //.padding(.vertical, 2)
                                    .font(.system(size: 11))
                                    .opacity(0.7)
                                
                            }
                            .padding(.vertical, 8)
                            
                            Text(review.description)
                                .font(.system(size: 15.5))
                                .lineSpacing(4)
                            
                            HStack {
                                if review.likes > 0 {
                                    
                                    Text("\(review.likes) likes")
                                        .padding(.trailing)
                                }
                                if review.comments.count > 0 {
                                    
                                    Text("\(review.comments.count) comments")
                                }
                                Spacer()
                                if !isLiked {
                                    Button(action: {
                                        isLiked.toggle()
                                        review.likes += 1
                                        
                                    }){
                                        Image(systemName: "heart")
                                            .font(.system(size: 16))
                                            .foregroundColor(.black)
                                    }
                                } else {
                                    Button(action: {
                                        isLiked.toggle()
                                        review.likes -= 1
                                        
                                    }){
                                        Image(systemName: "heart.fill")
                                            .font(.system(size: 16))
                                            .foregroundColor(.pink)
                                    }
                                }
                                
                            }
                            .padding(.top)
                            .font(.system(size: 12.5))
                            .opacity(0.7)
                            
                        }
                        .padding(25)
                        .background(Color(hex: "#fffef8"))
                        .overlay(
                            VStack{
                                Divider()
                                    .opacity(0.7)
                                Spacer()
                                Divider()
                                    .opacity(0.7)
                            }
                        )

                            
                            VStack(spacing: 14) {
                                
                                
                                ForEach(review.comments) { comment in
                                    if !comment.isReply {
                                        EComment(comment: comment, replying: $replying, replyTo: $replyTo)
                                    }
                                }
                            }
                            
                       
                        
                    
                    //.frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.90)
                                        
            
                    }
            
                    
                }

                CommentField(comments: $review.comments, replying: $replying, replyTo: $replyTo)
                
                //ReviewCommentField(review: review, replying: $replying, replyTo: $replyTo)
                
            }
            .sheet(isPresented: $showBook){
                ContentView(book: $review.rating.book, isPresenting: $showBook, showToolbar: .constant(true))
            }
            
        }
        .onAppear {
            //showToolbar = false
        }
        .onDisappear {
           // showToolbar = true
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
    }
}

struct SpoilerAlert: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 14)
            .overlay(
                VStack {
                    Image(systemName: "bubbles.and.sparkles.fill")
                        .font(.system(size:25))
                        .foregroundColor(.black)
                        .opacity(0.4)
                        .padding(.bottom, 2)
                    
                    Text("May contain spoilers")
                        .font(.system(size:14))
                        .foregroundColor(.black)
                        .opacity(0.4)
                    
                    

                }
            )
            .frame(height: 140)
            .frame(maxWidth: UIScreen.main.bounds.width)
            .foregroundColor(Color(hex: "#ECE8DA"))
    }
}

       
struct CommentField: View {
    @State private var comment: String = "" // This will hold the text input from the user
    @Binding var comments: [Comment]
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var userData: UserData
    @Binding var replying: Bool
    @Binding var replyTo: Comment
    @EnvironmentObject var lightModeController: LightModeController
    @State private var dynamicHeight: CGFloat = 0

    var body: some View {
        
        HStack(alignment: .bottom) {
            ProfileThumbnail(image: userData.user.photo , size: 40)
            
            VStack {
                if replying {
                    HStack {
                        Text("Replying to \(replyTo.user.name)")
                            .font(.system(size: 14, weight: .medium))
                        Spacer()
                        Button(action: { replying.toggle() }){
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black)

                        }
                    }

                }
                NoteTextEditor(text: $comment, backgroundColor: UIColor(Color(lightModeController.getBackgroundColor())), dynamicHeight: $dynamicHeight, placeholder: "Leave a comment")
                //.padding(.horizontal, -5)
                    .frame(height: dynamicHeight)
                    .font(.system(size: 18, weight: .medium))
                    
            }
            if comment != ""{
                Button(action: {
                    
                    submitComment()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                }
                .padding()
            }
            
        }
        .padding()
        .background(lightModeController.getBackgroundColor())
        
        
    }
    private func submitComment() {
        let newComment = Comment(id: UUID(), user: userData.user, comment: comment, likes: 0, timestamp: Date(), isReply: false)
        if replying {
            newComment.replyTo = replyTo
            newComment.isReply = true
            replyTo.replies.append(newComment)

        }
        replying = false
        comments.append(newComment)
        comment = "" // Clear the comment field
        
        // Dismiss the keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct EComment: View {
    @State var comment: Comment
    @State var isLiked = false
    @Binding var replying: Bool
    @Binding var replyTo: Comment
    @State var showAll = false
    @EnvironmentObject var lightModeController: LightModeController
    @State var showProfile: Bool = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        VStack {
        VStack(alignment: .leading) {
            HStack{
                /*Text(review.rating.book.title)
                 .font(.custom("Georgia", size: 14.5))
                 .bold()
                 .lineLimit(1)
                 .frame(width: 190, alignment: .leading)*/
                
                ProfileThumbnail(image: comment.user.photo, size: 30)
                Text("\(comment.user.name)")
                    .font(.system(size: 14, weight: .medium))
                    .padding(.trailing, -4)
                
                Spacer()
                Text(timeSince(from: comment.timestamp))
                //.padding(.vertical, 2)
                    .font(.system(size: 11))
                    .opacity(0.7)
                
            }
            .padding(.vertical, 8)
            
            Text(comment.comment)
                .font(.system(size: 15.5))
                .lineSpacing(4)
            
            HStack {
                Button(action: {
                    replying = true
                    replyTo = comment
                }){
                    Text("Reply")
                        .font(.system(size: 13, weight: .medium))
                        .padding(.trailing, 8)
                        .foregroundColor(lightModeController.getForegroundColor())
                        .opacity(0.7)
                }
                
                /*
                if comment.likes > 0 {
                    Text("\(comment.likes) likes")
                        .padding(.trailing)
                }*/
                if comment.replies.count > 0 {
                    Text("\(comment.replies.count) replies")
                }
                
                Spacer()
                if !isLiked {
                    Button(action: {
                        isLiked.toggle()
                        comment.likes += 1
                        
                    }){
                        HStack {
                            if comment.likes > 0 {
                                
                                Text("\(comment.likes)")
                                    .padding(.trailing, -5)
                                    .font(.system(size: 13))
                            }

                        Image(systemName: "heart")
                            .font(.system(size: 16))
                                 }
                        .foregroundColor(.black)

                    }
                } else {
                    Button(action: {
                        isLiked.toggle()
                        comment.likes -= 1
                        
                    }){
                        HStack {
                            if comment.likes > 0 {
                                
                                Text("\(comment.likes)")
                                    .padding(.trailing, -7)
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)

                            }
                            Image(systemName: "heart.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.pink)
                        }

                    }
                }
                
            }
            .font(.system(size: 12.5))
            .opacity(0.7)
            .padding(.top)
            
            
        }
        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.90)
        .sheet(isPresented: $showProfile){
            ProfileView(user: comment.user, isPresenting: $showProfile, showToolbar: .constant(true))
        }
        
        if showAll {
            ForEach(comment.replies) { reply in
                ReplyComment(comment: reply, replying: $replying, replyTo: $replyTo)
                
                
            }
            HStack {
                Button("——— Hide Replies"){
                    showAll.toggle()
                }
                .font(.system(size: 13, weight: .medium))
                .opacity(0.7)
                Spacer()
            }
            .padding(.leading, 35)
            .padding(.bottom, 7)
            
        } else {
            ForEach(comment.replies.prefix(1), id: \.id) { reply in
                ReplyComment(comment: reply, replying: $replying, replyTo: $replyTo)
                    
                    //.padding(.trailing, UIScreen.main.bounds.width * 0.10)
                
            }
            if comment.replies.count > 1 {
                HStack {
                    Button("——— View \(comment.replies.count-1) more replies"){
                        showAll = true
                    }
                    .font(.system(size: 13, weight: .medium))
                    .opacity(0.7)
                    Spacer()
                }
                .padding(.leading, 25)
                .padding(.bottom, 7)
            }
        }

        }  
        .padding(.vertical)
        .background(Color(hex: "#fffef8"))
        
        .overlay(
            VStack{
                Divider()
                Spacer()
                Divider()
            }
                .opacity(0.8)
                    
        )

        
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
  /*        VStack(alignment: .leading) {
                /*
                 HStack(alignment: .top) {
                     ProfileThumbnail(image: comment.user.photo, size: 30)
                         .onTapGesture {
                             showProfile.toggle()
                         }
                     
                     VStack(alignment: .leading) {
                         
                         HStack{
                             Text(comment.user.name)
                                 .font(.system(size: 15, weight: .medium))
                                 .padding(.bottom, 1)
                             
                             Text(timeSince(from: comment.timestamp))
                                 .font(.system(size: 12))
                                 .opacity(0.7)
                                 .padding(.leading, 1)
                             Spacer()
                             Text("\(comment.likes)")
                                 .font(.system(size: 13))
                                 .padding(.trailing, -4)
                                 .offset(y: 10)
                             
                             Button(action: {
                                 if isLiked {
                                     comment.likes -= 1
                                 } else{
                                     comment.likes += 1
                                 }
                                 isLiked.toggle()
                                 
                             }){
                                 Image(systemName: isLiked ? "heart.fill" : "heart")
                                     .font(.system(size: 16))
                                     .foregroundColor(isLiked ? .pink : lightModeController.getForegroundColor())
                             }
                             .offset(y: 10)
                         }
                         
                         
                         
                         if comment.hasQuote {
                             HStack{
                                 HighlightedText(text: comment.quote.quote, fontSize: 15)
                                 Spacer()
                             }
                             .padding(.vertical)
                         }
                             Text(comment.comment)
                                 .font(.system(size: 15.5))
                                 .lineSpacing(4)
                                 .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                 .padding(.bottom, 6)

                         if let img = comment.image {
                             HStack{
                                 Image(img)
                                     .resizable()
                                     .scaledToFit()
                                     .frame(height: 200)
                                     .cornerRadius(5)
                                 
                                 Spacer()
                             }
                             .padding(.bottom, 6)
                             .padding(.top, -6)


                             
                         }

                         HStack{
                             
                             Button(action: {
                                 replying = true
                                 replyTo = comment
                             }){
                                 Text("Reply")
                                     .font(.system(size: 13, weight: .medium))
                                     .padding(.trailing, 8)
                                     .foregroundColor(lightModeController.getForegroundColor())
                                     .opacity(0.7)
                             }
                             
                             
                             Spacer()
                             

 /*
                             if comment.replies.count == 1 {
                                 Text("\(comment.replies.count) reply")
                                     .font(.system(size: 13))
                                     .padding(.trailing, 8)
                                     .opacity(0.7)
                             }
                             if comment.replies.count > 1 {
                                 Text("\(comment.replies.count) replies")
                                     .font(.system(size: 13))
                                     .padding(.trailing, 8)
                                     .opacity(0.7)
                             } */

                            
                             
                             

                         }
                         .offset(y: 5)
                         
                     }
                     .padding(.leading, 3)
                     .padding(.bottom, 6)
                     
                     Spacer()
                 }
                 */
            }
            .padding(.vertical, 5)
            .padding(.bottom, 2)
            .sheet(isPresented: $showProfile){
                ProfileView(user: comment.user, isPresenting: $showProfile, showToolbar: .constant(true))
            }
        
        if showAll {
            ForEach(comment.replies) { reply in
                ReplyComment(comment: reply, replying: $replying, replyTo: $replyTo)
                    .padding(.leading, 35)

                
            }
            HStack {
                Button("——— Hide Replies"){
                    showAll.toggle()
                }
                .font(.system(size: 13, weight: .medium))
                .opacity(0.7)
                    Spacer()
            }
            .padding(.leading, 35)
            .padding(.bottom, 7)
            
        } else {
            ForEach(comment.replies.prefix(1), id: \.id) { reply in
                ReplyComment(comment: reply, replying: $replying, replyTo: $replyTo)
                    .padding(.leading, 35)

            }
            if comment.replies.count > 1 {
                HStack {
                    Button("——— View \(comment.replies.count-1) more replies"){
                        showAll = true
                    }
                    .font(.system(size: 13, weight: .medium))
                    .opacity(0.7)
                    Spacer()
                }
                .padding(.leading, 35)
                .padding(.bottom, 7)
            }
        }
        
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
*/
struct ReplyComment: View {
    @State var comment: Comment
    @State var isLiked = false
    @Binding var replying: Bool
    @Binding var replyTo: Comment
    @State var showAll = false
    @EnvironmentObject var lightModeController: LightModeController
    @State var showProfile: Bool = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        VStack {
            VStack() {
                VStack(alignment: .leading) {

                HStack{
                    /*Text(review.rating.book.title)
                     .font(.custom("Georgia", size: 14.5))
                     .bold()
                     .lineLimit(1)
                     .frame(width: 190, alignment: .leading)*/
                    
                    ProfileThumbnail(image: comment.user.photo, size: 30)
                    Text("\(comment.user.name)")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.trailing, -4)
                    if let replyingTo = comment.replyTo {
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10.5, weight: .medium))
                            .opacity(0.5)
                        
                        Text("\(replyingTo.user.name)")
                            .font(.system(size: 12.5, weight: .medium))
                            .opacity(0.5)
                            .padding(.trailing, -4)
                    }
                    
                    Spacer()
                    Text(timeSince(from: comment.timestamp))
                    //.padding(.vertical, 2)
                        .font(.system(size: 11))
                        .opacity(0.7)
                    
                }
                .padding(.vertical, 8)
                
                Text(comment.comment)
                    .font(.system(size: 15.5))
                    .lineSpacing(4)
                
                HStack {
                    Button(action: {
                        replying = true
                        replyTo = comment
                    }){
                        Text("Reply")
                            .font(.system(size: 13, weight: .medium))
                            .padding(.trailing, 8)
                            .foregroundColor(lightModeController.getForegroundColor())
                            .opacity(0.7)
                    }
                    
                    /*
                     if comment.likes > 0 {
                     Text("\(comment.likes) likes")
                     .padding(.trailing)
                     }*/
                    if comment.replies.count > 0 {
                        Text("\(comment.replies.count) replies")
                    }
                    
                    Spacer()
                    if !isLiked {
                        Button(action: {
                            isLiked.toggle()
                            comment.likes += 1
                            
                        }){
                            HStack {
                                if comment.likes > 0 {
                                    
                                    Text("\(comment.likes)")
                                        .padding(.trailing, -5)
                                        .font(.system(size: 13))
                                }
                                
                                Image(systemName: "heart")
                                    .font(.system(size: 16))
                            }
                            .foregroundColor(.black)
                            
                        }
                    } else {
                        Button(action: {
                            isLiked.toggle()
                            comment.likes -= 1
                            
                        }){
                            HStack {
                                if comment.likes > 0 {
                                    
                                    Text("\(comment.likes)")
                                        .padding(.trailing, -7)
                                        .font(.system(size: 13))
                                        .foregroundColor(.black)
                                    
                                }
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.pink)
                            }
                            
                        }
                    }
                    
                }
                .font(.system(size: 12.5))
                .opacity(0.7)
                .padding(.top)
                
                
            }
            .padding(.leading, 25)

            ForEach(comment.replies, id: \.id) { reply in
                ReplyComment(comment: reply, replying: $replying, replyTo: $replyTo)
                    //.padding(.trailing, UIScreen.main.bounds.width * 0.10)

                
            }
        }

        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.90)
        .sheet(isPresented: $showProfile){
            ProfileView(user: comment.user, isPresenting: $showProfile, showToolbar: .constant(true))
        }


        }
        .padding(.vertical)
        .background(Color(hex: "#fffef8"))
        
        /*.overlay(
            VStack{
                Divider()
                Spacer()
                Divider()
            }
                .opacity(0.8)
                    
        )
         */
        
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



struct SphereText: View {
    var text: String
    var highlightColor: Color = Color.purple.opacity(0.15)
    var textColor: Color = Color.black
    var highlightedTextColor: Color = Color.black
    var fontSize: CGFloat = 15.0

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
    
    

    private func splitIntoLines(_ text: String, font: UIFont, width: CGFloat) -> [String] {
        var lines: [String] = []
        var currentLine = ""
        var currentLineWidth: CGFloat = 0
        
        let words = text.split(separator: " ")
        for word in words {
            let wordWidth = (word as NSString).size(withAttributes: [.font: font]).width
            let spaceWidth = (" " as NSString).size(withAttributes: [.font: font]).width
            
            if currentLineWidth + wordWidth + spaceWidth > width {
                lines.append(currentLine)
                currentLine = String(word)
                currentLineWidth = wordWidth
            } else {
                if !currentLine.isEmpty {
                    currentLine += " "
                    currentLineWidth += spaceWidth
                }
                currentLine += word
                currentLineWidth += wordWidth
            }
        }
        
        if !currentLine.isEmpty {
            lines.append(currentLine)
        }
        
        return lines
    }

    var body: some View {
        GeometryReader { geometry in
            let font = UIFont.systemFont(ofSize: fontSize)
            let lines = splitIntoLines(text, font: font, width: geometry.size.width)

            VStack(alignment: .leading, spacing: 2) {
                ForEach(lines, id: \.self) { line in
                    HStack(spacing: 0) {
                        let lineText = parseText(line)
                        ForEach(0..<lineText.count, id: \.self) { index in
                            if lineText[index].1 {
                                Text(lineText[index].0)
                                    .font(.system(size: fontSize))
                                    .lineSpacing(4)
                                    .background(highlightColor)
                                    .foregroundColor(highlightedTextColor)
                            } else {
                                Text(lineText[index].0)
                                    .font(.system(size: fontSize))
                                    .lineSpacing(4)

                                    .foregroundColor(textColor)
                            }
                        }
                    }
                }
            }
            .font(.system(size: fontSize))
        }
    }
}




struct sample: View {
    var body: some View {
        VStack {
            ScrollView{
                SphereText(text: "I love <hi> pie </hi> a lot")
                    .padding()
                SphereText(text: "This is an <hi> example </hi> of highlighted text.")
                    .padding()
                SphereText(text: "<hi> Highlight </hi> the text between tags.")
                    .padding()
                
                SphereText(text: "Once upon a time, in a small village at the edge of a vast and <hi> enchanted forest </hi>, there lived a curious little boy named Timmy. <hi>Timmy loved exploring</hi> and discovering new things. One sunny morning, he decided to venture into the magical forest that everyone in the village talked about.")
                    .padding()
            }

        }
        .font(.title)
    }
}





#Preview {
    
    sample()
}
