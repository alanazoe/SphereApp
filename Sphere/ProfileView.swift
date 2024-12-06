//
//  ProfileView.swift
//  media discussion
//
//  Created by Alana Greenaway on 1/28/24.
//

import SwiftUI
import UIImageColors

struct ProfileView: View {
    @State var user: User
    @Binding var isPresenting: Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isPresentingNotes = false
    @State var selectedBookNotes : Book = Book()
    @Binding var showToolbar: Bool
    @State var create = false
    @EnvironmentObject var userData : UserData
    @State var showList = false
    @State var selectedList = List(id: UUID(), title: "", books: [])
    @State var showBook = false
    @State var selectedBook = Book()
    @State var showEReader = false
    @EnvironmentObject var allBooks : Library
    @EnvironmentObject var lightModeController : LightModeController

    @State var isLiked = false
    @State var showPost = false
    @State var selectedPost = Note()
    @State var showPostActions = false
    
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var selectedReview = Review()
    @State var showReview = false
    @State var foregroundColor = Color(.black)
    @State var showAllBooks = false
    @State var showAllLists = false
    @State var showAllPosts = false
    @State var isEditing = false
    @State var showBookWithNotes = false
    @State var showNote = false
    @State var selectedNote = Note()
    @State var showAllNotes = false
    @State var fullScreen = false
    @State var showAllQuotes = false
    @State var createNewList = false
    @State var following = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        GeometryReader { geometry in
            
            let isLandscape = geometry.size.width > geometry.size.height
            
            ZStack {
                if !isLandscape {
                    ScrollViewReader { scrollProxy in
                        
                        ScrollView {
                            VStack {
                                VStack(alignment: .center) {
                                    
                                    ProfileThumbnail(image: user.photo, size: 170)
                                        .padding(.horizontal)
                                        .padding(.top, 100)
                                        .padding(.bottom)
                                    
                                    
                                    
                                    
                                    Spacer()
                                    
                                    
                                }
                                .padding(.horizontal)
                                .padding(.top)
                                .padding(.top, 40)

                                
                                
                                
                                HStack {
                                    VStack(alignment: .center){
                                        
                                        Text(user.name)
                                            .font(.system(size: 17, weight: .medium))
                                            .id("target1")

                                        HStack {
                                            if user.location != "" {
                                                HStack {
                                                    Text(user.location)
                                                    
                                                    
                                                }
                                                .font(.system(size: 12, weight: .regular))
                                                .opacity(0.6)
                                            }
                                            
                                            if user.instagram != "" {
                                                Link(destination: URL(string: "https://www.instagram.com/\(user.instagram)")!) {
                                                    HStack {
                                                        Image("instagram")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 11)
                                                        Text(user.instagram)
                                                            .padding(.leading, -4)
                                                        
                                                        
                                                    }
                                                    .font(.system(size: 12, weight: .regular))
                                                    .opacity(0.6)
                                                }
                                            }
                                            
                                        }
                                        .padding(.top, 5)
                                        //.padding(.top)
                                        
                                        let achiev = LoverAchievemnt()
                                        
                                        
                                        
                                        Text(user.bio)
                                            .font(.system(size: 14, weight: .regular))
                                            .padding(.top, user.instagram == "" && user.location == "" ? 0 : 1)
                                        //.padding(.top)
                                            .multilineTextAlignment(.center)
                                        
                                        Button(action: {
                                            userData.user.follow(user: user)
                                        }){
                                            RoundedRectangle(cornerRadius: 35)
                                                .frame(width: UIScreen.main.bounds.width * 0.25, height: 45)
                                                .foregroundColor(Color(hex: "#291F00").opacity(0.05))
                                            //.foregroundColor(lightModeController.getBackgroundColor())
                                            //.opacity(0.1)
                                                .shadow(radius: 0.5)
                                                .overlay(
                                                    Text(following ? "Following" : "Follow")
                                                        .font(.system(size: 13.5, weight: .medium))
                                                        .foregroundColor(lightModeController.getForegroundColor())
                                                )
                                            
                                        }
                                        .padding(.vertical)
                                        
                                        /* HStack {
                                         
                                         ProfileEditButton(user: user)
                                         .padding(.top)
                                         
                                         Spacer()
                                         ReadingChallenge()
                                         .padding(.top)
                                         
                                         }*/
                                        /*Image(achiev.badge)
                                         .resizable()
                                         .scaledToFill()
                                         .frame(width: 60) */
                                    }
                                    .padding(.horizontal)
                                    
                                    
                                }
                                .padding(.bottom)
                                .padding(.horizontal)
                                
                                let columns = [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                    
                                ]
                                
                                
                                VStack(alignment: .center, spacing: 20) {
                                    
                                    VStack(alignment: .leading) {
                                        
                                        let allBooks = user.getAllBooks()
                                        
                                        
                                        if !showAllBooks {
                                            ZStack() {
                                                ForEach(0..<min(7, allBooks.count), id: \.self) { index in
                                                    
                                                    Image(allBooks[index].cover)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 185)
                                                        .cornerRadius(10)
                                                    
                                                        .padding(5)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 14)
                                                                .foregroundColor(.white)
                                                        )
                                                        .offset(x: CGFloat(index * 95))
                                                    
                                                }
                                                
                                                
                                            }
                                            .onTapGesture{
                                                showAllBooks.toggle()
                                                if showAllBooks {
                                                    withAnimation {
                                                        scrollProxy.scrollTo("target1", anchor: .top)
                                                    }
                                                }
                                            }
                                        }
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text("All Books")
                                                    .font(.system(size: 16, weight: .medium))
                                                //.opacity(0.7)
                                                
                                                Text("\(allBooks.count) read")
                                                    .font(.system(size: 12))
                                                    .opacity(0.7)
                                            }
                                            Spacer()
                                            if showAllBooks {
                                                Text("see less")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(Color(.blue).opacity(0.7))
                                                /*RoundedRectangle(cornerRadius: 2)
                                                    .frame(width: 28, height: 2)
                                                    .foregroundStyle(.black)*/
                                            }
                                        }
                                        .background(lightModeController.getBackgroundColor())
                                        .padding(.horizontal)
                                        .onTapGesture{
                                            showAllBooks.toggle()
                                            if showAllBooks {
                                                
                                                withAnimation {
                                                    scrollProxy.scrollTo("target1", anchor: .top)
                                                }
                                            }
                                            
                                        }
                                        if showAllBooks {
                                            AllBooksProfileGrid(isPresenting: $showAllBooks, user: $user)
                                            
                                        }
                                    }
                                    .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                                    .padding(.vertical)
                                    
                                    if showAllQuotes {
                                        AllQuotesView(user: userData.user)
                                            .onTapGesture {
                                                showAllQuotes.toggle()
                                            }
                                    } else {
                                        QuotesPreview(user: userData.user)
                                            .onTapGesture {
                                                showAllQuotes.toggle()
                                            }
                                            .padding(.top)
                                            .padding(.top)

                                    }
                                    
                                    //ReviewsPreview()
                                    
                                   // AllLists()
                                    /*
                                    let lists = user.lists
                                    ForEach(Array(lists.enumerated()), id: \.element.id){ index, list in
                                        
                                        
                                        if selectedList == list && showList{
                                            
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text(selectedList.title)
                                                        .font(.system(size: 16, weight: .medium))
                                                    //.opacity(0.7)
                                                    
                                                    Text("\(selectedList.books.count) books")
                                                        .font(.system(size: 12))
                                                        .opacity(0.7)
                                                }
                                                Spacer()
                                       
                                                    RoundedRectangle(cornerRadius: 2)
                                                        .frame(width: 28, height: 2)
                                                        .foregroundStyle(.black)
                                                
                                            }
                                            .frame(width: 720)
                                            .onTapGesture{
                                                showList.toggle()
                                            }

                                            AllListBooksGrid(isPresenting: $showList, books: $selectedList.books)
                                                .frame(width: 720)
                                        } else {
                                            ProfileListPreview(list: list)
                                                .onTapGesture{
                                                    showList.toggle()
                                                    selectedList = list
                                                }
                                        }
                                        
                                    }
                                    
                                    */
                                    
                                }
                                .padding(.horizontal)
                            }
                            
                        }
                        
                        
                        .background(backgroundColor)
                        .sheet(isPresented: $isPresentingNotes) {
                            ActivityPreview(media: selectedBookNotes, isPresenting: $isPresentingNotes, showProfile: $showProfile, selectedProfile: $selectedProfile)
                                .presentationDetents([.fraction(0.95)])
                        }
                        .sheet(isPresented: $showNote){
                            NoteView(isPresenting: $showNote, note: $selectedNote, fullScreen: $fullScreen)
                            
                        }
                        
                        
                        
                      /*  .sheet(isPresented: $showList){
                            ListView(isPresenting: $showList, list: $selectedList, user: user)
                            
                        }*/
                    }
                    
                    if createNewList {
                        CreateListView(isPresented: $createNewList)
                            .background(lightModeController.getBackgroundColor())
                            .cornerRadius(30)
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                            .padding(.vertical, UIScreen.main.bounds.height * 0.05)
                            .background(Color(.black).opacity(0.1))
                        


                    }
                    
                    }
                
                    
                    if !showEReader && !showPost {
                        
                        VStack{
                            if !showList && !showAllLists && !showAllBooks && !showAllPosts{
                                MyProfileTopBar(user: user, isEditing: $isEditing)
                            }
                            Spacer()
                            
                            
                        }
                        
                        
                    }
                    
                    if showAllNotes {
                        AllUserNotesView(user: user, showToolbar: $showToolbar)
                    }
                    
                    if showAllPosts{
                        AllPosts(isPresenting: $showAllPosts, user: user)
                    }
                    if showBook {
                        ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar)
                        
                    }
                    if showBookWithNotes {
                        if user.getPostsByID(bookid: selectedBook.id) != nil {
                            ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar)
                        } else {
                            ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar)
                        }
                    }
                    
                    
                    
           
                   /* if showAllBooks {
                        AllBooksProfileGrid(isPresenting: $showAllBooks, user: $user)
                    }*/
                    
                    if showAllLists{
                        //AllLists()
                    }
                if showPost {
                    Rectangle()
                        .ignoresSafeArea()
                        .opacity(0.2)
                }
                    
                    
                    
                    if isEditing {
                        EditProfileView(isPresenting: $isEditing, user: user)
                    }
                
                    
                }
            }
            
        }
        
    
}

    extension Array {
        func chunked(into size: Int) -> [[Element]] {
            stride(from: 0, to: count, by: size).map {
                Array(self[$0 ..< Swift.min($0 + size, count)])
            }
        }
    }


struct MyProfileView: View {
    @Binding var showToolbar: Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isPresentingNotes = false
    @State var selectedBookNotes : Book = Book()
    @State var create = false
    @EnvironmentObject var userData : UserData
    @State var showList = false
    @State var selectedList = List(id: UUID(), title: "", books: [])
    @State var showBook = false
    @State var selectedBook = Book()
    @State var showEReader = false
    @EnvironmentObject var allBooks : Library
    
    @State var isLiked = false
    @State var showPost = false
    @State var selectedPost = Note()
    @State var showPostActions = false
    
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var selectedReview = Review()
    @State var showReview = false
    @State var foregroundColor = Color(.black)
    @State var showAllBooks = false
    @State var showAllLists = false
    @State var showAllPosts = false
    @State var isEditing = false
    @State var showBookWithNotes = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var showNote = false
    @State var selectedNote = Note()
    @State var fullScreen = false
    
    var body: some View {
        iPadMyProfileView(showToolbar: $showToolbar)
        

    }

}


struct AllReviews: View {
    @Binding var isPresenting: Bool
    var user: User
    @State var showBook: Bool = false
    @State var selectedBook = Book()
    @State var showReview = false
    @State var selectedReview = Review()
    @State var showProfile = false
    @State var selectedProfile = User()
    @EnvironmentObject var lightModeController : LightModeController
    @State var xoffset = 0.0
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var showRatings: Bool = false
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact

        let reviews = user.getAllReviews()
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
                    
                    
                    DiscussionSearchButton()

                    
                    
                    
                    
                    
                }
                .foregroundColor(lightModeController.getForegroundColor())
                .ignoresSafeArea()
                .padding()
                .background(lightModeController.getBackgroundColor())
                ScrollView{
                    VStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                HStack{
                                    Text(showRatings ? "\(user.name)'s Ratings" : "\(user.name)'s Reviews")
                                        .font(.system(size: 20, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                    
                                    
                                }
                                HStack(alignment: .top){
                                    
                                    Text(showRatings ? "\(reviews.count) ratings" : "\(reviews.count) reviews")
                                        .font(.system(size: 12))
                                        .opacity(0.7)
                                        .padding(.leading)
                                    Spacer()
                                    
                                    
                                }
                                
                            }
                            .padding(.bottom)
                            Spacer()
                            VStack(alignment: .trailing) {
                                /*Button(action: {
                                    showRatings.toggle()
                                }){
                                    Text(showRatings ? "Reviews (\(reviews.count))" : "Ratings (132)")
                                        .font(.system(size: 12))
                                        .padding(.horizontal)
                                        .padding(.vertical, 6)
                                        .font(.system(size: 12, weight: .medium))
                                }*/
                                SortByButton()
                                
                            }
                            .padding(.top)
                        }
                        .padding(.vertical)
                        .padding(.horizontal, iPadOrientation ? -1 * (UIScreen.main.bounds.width - 720) : UIScreen.main.bounds.width * -0.025)
                        if showRatings {
                            let ratings = user.getAllRatings()
                            ForEach(ratings) { rating in
                                MiniRatingPreview(rating: rating, showBook: $showBook)
                            }
                        } else {
                            // showing reviews (default)
                            ForEach(reviews) { review in
                                MiniReviewPreview3(review: review)
                                    .padding(.bottom)
                                
                            }
                        }
                    }
                    .padding(.bottom, 80)
                    .padding(.horizontal, iPadOrientation ? UIScreen.main.bounds.width - 720 : UIScreen.main.bounds.width * 0.025)

                    
                }
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
                if showReview {
                    //  ReviewView(review: $selectedReview, showingReview: , showEReader: <#T##Binding<Bool>#>, showToolbar: <#T##Binding<Bool>#>)
                }
                
            
        }
    }
}
struct iPadMyProfileView: View {
    
    @State var isPresentingNotes = false
    @State var selectedBookNotes : Book = Book()
    @Binding var showToolbar: Bool
    
    @State var create = false
    @EnvironmentObject var userData : UserData
    @State var showList = false
    @State var selectedList = List(id: UUID(), title: "", books: [])
    @State var showBook = false
    @State var selectedBook = Book()
    @State var showEReader = false
    @EnvironmentObject var allBooks : Library
    @EnvironmentObject var lightModeController : LightModeController

    @State var isLiked = false
    @State var showPost = false
    @State var selectedPost = Note()
    @State var showPostActions = false
    
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var selectedReview = Review()
    @State var showReview = false
    @State var foregroundColor = Color(.black)
    @State var showAllBooks = false
    @State var showAllLists = false
    @State var showAllReviews = false
    @State var showAllPosts = false
    @State var isEditing = false
    @State var showBookWithNotes = false
    @State var showNote = false
    @State var selectedNote = Note()
    @State var showAllNotes = false
    @State var fullScreen = false
    @State var showAllQuotes = false
    @State var createNewList = false
    @State var showAllRatings = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        GeometryReader { geometry in
            
            let isLandscape = geometry.size.width > geometry.size.height
            
            ZStack {
                if !isLandscape {
                    ScrollViewReader { scrollProxy in
                        
                        ScrollView {
                            VStack {
                                VStack(alignment: .center) {
                                    
                                    ProfileThumbnail(image: userData.user.photo, size: iPadOrientation ? 170 : 135)
                                        .padding(.horizontal)
                                        .padding(.top, iPadOrientation ? 100 : 8)
                                        .padding(.bottom)
                                    
                                    
                                    
                                    
                                    Spacer()
                                    
                                    
                                }
                                .padding(.horizontal)
                                .padding(.top)
                                .padding(.top, 40)

                                
                                
                                
                                HStack {
                                    VStack(alignment: .center){
                                        
                                        Text(userData.user.name)
                                            .font(.system(size: 17, weight: .medium))
                                            .id("target1")

                                        HStack {
                                            if userData.user.location != "" {
                                                HStack {
                                                    Text(userData.user.location)
                                                    
                                                    
                                                }
                                                .font(.system(size: 12, weight: .regular))
                                                .opacity(0.6)
                                            }
                                            
                                            if userData.user.instagram != "" {
                                                Link(destination: URL(string: "https://www.instagram.com/\(userData.user.instagram)")!) {
                                                    HStack {
                                                        Image("instagram")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 11)
                                                        Text(userData.user.instagram)
                                                            .padding(.leading, -4)
                                                        
                                                        
                                                    }
                                                    .font(.system(size: 12, weight: .regular))
                                                    .opacity(0.6)
                                                }
                                            }
                                            
                                        }
                                        .padding(.top, 5)
                                        //.padding(.top)
                                        
                                        let achiev = LoverAchievemnt()
                                        
                                        
                                        
                                        Text(userData.user.bio)
                                            .font(.system(size: 14, weight: .regular))
                                            .padding(.top, userData.user.instagram == "" && userData.user.location == "" ? 0 : 1)
                                        //.padding(.top)
                                            .multilineTextAlignment(.center)
                                        
                                        Button(action: {
                                            isEditing = true
                                        }){
                                            RoundedRectangle(cornerRadius: 35)
                                                .frame(width: UIScreen.main.bounds.width * 0.25, height: 45)
                                                .foregroundColor(Color(hex: "#291F00").opacity(0.05))
                                            //.foregroundColor(lightModeController.getBackgroundColor())
                                            //.opacity(0.1)
                                                .shadow(radius: 0.5)
                                                .overlay(
                                                    Text("Edit")
                                                        .font(.system(size: 13.5, weight: .medium))
                                                        .foregroundColor(lightModeController.getForegroundColor())
                                                )
                                            
                                        }
                                        .padding(.vertical)
                                        
                                        /* HStack {
                                         
                                         ProfileEditButton(user: user)
                                         .padding(.top)
                                         
                                         Spacer()
                                         ReadingChallenge()
                                         .padding(.top)
                                         
                                         }*/
                                        /*Image(achiev.badge)
                                         .resizable()
                                         .scaledToFill()
                                         .frame(width: 60) */
                                    }
                                    .padding(.horizontal)
                                    
                                    
                                }
                                .padding(.bottom)
                                .padding(.horizontal)
                                
                                let columns = [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                    
                                ]
                                
                                
                                VStack(alignment: .center, spacing: 20) {
                                    
                                    VStack(alignment: .leading) {
                                        
                                        let allBooks = userData.user.getAllBooks()
                                        
                                        
                                        if !showAllBooks {
                                        ZStack() {
                                                ForEach(0..<min(iPadOrientation ? 7 : 5, allBooks.count), id: \.self) { index in
                                                    
                                                    Image(allBooks[index].cover)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: iPadOrientation ? 185 : 140)
                                                        .cornerRadius(10)
                                                    
                                                        .padding(5)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 14)
                                                                .foregroundColor(.white)
                                                        )
                                                        .offset(x: iPadOrientation ? CGFloat(index * 95) : CGFloat(index * 73))
                                                    Spacer()
                                                }
                                                
                                                
                                            }
                                            .onTapGesture{
                                                showAllBooks.toggle()
                                                if showAllBooks {
                                                    withAnimation {
                                                        scrollProxy.scrollTo("target1", anchor: .top)
                                                    }
                                                }
                                            }
                                        }
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text("All Books")
                                                    .font(.system(size: 16, weight: .medium))
                                                //.opacity(0.7)
                                                
                                                Text("\(allBooks.count) read")
                                                    .font(.system(size: 12))
                                                    .opacity(0.7)
                                            }
                                            Spacer()
                                            if showAllBooks {
                                                Text("see less")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(Color(.blue).opacity(0.7))
                                                /*RoundedRectangle(cornerRadius: 2)
                                                    .frame(width: 28, height: 2)
                                                    .foregroundStyle(.black)*/
                                            }
                                        }
                                        .background(lightModeController.getBackgroundColor())
                                        .padding(.horizontal)
                                        .onTapGesture{
                                            showAllBooks.toggle()
                                            if showAllBooks {
                                                
                                                withAnimation {
                                                    scrollProxy.scrollTo("target1", anchor: .top)
                                                }
                                            }
                                            
                                        }
                                        if showAllBooks {
                                            AllBooksProfileGrid(isPresenting: $showAllBooks, user: $userData.user)
                                            
                                        }
                                    }
                                    .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                                    .padding(iPadOrientation ? .vertical : .top)
                        
                                    .sheet(isPresented: $showAllQuotes) {
                                        AllQuotesView(user: userData.user)
                                            .onTapGesture {
                                                showAllQuotes.toggle()
                                            }
                                    }
                                    QuotesPreview(user: userData.user)
                                            .onTapGesture {
                                                showAllQuotes.toggle()
                                            }
                                            .overlay(
                                                VStack {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "pin.fill")
                                                            .font(.system(size: 10))
                                                            .rotationEffect(Angle(degrees: 45))
                                                            .opacity(0.2)
                                                            .padding(8)
                                                    }
                                                    Spacer()
                                                }
                                            )
                                            .padding(.top)
                                    
                                    ReviewsPreview(showAllReviews: $showAllReviews)
                                    
                                    RatingsPreview(showAllRatings: $showAllRatings)
                                    
                                    AllLists(showList: $showList, selectedList: $selectedList)
                                    /*
                                    let lists = userData.user.lists
                                    ForEach(Array(lists.enumerated()), id: \.element.id){ index, list in
                                        
                                        
                                        if selectedList == list && showList{
                                            
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text(selectedList.title)
                                                        .font(.system(size: 16, weight: .medium))
                                                    //.opacity(0.7)
                                                    
                                                    Text("\(selectedList.books.count) books")
                                                        .font(.system(size: 12))
                                                        .opacity(0.7)
                                                }
                                                Spacer()
                                       
                                                    RoundedRectangle(cornerRadius: 2)
                                                        .frame(width: 28, height: 2)
                                                        .foregroundStyle(.black)
                                                
                                            }
                                            .frame(width: 720)
                                            .onTapGesture{
                                                showList.toggle()
                                            }

                                            AllListBooksGrid(isPresenting: $showList, books: $selectedList.books)
                                                .frame(width: 720)
                                        } else {
                                            ProfileListPreview(list: list)
                                                .onTapGesture{
                                                    showList.toggle()
                                                    selectedList = list
                                                }
                                        }
                                        
                                    }
                                    
                                    */
                                    
                                }
                                .padding(.horizontal)
                            }
                            .overlay(
                                VStack {
                                    HStack{
                                        Spacer()

                                        Button(action: {createNewList.toggle()}){
                                            Image(systemName: "plus.app.fill")
                                        }
                                    }
                                    .padding(.top, 60)

                                    Spacer()
                                }
                            )
                            .padding(.bottom, 60)
                            .frame(width: UIScreen.main.bounds.width)
                        }
                        
                        
                        .background(lightModeController.getBackgroundColor())
                        .sheet(isPresented: $isPresentingNotes) {
                            ActivityPreview(media: selectedBookNotes, isPresenting: $isPresentingNotes, showProfile: $showProfile, selectedProfile: $selectedProfile)
                                .presentationDetents([.fraction(0.95)])
                        }
                        .sheet(isPresented: $showNote){
                            NoteView(isPresenting: $showNote, note: $selectedNote, fullScreen: $fullScreen)
                            
                        }
                        
                        
                        
                      /*  .sheet(isPresented: $showList){
                            ListView(isPresenting: $showList, list: $selectedList, user: userData.user)
                            
                        }*/
                    }
                    
                    if createNewList {
                        CreateListView(isPresented: $createNewList)
                            .background(lightModeController.getBackgroundColor())
                            .cornerRadius(30)
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                            .padding(.vertical, UIScreen.main.bounds.height * 0.05)
                            .background(Color(.black).opacity(0.1))
                        


                    }
                    
                    }
                
                    
                    if !showEReader && !showPost {
                        
                        VStack{
                            if !showList && !showAllLists && !showAllBooks && !showAllPosts{
                                MyProfileTopBar(user: userData.user, isEditing: $isEditing)
                            }
                            Spacer()
                            
                            
                        }
                        
                        
                    }
                    
                    if showAllNotes {
                        AllUserNotesView(user: userData.user, showToolbar: $showToolbar)
                    }
                    
                    if showAllPosts{
                        AllPosts(isPresenting: $showAllPosts, user: userData.user)
                    }
                    if showBook {
                        ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar)
                        
                    }
                    if showBookWithNotes {
                        if userData.user.getPostsByID(bookid: selectedBook.id) != nil {
                            ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar)
                        } else {
                            ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar)
                        }
                    }
                    
                if showAllReviews {
                    AllReviews(isPresenting: $showAllReviews, user: userData.user)
                }
                
                if showAllRatings {
                    AllReviews(isPresenting: $showAllReviews, user: userData.user, showRatings: true)
                }
                    
                    if showProfile {
                        ProfileView(user: selectedProfile, isPresenting: $showProfile, showToolbar: $showToolbar)
                    }
                   /* if showAllBooks {
                        AllBooksProfileGrid(isPresenting: $showAllBooks, user: $userData.user)
                    }*/
                    
                    if showAllLists{
                        AllLists(showList: $showList, selectedList: $selectedList)
                    }
                    if showPost {
                        Rectangle()
                            .ignoresSafeArea()
                            .opacity(0.2)
                        
                        PostView(post: $selectedPost, isPresenting: $showPost, showToolbar: $showToolbar)
                    }
                    
                    
                    
                    if isEditing {
                        EditProfileView(isPresenting: $isEditing, user: userData.user)
                    }
                    if showList {
                        
                        AllListBooksGrid(isPresenting: $showList, list: $selectedList)
                            .presentationDetents([.fraction(0.9)])
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    }
                
                    
                }
            }
            
        }
        
    
}


struct AllBooksProfileGrid: View {
    @Binding var isPresenting: Bool
    @Binding var user: User
    @State var showBook: Bool = false
    @State var selectedBook = Book()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        VStack{
            
        }
        //AllListBooksGrid(isPresenting: $isPresenting, books: .constant(user.getAllBooks()))
    }
        
}

struct AllListBooksGrid: View {
    @Binding var isPresenting: Bool
    @Binding var list: List
    @State var showBook: Bool = false
    @State var selectedBook = Book()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var sphereUsers: SphereUsers
    @EnvironmentObject var lightModeController : LightModeController
    @State var isBookmarked = false
    @State var xoffset = 0.0

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        VStack {

        ScrollView {

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
                
         
                    Button(action: {
                        //showShare.toggle()
                        
                    }){
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 17, weight: .medium))
                    }
                
               
                
                
                
            }
            .foregroundColor(lightModeController.getForegroundColor())
            .ignoresSafeArea()
            .padding()
            .background(lightModeController.getBackgroundColor())
            if let user = sphereUsers.getUserById(userId: list.user){
                HStack {
                   
                        Spacer()
                        VStack() {

                        if user.isTBRList(list: list){
                                StatusView(status: .tbr, fontSize: 18)
                                    .padding(.leading, -7)
                                
                                
                                
                            
                        } else if user.isReadList(list: list){
                            
                                StatusView(status: .read, fontSize: 18)
                                    .padding(.leading, -7)
                                
                              
                            
                        } else if user.isReadingList(list: list){
                                StatusView(status: .current, fontSize: 18)
                                    .padding(.leading, -7)
                              
                            
                        } else {
                                Text(list.title)
                                    .font(.system(size: 20, weight: .medium))
                                    .padding(.vertical, 7)
        
                                
                                
                        }
                       
                        
                        
                        //.opacity(0.7)
                            
                        
                    }
                    
                    Spacer()
                    
                }
                .padding([.vertical, .vertical])
                .padding(.top, 20)
            
                HStack {
                    ProfileThumbnail(image: user.photo, size: 25)
                    Text("\(user.name)")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.trailing, -4)
                    Spacer()
                    
                }
                .padding(.leading)
                .padding(.bottom)
                Text(list.description)
                    .font(.system(size: 15))
                    .lineSpacing(5)
                    .padding([.horizontal, .bottom])
                
                HStack{
                    if list.isPrivate() {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 12.5))

                    } else {
                
                        Text("4 saves")
                            .font(.system(size: 12.5))
                            .opacity(0.7)

                    }
                    
                    Text("\(list.books.count) books")
                        .font(.system(size: 12.5))
                        .opacity(0.7)
                    
                    Spacer()
                    Button(action: {
                        if isBookmarked {
                            
                        } else {
                            
                        }
                        isBookmarked.toggle()
                        
                    }){
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            .font(.system(size: 15.5))
                            .foregroundColor(isBookmarked ? .orange : lightModeController.getForegroundColor())
                            .opacity(0.7)
                    }
                }
                .padding([.horizontal, .bottom])

            }
                
                let books = list.books
                LazyVGrid(columns: iPadOrientation ?  [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())] :  [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<books.count, id: \.self) { index in
                        Image(books[index].cover)
                            .resizable()
                            .scaledToFit()
                            .frame(idealWidth: iPadOrientation ? 155 : UIScreen.main.bounds.width / 4, maxWidth: iPadOrientation ? 155 : UIScreen.main.bounds.width / 4, maxHeight: iPadOrientation ? 290 : 200)
                            .cornerRadius(10)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            )
                            .onTapGesture {
                                selectedBook = books[index]
                                showBook.toggle()
                            }
                        
                        
                    }
                }
                
                
            
        }
        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
        }
        .scrollIndicators(.hidden)
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

/*
 {
     @Binding var isPresenting: Bool
     @Binding var books: [Book]
     @State var showBook: Bool = false
     @State var selectedBook = Book()
     @Environment(\.horizontalSizeClass) var horizontalSizeClass

     var body: some View {
         let iPadOrientation = horizontalSizeClass != .compact
         
         let booksPerPage = iPadOrientation ? 12 : 9
         
         TabView {
             ForEach(0..<(books.count / booksPerPage + (books.count % booksPerPage == 0 ? 0 : 1)), id: \.self) { tabIndex in
                 let startIndex = tabIndex * booksPerPage
                 let endIndex = min(startIndex + booksPerPage, books.count)
                 let bookSubset = Array(books[startIndex..<endIndex])
                 
                 LazyVGrid(columns: iPadOrientation ?  [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())] :  [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                     ForEach(0..<bookSubset.count, id: \.self) { index in
                         Image(bookSubset[index].cover)
                             .resizable()
                             .scaledToFit()
                             .frame(idealWidth: iPadOrientation ? 155 : UIScreen.main.bounds.width / 4, maxWidth: iPadOrientation ? 155 : UIScreen.main.bounds.width / 4, maxHeight: iPadOrientation ? 290 : 200)
                             .cornerRadius(10)
                             .padding(5)
                             .background(
                                 RoundedRectangle(cornerRadius: 14)
                                     .foregroundColor(.white)
                             )
                             .onTapGesture {
                                 selectedBook = bookSubset[index]
                                 showBook.toggle()
                             }
                         
                         
                     }
                 }
                 
                 .tabItem {
                     Text("Tab \(tabIndex + 1)")
                 }
             }
         }
         .tabViewStyle(PageTabViewStyle())
         .sheet(isPresented: $showBook) {
             ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: .constant(true))
         }
         .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95, height: iPadOrientation ? min((CGFloat(books.count / 4) * 290), 870) : books.count <= 3 ? 200 : books.count <= 6 ? 400 : 600)
     }
 }
 */

struct CreateListView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var userData: UserData
    @State var books: [UUID: Book] = [:]
    @State var title = ""
    
    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    makeList(title, books)
                    isPresented.toggle()
                }) {
                    Text("Done")
                }
            }
            .padding()
            
            // Title text field for user input
            TextField("Enter list title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    let allBooks = userData.user.getAllBooks()
                    ForEach(0..<allBooks.count, id: \.self) { index in
                        Image(allBooks[index].cover)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 155)
                            .cornerRadius(10)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .foregroundColor(.white)
                            )
                            .overlay {
                                if books[allBooks[index].id] != nil {
                                    // Overlay with a checkmark if the book has been added
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 14)
                                            .foregroundColor(Color.black.opacity(0.3))
                                        Image(systemName: "checkmark")
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .onTapGesture {
                                if books[allBooks[index].id] == nil {
                                    books[allBooks[index].id] = allBooks[index]
                                } else {
                                    // Remove book from the map
                                    books.removeValue(forKey: allBooks[index].id)
                                }
                            }
                    }
                }
                .padding()
            }
        }
    }
    
    func makeList(_ title: String, _ books: [UUID: Book]) {
        let booksList = Array(books.values)
        let newList = List(user: userData.user.id, title: title, books: booksList)
        userData.user.addList(list: newList)
    }
}

struct AllQuotesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var user: User
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        VStack(alignment: .leading) {
            HStack {
                ProfileThumbnail(image: user.photo, size: 30)

                Text("\(user.name)'s Saved Quotes")
                    .font(.system(size: 14, weight: .medium))

                
            }
            PinnedQuotePreview(quote: Quote(quote: "and the moment you doubt whether you can fly, you cease forever to be able to do it. The reason birds can fly and we can't is simply that they have perfect faith, for to have faith is to have wings.", book: Book(title: "Peter Pan", author: Author(name: "Daniel O'Connor"))))

            
            PinnedQuotePreview(quote: Quote(quote: "I believe that imagination is stronger than knowledge. That myth is more potent than history. That dreams are more powerful than facts. That hope always triumphs over experience. That laughter is the only cure for grief. And I believe that love is stronger than death.", book: Book(title: "All I Really Need to Know", author: Author(name: "Robert Fulghum"))))



        }
        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
    }
}
struct ReviewsPreview: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var showAllReviews: Bool
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        VStack {
            let reviews = userData.user.getAllReviews()
            HStack {
                VStack(alignment: .leading) {
                    Text("Reviews")
                        .font(.system(size: 16, weight: .medium))
                    
                    Text("\(reviews.count) reviews")
                        .font(.system(size: 12))
                        .opacity(0.7)
                }
                .padding(.vertical, 4)
                Spacer()
            }
            VStack() {
                
                ForEach(0..<min(1, reviews.count), id: \.self) { index in
                    MiniReviewPreview3(review: reviews[index])
                  
                }
                
                Button(action: {
                    showAllReviews.toggle()
                }){
                    HStack {
                        
                        Spacer()
                        Text("see all \(reviews.count) reviews")
                            .font(.system(size: 13))
                            .opacity(0.7)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 13))
                            .opacity(0.7)
                        
                        
                        
                    }
                    .padding(.vertical, 6)
                }
                Divider()
            }
            
            
        }
        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
    }
}

struct RatingsPreview: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var showAllRatings: Bool
    @State var showBook = false
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        VStack {
            let ratings = userData.user.getAllRatings()
            HStack {
                VStack(alignment: .leading) {
                    Text("Ratings")
                        .font(.system(size: 16, weight: .medium))
                    
                    Text("\(ratings.count) ratings")
                        .font(.system(size: 12))
                        .opacity(0.7)
                }
                .padding(.vertical, 4)

                Spacer()
            }
            VStack() {
                
                ForEach(0..<min(1, ratings.count), id: \.self) { index in
                    MiniRatingPreview(rating: ratings[index], showBook: $showBook)
                  
                }
                
                Button(action: {
                    showAllRatings.toggle()
                }){
                    HStack {
                        
                        Spacer()
                        Text("see all \(ratings.count) ratings")
                            .font(.system(size: 13))
                            .opacity(0.7)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 13))
                            .opacity(0.7)
                        
                        
                        
                    }
                    .padding(.vertical, 6)
                }
                Divider()
            }
            .padding(.bottom)
            
            
        }
        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
     
    }
}
struct MiniReviewPreview: View {
    @State var review: Review
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var lightModeController: LightModeController
    @State var isLiked : Bool = false
    @EnvironmentObject var userData: UserData
    @State var showBook: Bool = false
    @State var showReview: Bool = false

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        HStack(alignment: .top) {
    
            VStack(alignment: .leading){
                
                HStack(alignment: .top) {
                    Image(review.rating.book.cover)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .cornerRadius(8)
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
                                .font(.custom("Baskerville", size: 15.5))
                                //.bold()
                                .padding(.bottom, 4)
                            Spacer()
                            Text(timeSince(from: review.timestamp))
                                .padding(.vertical, 2)
                                .font(.system(size: 11))
                                .opacity(0.7)
                            
                        }
                        HStack() {
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
                    
                        Spacer()
                        AddToListButton(book: $review.rating.book, fontSize: 12.5)
                            .padding(.bottom)
                        
                        
                    }
                    .onTapGesture {
                        showBook.toggle()
                    }
                    
                }
                HStack{
                    /*Text(review.rating.book.title)
                        .font(.custom("Georgia", size: 14.5))
                        .bold()
                        .lineLimit(1)
                        .frame(width: 190, alignment: .leading)*/
                    
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

                }
                .padding(.vertical, 8)
                
                Text(review.description)
                    .font(.system(size: 14.5))
                    .lineSpacing(4)
                    .lineLimit(4)
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
                .font(.system(size: 12.5))
                .opacity(0.7)
                .padding(.top)
                
            }
            .sheet(isPresented: $showBook){
                ContentView(book: $review.rating.book, isPresenting: $showBook, showToolbar: .constant(true))
            }
            .sheet(isPresented: $showReview){
                ReviewView(isPresenting: $showReview, review: $review)
            }
            
        }
        .padding(25)
        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
        .background(RoundedRectangle(cornerRadius: 10)
            .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
            .fill(Color(hex: "#fffffc").opacity(0.7))
        )
        .onTapGesture {
            showReview.toggle()
        }
        
        
    }
    
}

struct MiniReviewPreview2: View {
    @State var review: Review
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var lightModeController: LightModeController
    @State var isLiked : Bool = false
    @EnvironmentObject var userData: UserData
    @State var showBook: Bool = false
    @State var showReview: Bool = false

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        HStack(alignment: .top) {
    
            VStack(alignment: .leading){
                
                
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
                
                BodyText(text: review.description, size: 16)
                    .lineSpacing(4)
                    .lineLimit(5)
                
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
            .sheet(isPresented: $showBook){
                ContentView(book: $review.rating.book, isPresenting: $showBook, showToolbar: .constant(true))
            }
            .sheet(isPresented: $showReview){
                ReviewView(isPresenting: $showReview, review: $review)
            }
            
        }
        
        .onTapGesture {
            showReview.toggle()
        }
        .padding()
        .background(Color(hex: "#fffffc").opacity(0.7)
        )
    }
    
}

struct MiniReviewPreview3: View {
    @State var review: Review
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var lightModeController: LightModeController
    @State var isLiked : Bool = false
    @EnvironmentObject var userData: UserData
    @State var showBook: Bool = false
    @State var showReview: Bool = false

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        HStack(alignment: .top) {
    
            VStack(alignment: .leading){
                
                MiniBookPreview(book: review.rating.book, showBook: $showBook, bookHeight: 50.0, titleFontSize: 16)
                    .padding(.bottom, -4)
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
                .padding(.bottom, 4)*/
                VStack(alignment: .leading){
                    HStack{
                        /*Text(review.rating.book.title)
                         .font(.custom("Georgia", size: 14.5))
                         .bold()
                         .lineLimit(1)
                         .frame(width: 190, alignment: .leading)*/
                        
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
                        
                    }
                    .padding(.vertical, 8)
                    
                    BodyText(text: review.description, size: 15)
                        //.font(.system(size: 14.5))
                        .lineSpacing(4)
                        .lineLimit(6)
                    
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
                    .font(.system(size: 12.5))
                    .opacity(0.7)
                    .padding(.top)
                }
                //.frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.90)
                .padding(.horizontal, 15)
                .background(Color(hex: "#fffef8"))
                .overlay(VStack{
                        Divider()
                        Spacer()
                        Divider()
                    }
                    .opacity(0.8))
                
            }
            .sheet(isPresented: $showBook){
                ContentView(book: $review.rating.book, isPresenting: $showBook, showToolbar: .constant(true))
            }
            .sheet(isPresented: $showReview){
                ReviewView(isPresenting: $showReview, review: $review)
            }
            
        }
        
        .onTapGesture {
            showReview.toggle()
        }
        
        
    }
    
}
struct MiniPostPreview: View {
    @State var post: Note
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var lightModeController: LightModeController
    @State var isLiked : Bool = false
    @EnvironmentObject var userData: UserData
    @State var showBook: Bool = false
    @State var showPost: Bool = false

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        HStack(alignment: .top) {
    
            VStack(alignment: .leading){
                
                HStack(alignment: .center) {
                    Image(post.book.cover)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
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
                                .font(.custom("Baskerville", size: 16.5))
                                //.bold()
                            Spacer()
                            Text(timeSince(from: post.timestamp))
                                //.padding(.vertical, 2)
                                .font(.system(size: 11))
                                .opacity(0.7)
                            
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
                            Spacer()
                            AddToListButton(book: $post.book, fontSize: 12.5)
                            

                        }
                        .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                    
                       
                        
                        
                    }
                    .onTapGesture {
                        showBook.toggle()
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
                        
                        ProfileThumbnail(image: post.user.photo, size: 30)
                        Text("\(post.user.name)")
                            .font(.system(size: 14, weight: .medium))
                            .padding(.trailing, -4)
                       
                        Spacer()
                        
                    }
                    .padding(.vertical, 8)
                    
                    Text(post.description)
                        .font(.system(size: 14.5))
                        .lineSpacing(4)
                        .lineLimit(6)
                    HStack {
                        if post.likes > 0 {
                            Text("\(post.likes) likes")
                                .padding(.trailing)
                        }
                        if post.comments.count > 0 {
                            Text("\(post.comments.count) comments")
                        }
                        
                        Spacer()
                        if !isLiked {
                            Button(action: {
                                isLiked.toggle()
                                post.likes += 1
                                
                            }){
                                Image(systemName: "heart")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                            }
                        } else {
                            Button(action: {
                                isLiked.toggle()
                                post.likes -= 1
                                
                            }){
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.pink)
                            }
                        }
                        
                    }
                    .font(.system(size: 12.5))
                    .opacity(0.7)
                    .padding(.top)
                }
                .padding(25)
                .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                    .fill(Color(hex: "#fffef8"))
                )
                
            }
            .sheet(isPresented: $showBook){
                ContentView(book: $post.book, isPresenting: $showBook, showToolbar: .constant(true))
            }
            /*.sheet(isPresented: $showReview){
                ReviewView(isPresenting: $showReview, review: $review)
            }*/
            
        }
        
        .onTapGesture {
           // showReview.toggle()
        }
        
        
    }
    
}

struct MiniPostPreview2: View {
    @State var post: Note
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var lightModeController: LightModeController
    @State var isLiked : Bool = false
    @EnvironmentObject var userData: UserData
    @State var showBook: Bool = false
    @Binding var showPost: Bool
    @Binding var selectedPost: Note

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        HStack(alignment: .top) {
    
            VStack(alignment: .leading){
                
            
                VStack(alignment: .leading){
                    HStack{
                        
                        
                        ProfileThumbnail(image: post.user.photo, size: 30)
                        Text("\(post.user.name)")
                            .font(.system(size: 14, weight: .medium))
                            .padding(.trailing, -4)
                       
                        Spacer()
                        
                    }
                    .padding(.vertical, 8)
                    Text(post.title)
                        .font(.system(size: 15.5, weight: .medium))
                        .lineSpacing(4)
                        .lineLimit(2)
                        .padding(.bottom, 4)

                    Text(post.description)
                        .font(.system(size: 14.5))
                        .lineSpacing(4)
                        .lineLimit(6)
                    HStack {
                        if post.likes > 0 {
                            Text("\(post.likes) likes")
                                .padding(.trailing)
                        }
                        if post.comments.count > 0 {
                            Text("\(post.comments.count) comments")
                        }
                        
                        Spacer()
                        if !isLiked {
                            Button(action: {
                                isLiked.toggle()
                                post.likes += 1
                                
                            }){
                                Image(systemName: "heart")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                            }
                        } else {
                            Button(action: {
                                isLiked.toggle()
                                post.likes -= 1
                                
                            }){
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.pink)
                            }
                        }
                        
                    }
                    .font(.system(size: 12.5))
                    .opacity(0.7)
                    .padding(.top)
                }
                .padding(25)
                .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                    .fill(Color(hex: "#fffef8"))
                )
                
            }
            .sheet(isPresented: $showBook){
                ContentView(book: $post.book, isPresenting: $showBook, showToolbar: .constant(true))
            }
            /*.sheet(isPresented: $showPost){
                PostView(post: $post, isPresenting: $showPost, showToolbar: .constant(false))
            }*/
            
        }
        
        .onTapGesture {
            selectedPost = post
            showPost.toggle()
            
        }
        
        
    }
    
}



struct MiniPostPreview3: View {
    @State var post: Note
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var lightModeController: LightModeController
    @State var isLiked : Bool = false
    @EnvironmentObject var userData: UserData
    @State var showBook: Bool = false
    @Binding var showPost: Bool
    @Binding var selectedPost: Note
    @State var showPoster = true
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        HStack(alignment: .top) {
    
            VStack(alignment: .leading){
                
            
                VStack(alignment: .leading){
                    if showPoster {
                        HStack {
                            ProfileThumbnail(image: post.user.photo, size: 30)
                            Text("\(post.user.name)")
                                .font(.system(size: 14, weight: .medium))
                                .padding(.trailing, -4)
                            
                            Spacer()
                            
                        }
                        .padding(.vertical, 8)
                    }
                    Text(post.title)
                        .font(.system(size: 15.5, weight: .medium))
                        .lineSpacing(4)
                        .lineLimit(2)
                        .padding(.bottom, 4)

                    Text(post.description)
                        .font(.system(size: 14.5))
                        .lineSpacing(4)
                        .lineLimit(4)
                    HStack {
                        /*
                        if post.comments.count > 0 {
                            Text("\(post.comments.count) comments")
                        }
                        */
                        Spacer()
                        UpvoteDownvote(post: $post)
                        /*
                        if !isLiked {
                            Button(action: {
                                isLiked.toggle()
                                post.likes += 1
                                
                            }){
                                Image(systemName: "heart")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                            }
                        } else {
                            Button(action: {
                                isLiked.toggle()
                                post.likes -= 1
                                
                            }){
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.pink)
                            }
                        }*/
                        
                    }
                    .font(.system(size: 13))
                    .opacity(0.7)
                    .padding(.top, 4)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 8)

                //.frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
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
            .sheet(isPresented: $showBook){
                ContentView(book: $post.book, isPresenting: $showBook, showToolbar: .constant(true))
            }
            /*.sheet(isPresented: $showPost){
                PostView(post: $post, isPresenting: $showPost, showToolbar: .constant(false))
            }*/
            
        }
        
        .onTapGesture {
            selectedPost = post
            showPost.toggle()
            
        }
        
        
    }
    
}

struct SortIcon: View {
    var size: CGFloat = 22
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        
        VStack(alignment: .leading, spacing: 2.4) {
            RoundedRectangle(cornerRadius: 6)
                .frame(width: size, height: 2.1)
            RoundedRectangle(cornerRadius: 6)
                .frame(width: size * 0.7, height: 2.1)

            RoundedRectangle(cornerRadius: 6)
                .frame(width: size * 0.5, height: 2.1)


        }
        .overlay(
            VStack(alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "arrow.down")
                        .font(.system(size: size * 0.6, weight: .bold))
                }
                .offset(x: 8)
            }
        
        )
        .foregroundColor(lightModeController.getForegroundColor())
    }
}


struct QuotesPreview: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var user: User
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        VStack(alignment: .leading) {
            
            /*HStack {
                Image("quoteicon2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iPadOrientation ? 30 : 20)
                Spacer()
                Text("4 quotes")
                    .font(.system(size: 12))
                    .opacity(0.7)
            }
            .padding(.top)
            */
            /*VStack {
                Text("All I Really Need to Know I Learned in Kindergarten")
                    .font(.custom("Georgia", size: 14))
                    .underline()
                Text("Robert Fulghum")
                    .font(.custom("Georgia", size: 12))
            }
            .padding(.vertical)
             */
            
            PinnedQuotePreview(quote: Quote(quote: "and the moment you doubt whether you can fly, you cease forever to be able to do it. The reason birds can fly and we can't is simply that they have perfect faith, for to have faith is to have wings.", book: Book(title: "Peter Pan", author: Author(name: "Daniel O'Connor"))))
            HStack {
                Spacer()
                Text("see all \(user.quotes.count) saved quotes")
                    .font(.system(size: 13))
                    .opacity(0.7)
                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .opacity(0.7)
            }
            .padding(.vertical, 8)
            .padding(.vertical, 8)

            Divider()
                .opacity(0.7)



        }
        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
    }
}

struct AllLists: View {
    @EnvironmentObject var userData: UserData
    @Binding var showList: Bool
    @Binding var selectedList: List
    @EnvironmentObject var lightModeController: LightModeController
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        let allLists = userData.user.getAllLists()
        
        ZStack {
            VStack {
                HStack{
                    VStack(alignment: .leading) {
                        Text("Lists")
                            .font(.system(size: 18, weight: .medium))
                        Text("\(userData.user.lists.count) lists")
                            .font(.system(size: 12))
                            .opacity(0.7)
                        
                        
                    }
                    
                    Spacer()
                    
                }
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20){
                    ForEach(0..<allLists.count, id: \.self) { index in
                        if allLists[index].books.count > 0 {
                            ProfileListPreview(list: allLists[index])
                                .onTapGesture {
                                    selectedList = allLists[index]
                                    showList.toggle()
                                }
                        }
                    }
                }
            }
            
            
        }
        /*.sheet(isPresented: $showList){
            AllListBooksGrid(isPresenting: $showList, list: $selectedList)
                .presentationDetents([.fraction(0.9)])

        }*/
       /*
        VStack(spacing: 15){
            let allLists = userData.user.getAllLists()
            
            ForEach(0..<allLists.count, id: \.self) { index in
                
                if allLists[index].books.count > 0 {
                    if showList && selectedList == allLists[index] {
                        VStack{
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(allLists[index].title)
                                        .font(.system(size: 16, weight: .medium))
                                    //.opacity(0.7)
                                    
                                    Text("\(allLists[index].books.count) books")
                                        .font(.system(size: 12))
                                        .opacity(0.7)
                                }
                                Spacer()
                                Text("see less")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(.blue).opacity(0.7))
                                /*RoundedRectangle(cornerRadius: 2)
                                 .frame(width: 28, height: 2)
                                 .foregroundStyle(.black)*/
                                
                            }
                            .background(lightModeController.getBackgroundColor())
                            .padding(.horizontal)
                            .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                            .onTapGesture{
                                showList.toggle()
                            }
                            AllListBooksGrid(isPresenting: $showList, books: .constant(allLists[index].books))
                        }
                    } else{
                        ProfileListPreview(list: allLists[index])
                            .onTapGesture {
                                selectedList = allLists[index]
                                showList.toggle()
                            }
                    }
                }
            }
            
        }*/
    }
}

struct RecommendedList: View {
    @EnvironmentObject var userData: UserData
    @State var showList: Bool = false
    @State var selectedList = List()
    @EnvironmentObject var lightModeController: LightModeController
    @EnvironmentObject var exploreList: List
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        
        VStack(spacing: 15){
            
                
                if exploreList.books.count > 0 {
                    if showList && selectedList == exploreList {
                        VStack{
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(exploreList.title)
                                        .font(.system(size: 16, weight: .medium))
                                    
                                   
                                }
                                Spacer()
                                Text("see less")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(.blue).opacity(0.7))
                                /*RoundedRectangle(cornerRadius: 2)
                                 .frame(width: 28, height: 2)
                                 .foregroundStyle(.black)*/
                                
                            }
                            .background(lightModeController.getBackgroundColor())
                            .padding(.horizontal)
                            .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
                            .onTapGesture{
                                showList.toggle()
                            }
                            //AllListBooksGrid(isPresenting: $showList, books: .constant(exploreList.books))
                        }
                    } else{
                        ProfileListPreview(list: exploreList, pinnedOnExplore: true)
                            .onTapGesture {
                                selectedList = exploreList
                                showList.toggle()
                            }
                    }
                }
            
            
        }
    }
}

struct ProfileListPreview: View {
    @State var list: List
    @State var pinnedOnExplore = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var sphereUsers: SphereUsers

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
            
            VStack(alignment: .leading) {
                
                ZStack{
                    
                    if list.books.count == 1 {
                        HStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: (UIScreen.main.bounds.width * 0.42) / 3, height: iPadOrientation ? 185 : pinnedOnExplore ? 100 : 120)
                                .padding(5)
                                .foregroundColor(Color(hex: "#291F00").opacity(0.1))
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.white)
                                )
                            Spacer()
                            
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.42)
                        HStack {
                            Spacer()

                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: (UIScreen.main.bounds.width * 0.42) / 3, height: iPadOrientation ? 185 : pinnedOnExplore ? 100 : 120)
                                .padding(5)
                                .foregroundColor(Color(hex: "#291F00").opacity(0.1))
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.white)
                                )
                            Spacer()
                            
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.42)

                    } else if  list.books.count == 2 {
                        HStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: (UIScreen.main.bounds.width * 0.42) / 3, height: iPadOrientation ? 185 : pinnedOnExplore ? 100 : 120)
                                .padding(5)
                                .foregroundColor(Color(hex: "#291F00").opacity(0.05))
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.white)
                                )
                            Spacer()
                            
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.42)
                    }
                    let count = list.books.count
                    ForEach(0..<min(iPadOrientation ? 5 : 3, list.books.count), id: \.self) { index in
                        HStack {
                            if count == 1 || count == 2 || index == 1 || index == 2 {
                                Spacer()
                            }
                            
                            Image(list.books[index].cover)
                                .resizable()
                                .scaledToFit()
                                .frame(height: iPadOrientation ? 185 : pinnedOnExplore ? 100 : 120)
                                .cornerRadius(10)
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.white)
                                )
                                
                            
                            if count != 1 && (index == 0 || (count != 2 && index == 1) || (count == 2 && index != 1)) {
                                Spacer()
                            }
                            
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.42)

                         
                        
                    }
                    
                    
                }
                //.frame(width: UIScreen.main.bounds.width * 0.46)

                HStack {
                    if let user = sphereUsers.getUserById(userId: list.user){
                        
                        
                        if user.isTBRList(list: list){
                            VStack(alignment: .leading) {
                                StatusView(status: .tbr, fontSize: 16)
                                    .padding(.leading, -7)
                                Text("\(list.books.count) books")
                                    .font(.system(size: 12, weight: .medium))
                                    .opacity(0.7)

                    
                            }
                        } else if user.isReadList(list: list){
                            VStack(alignment: .leading) {
                                StatusView(status: .read, fontSize: 16)
                                    .padding(.leading, -7)

                                Text("\(list.books.count) books")
                                    .font(.system(size: 12, weight: .medium))
                                    .opacity(0.7)

                            }

                        } else if user.isReadingList(list: list){
                            VStack(alignment: .leading) {
                                StatusView(status: .current, fontSize: 16)
                                    .padding(.leading, -7)

                                Text("\(list.books.count) books")
                                    .font(.system(size: 12, weight: .medium))
                                    .opacity(0.7)
                            }

                        } else {
                            VStack(alignment: .leading) {
                                Text(list.title)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.vertical, 7)

                                //.opacity(0.7)
                                Text("\(list.books.count) books")
                                    .font(.system(size: 12, weight: .medium))
                                    .opacity(pinnedOnExplore ? 0.0 : 0.7)
                                
                            }
                        }
                    }
                    Spacer()
                    if pinnedOnExplore {
                        Button(action: {}){
                            HStack {
                                Text("Explore Lists")
                                    .padding(.trailing, -4)
                                Image(systemName: "chevron.forward")
                            }
                            .font(.system(size: 14.5, weight: .medium))
                            .foregroundColor(Color(.blue).opacity(0.8))
                            .padding(.vertical, 3)
                        }

                        
                    }
                }
                .padding(.horizontal)
            }
            .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.46)
            .padding(.vertical)
            .padding(.vertical)
        }
    }


struct AllUserNotesView: View {
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
    
    var body: some View {
        let allBooks = user.getAllBooks()
        
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    
                    Text("Notes")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                    Spacer()
                    
                    // ShareButton(sharePage: $shareNotes)
                       // .padding(.trailing)
                    Image(systemName: "ellipsis")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.trailing)

                    AddDropdown(addBook: $addBook, addNewNote: $addNewNote, uploadPdf: $uploadPdf)
                        .padding(.trailing)
                    
                   
                }
                .padding(.trailing)
                HStack(alignment: .top) {
                    // Side bar
                    if choosingBook {
                        ScrollView {
                            VStack(alignment: .center) {
                                
                                Button(action: {
                                    showRecent = true
                                    choosingBook.toggle()

                                }) {
                                    Text("All")
                                        .font(.system(size: 14, weight: .medium))
                                        .padding(.vertical)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: UIScreen.main.bounds.width * 0.11)
                                                .foregroundColor(showRecent ? Color(.gray).opacity(0.2) : .clear)
                                                .cornerRadius(10)
                                            
                                        )
                                }
                                .foregroundColor(.black)
                                
                                ForEach(allBooks) { book in
                                    let notes = user.getNotesByBookID(bookid: book.id)
                                    
                                    if !notes.isEmpty {
                                        Button(action: {
                                            showRecent = false
                                            selectedBook = book
                                            selectedNotes = notes
                                            choosingBook.toggle()

                                        }) {
                                            VStack(alignment: .center) {
                                                Image(book.cover)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 80)
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                                    .shadow(radius: 0.5)
                                                    .padding(7)
                                            }
                                            .foregroundColor(.black)
                                            .background(selectedBook == book && !showRecent ? Color(.gray).opacity(0.2) : .clear)
                                            .cornerRadius(10)
                                            .padding(.vertical)
                                        }
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        .frame(width: UIScreen.main.bounds.width * 0.1)
                        .padding(.top, UIScreen.main.bounds.height * 0.04)
                        .padding(.top)
                    } else {
                        VStack(alignment: .center) {
                            
                            if let book = selectedBook, !showRecent {
                                Button(action: {
                                    choosingBook.toggle()
                                    
                                }) {
                                    VStack(alignment: .center) {
                                        
                                        Image(book.cover)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                            .shadow(radius: 0.5)
                                            .padding(7)
                                    }
                                    .foregroundColor(.black)
                                    .background(Color(.gray).opacity(0.2))
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                }
                            } else {
                                
                                Button(action: {
                                    choosingBook.toggle()
                                }) {
                                    Text("All")
                                        .font(.system(size: 14, weight: .medium))
                                        .padding(.vertical)
                                        .frame(width: 80)
                                        .padding(7)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                //.frame(width: UIScreen.main.bounds.width * 0.11)
                                                .foregroundColor( Color(.gray).opacity(0.2))
                                                .cornerRadius(10)
                                            
                                        )
                                }
                                .foregroundColor(.black)
                            }
                            Button(action: {
                                choosingBook.toggle()
                            }){
                                Image("down")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25)
                                    .opacity(0.7)
                                    .padding(.vertical)
                            }
                            
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.1)
                        .padding(.top, UIScreen.main.bounds.height * 0.04)
                        .padding(.top)
                    }

                    
                    // Selected Notes
                    VStack {
                        if showRecent {
                            ScrollView {
                                RecentNotesView(isPresenting: .constant(true), notes: user.getAllNotes(), showNote: $showNote, selectedNote: $selectedNote, selectedBook: selectedBook ?? Book(), showToolbar: $showToolbar)
                                    .padding(.trailing, UIScreen.main.bounds.width * 0.05)
                            }
                        } else {
                            ScrollView {
                                AllNotesView(isPresenting: .constant(true), showToolbar: $showToolbar, addNew: .constant(false), notes: selectedNotes, book: selectedBook ?? Book(), showNote: $showNote, selectedNote: $selectedNote, showCharacter: $showCharacter, selectedCharacter: $selectedCharacter)
                                    .onChange(of: selectedNotes) { _ in
                                        selectedChapter = nil
                                    }
                                    .padding(.trailing, UIScreen.main.bounds.width * 0.05)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .onDisappear {
                navigation.reset()
            }
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
            .sheet(isPresented: $showNote) {
                NoteView(isPresenting: $showNote, note: $selectedNote, fullScreen: $fullScreen)
                
            }
            .sheet(isPresented: $showCharacter){
        
                    CharacterView(character: $selectedCharacter, user: userData.user)
                
            }
            .sheet(isPresented: $addBook){
                SelectBook(isPresenting: $addBook, selected: $selectedBook) { book in
                    createNewNote(book: book)
                }
            }
            
            if fullScreen {
                AllUserNotes(user: user, showToolbar: $showToolbar)
                /*
                NoteView(isPresenting: $showNote, note: $selectedNote, fullScreen: $fullScreen)*/
                   /* .onAppear {
                        showToolbar = false
                    }
                    .onDisappear{
                        showToolbar = true
                    }*/
                
            }
            /*
            if addNew {
                AddView(addBook: $addBook, addNewNote: $addNewNote)
            }*/
            
            if addNewNote {
                
                VStack{
                    Spacer()
                }
                .onAppear {
                    createNewNote(book: selectedBook ?? Book())
                }

            }
                
            /*
            if addBook {
                
            }*/
        }
        .background(backgroundColor)
    }
    
    func createNewNote(book: Book) {
        
        newNote = Note(book: book, elements: [NoteElement(isText: true, text: "")])
        showNewNote = true
        showNote = true
        selectedNote = newNote
        fullScreen = false
        addNew.toggle()
        userData.user.addNote(note: newNote)
        
    }
}

struct NotesPickerView: View {
    @State var user: User
    @State var selectedNotes: [Note] = []
    @Binding var showToolbar: Bool
    @Binding var selectedBook: Book
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
    @State var addNewNote = false
    @EnvironmentObject var userData: UserData
    @State var showCharacter = false
    @State var selectedCharacter: Character? = nil
    var body: some View {
        let allBooks = user.getAllBooks()
        
        ZStack {
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
            
                    
                    // Selected Notes
                    VStack {
                   
                            ScrollView {
                                
                                
                                
                                AllNotesView(isPresenting: .constant(true), showToolbar: $showToolbar, addNew: $addNew, notes: selectedNotes, book: selectedBook, showNote: $showNote, selectedNote: $selectedNote, pickable: true, showCharacter: $showCharacter, selectedCharacter: $selectedCharacter)
                                    .onChange(of: selectedNotes) { _ in
                                        selectedChapter = nil
                                    }
                                
                                    .padding(.trailing, UIScreen.main.bounds.width * 0.05)
                            }
                        
                    }
                }
            }
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
          
            
            if showNote {
                NoteView(isPresenting: $showNote, note: $selectedNote, fullScreen: $fullScreen, sidebar: true)
                    .onAppear {
                        showToolbar = false
                    }
                    .onDisappear {
                        showToolbar = true
                    }
                
                
            }
            
            if addNewNote {
                
                VStack{
                    Spacer()
                }
                .onAppear {
                    createNewNote(book: selectedBook ?? Book())
                }

            }
            
            if addNew {
                AddView(addBook: $addBook, addNewNote: $addNewNote)
            }
            
            /*if addBook {
                SelectBook(isPresenting: $addBook, selected: $selectedBook) { book in
                    createNewNote(book: book)
                }
            }*/
        }
        .background(Color(hex: "#FCF9EE"))
    }
    
    func createNewNote(book: Book) {
        newNote = Note(book: book, elements: [NoteElement(isText: true, text: "")])
        showNewNote = true
        showNote = true
        selectedNote = newNote
        fullScreen = false
        addNew.toggle()
        userData.user.addNote(note: newNote)
        
    }
}

struct RecentNotesView: View {
    @Binding var isPresenting: Bool
    var notes: [Note]
    @Binding var showNote: Bool
    @Binding var selectedNote: Note
    @State var showBook = false
    @State var selectedBook: Book
    @State var showPostActions = false
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var searching = false
    @Binding var showToolbar: Bool
    @State var showCharacters = false
    @State var showQuotes = false
    var body: some View {
        VStack {
                HStack {
                    Text("All")
                        .font(.system(size: 19, weight: .medium))
                    Spacer()
                    if !searching {
                        Button(action: {
                            searching.toggle()
                        }){
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 16))
                        }
                    }

                }
                .padding()
            
            if searching {
                SearchNotesBar(isPresenting: $searching, book: selectedBook, showToolbar: $showToolbar, showCharacters: $showCharacters, showQuotes: $showQuotes)
                
            }
              

                
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
            
            Spacer()
        }
        .padding(.top, UIScreen.main.bounds.height * 0.04)
        .padding(.top)
        .background(backgroundColor)
    }
}
    

/*
struct RecentNotesView: View {
    var notes: [Post]
    @State private var showNote = false
    @State private var selectedNote = Post()
    
    // Define the grid layout with 3 columns
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(notes) { note in
                    NoteCard(note: note, showNote: $showNote, selectedNote: $selectedNote)
                }
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width * 0.65)
        .sheet(isPresented: $showNote) {
            // Your note detail view goes here
            NoteView(isPresenting: $showNote, note: selectedNote)
        }
    }
}
*/
struct NoteCard: View {
    var note: Note
    @Binding var showNote: Bool
    @Binding var selectedNote: Note
    
    var body: some View {
        Button(action: {
            showNote = true
            selectedNote = note
        }){
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.9), lineWidth: 0.7)
                .frame(width: 200, height: 200)
                .overlay(
                    VStack(alignment: .leading) {
                        Text(note.title)
                            .padding(.bottom)
                            .font(.system(size: 16, weight: .medium))
                            .multilineTextAlignment(.leading)
                        
                        Text(note.description)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                    }
                        .foregroundColor(.black)
                        .padding()
                )
        }
    }
}





struct PinnedQuote: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "pin.fill")
                    .font(.system(size: 13))
                Spacer()
            }
            
            Text("the people who are crazy enough to think they can change the world, are the ones who do.")
                .font(.system(size:14))
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .frame(width: UIScreen.main.bounds.width * 0.82)
                .padding(.vertical)
                .background(
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.gray.opacity(0.1))
                        .frame(width: UIScreen.main.bounds.width * 0.86)
                        
                    
                )
        }
        .frame(width: UIScreen.main.bounds.width * 0.86)

            
    }
}

struct Collections: View {
    let reviews = [ "Quotes", "Reviews", "Posts"
    ]
    @Binding var isPresenting: Bool
    
    @Binding var selectedBookNotes : Book
    // This will hold your chunks of reviews
    private var chunkedReviews: [[String]] {
        reviews.chunked(into: 2) // Chunking into groups of 9 for 3x3 grids
    }

    // Define the grid layout
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        
        VStack(alignment: .leading){
            Text("Collections")
                .font(.system(size: 16, weight: .medium))
                .padding(.leading)


            
            TabView {
                ForEach(Array(chunkedReviews.enumerated()), id: \.offset) { index, chunk in
                    
                    VStack{
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(chunk, id: \.self) { title in
                                Button(action:{
                                    isPresenting.toggle()
                                    
                                }){
                                    CollectionCell(title: title)
                                        .frame(width: UIScreen.main.bounds.width * 0.47)

                                }
                            }
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
            
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(width: UIScreen.main.bounds.width * 0.99, height: 120)
        }
    }
}

struct CollectionCell: View {
    @State var title : String
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .frame(width: UIScreen.main.bounds.width * 0.42, height: 60)
            .foregroundColor(.gray.opacity(0.1))
        .overlay(
                
                
                VStack(alignment: .center) {
                    
                    Text(title)
                        .font(.system(size: 15, weight: .medium))

                    
                }
                .frame(width: 120, alignment: .center)
                .foregroundColor(.black)

        )
    }
}


struct ReviewPreview: View {
    
    @State var isLiked : Bool = false
    @State var review = Review()
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @Binding var showReview: Bool
    @Binding var selectedReview: Review
    //@Binding var showPostActions : Bool
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @EnvironmentObject var userData: UserData
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var hideCover = false
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        HStack(alignment: .top){
            if !hideCover {
                Button(action: { showBook = true }){
                    
                    
                    Image(review.rating.book.cover)
                        .resizable()
                        .aspectRatio(contentMode: .fit) // Changed to .fill to ensure the image covers the area
                        .frame(height: UIScreen.main.bounds.height * 0.2 )
                    
                    //.frame(height: iPadOrientation ? UIScreen.main.bounds.height * 0.1 : 80 )
                        .clipped() // This ensures the image is clipped to the frame bounds
                        .cornerRadius(5) // Apply corner radius directly to the image
                        .shadow(radius: 0.5)
                        .padding(.top)
                        .padding(.trailing)
                    //.padding(.trailing, 3)
                    
                    
                }
            }
        VStack {
            

            HStack {
                Button(action: {
                    showProfile = true
                    selectedProfile = review.rating.user
                }){
                    ProfileThumbnail(image: review.rating.user.photo, size: 30)
                    
                    Text("\(review.rating.user.name)")
                        .font(.system(size: 15, weight: .medium))
                        .padding(.trailing, -1)
                    Text("rated")
                        .font(.system(size: 15))
                        .padding(.trailing, -3)
                    if !hideCover {
                        Text(review.rating.book.title)
                            .font(.system(size: 15, weight: .medium))
                            .underline(true, color: .black)
                    }
                    ReviewStar(rating: review.rating.stars)
                    
                }
                Spacer()
               // Text(timeSince(from: rating.timestamp))
                  //  .padding(.vertical, 2)
                  //  .font(.system(size: 11))
                  //  .opacity(0.7)
                
                
                
            }
            .padding(.top)
            
            Button(action: {
                selectedReview = review
                showReview = true
                
                
            }){
                
                                            
                        VStack(alignment: .leading) {
                            let read = userData.user.read(book: review.rating.book)
                           /* HStack {
                                Text("\(post.book.title)")
                                    .font(.system(size: 11.5))
                                    .underline(true, color: .black)
                                //.opacity(0.5)
                                    .padding(.bottom, 2)
                                    .padding(.top, 2)
                                Spacer()
                            }*/
                                
                          
                            Text(review.title)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.vertical, 2)
                                        .padding(.top)
                                        .padding(.bottom, 5)
                                    
                             
                                
                                
                            Text(review.description)
                                    .font(.system(size: 15))
                                    .lineLimit(7)
                                    .lineSpacing(4)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom)
                                  
                            
                                
                            
                            HStack {
                               
                                Spacer()
                                
                                Text("\(review.likes) likes")
                                    .font(.system(size: 13))
                                    .opacity(0.7)
                                    .padding(.trailing)
                                if review.comments.count > 0 {
                                    
                                    Text("\(review.comments.count) comments")
                                        .font(.system(size: 13))
                                        .opacity(0.7)
                                        .padding(.trailing)
                                }
                                
                                
                                if !isLiked {
                                    Button(action: {
                                        isLiked.toggle()
                                        review.likes += 1
                                        
                                    }){
                                        Image(systemName: "heart")
                                            .font(.system(size: 19))
                                            //.foregroundColor(.black)
                                    }
                                } else {
                                    Button(action: {
                                        isLiked.toggle()
                                        review.likes -= 1
                                        
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
                            selectedReview = review
                            showReview = true
                        }
                        .onLongPressGesture(minimumDuration: 1){
                            //selectedPost = post
                           // showPostActions = true
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal, 4)

                
            }
            //.foregroundColor(.black)
            .padding()
            //.padding(.vertical)
            //.background(backgroundColor)
            
            
            
            
            
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

struct ReviewStar: View {
    @State var rating: Float
    @State var size = 14.0

    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.orange)
                .font(.system(size: size))
                .padding(.trailing, -6)
            
            Text("\(displayRating)")
                .font(.system(size: size, weight: .medium))
        }
    }
    
    var displayRating: String {
        if floor(rating) == rating {
            // If the number is an integer
            return String(format: "%.0f", rating)
        } else {
            // If the number is a float
            return String(format: "%.1f", rating)
        }
    }
}

struct AllBooks: View {
    @Binding var isPresenting : Bool
    @State var xoffset = 0.0
    @State var showBook = false
    @State var selectedBook = Book()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var userData: UserData
    @ObservedObject var user: User
    @State var contentViewModel = ContentViewModel(book: Book())

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text(userData.user.name)
                            .font(.system(size: 14))
                        
                        Spacer()
                        Text("Books")
                            .font(.system(size: 15, weight: .medium))
                        Spacer()
                        Text(userData.user.name)
                            .font(.system(size: 14))
                            .foregroundColor(.clear)
                        Image(systemName: "arrow.left")
                            .foregroundColor(.clear)

                        
                    }
                    .padding(.horizontal)
                    
                    ThreeGrid(books: userData.user.library, showBook: $showBook, selectedBook: $selectedBook, viewModel: $contentViewModel)
                        .padding(.top)
                        .padding(.top)

                    
                    
                }
            }
            .padding(.top)
            .padding(.bottom, 100)
            .background(backgroundColor)
            
            

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
                    // Reset the offset or perform any action after the drag ends
                    if self.xoffset > UIScreen.main.bounds.width/2.2 {
                        
                        
                        self.xoffset = UIScreen.main.bounds.width
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isPresenting = false
                        }
                    } else {
                        self.xoffset = 0
                        
                    }
                }
        )
        .animation(.easeOut, value: xoffset) // Animate the return movement
    }
}

struct AllPosts: View {
    @Binding var isPresenting : Bool
    @State var xoffset = 0.0
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var userData: UserData
    @ObservedObject var user: User
    @State var showBook = false
    @State var selectedBook = Book()
    @EnvironmentObject var allBooks : Library
    
    @State var isLiked = false
    @State var showPost = false
    @State var selectedPost = Note()
    @State var showPostActions = false
    
    @State var showProfile = false
    @State var selectedProfile = User()
    @State var selectedReview = Review()
    @State var showReview = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack{
                        Image(systemName: "arrow.left")
                        Text(userData.user.name)
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 25)
                    var allPosts = user.getAllPosts()
                    ForEach(allPosts) { post in
                        PostPreview(post: post, showPost: $showPost, selectedPost: $selectedPost, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $showPostActions, showProfile: $showProfile, selectedProfile: $selectedProfile, coverShown: false, inDiscussionView: false)
                            .foregroundColor(.black)
                        
                        Divider()
                        
                    }

                    
                    
                }
            }
            .padding(.top)
            .padding(.bottom, 100)
            .background(backgroundColor)
            
            

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
                    // Reset the offset or perform any action after the drag ends
                    if self.xoffset > UIScreen.main.bounds.width/2.2 {
                        
                        
                        self.xoffset = UIScreen.main.bounds.width
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isPresenting = false
                        }
                    } else {
                        self.xoffset = 0
                        
                    }
                }
        )
        .animation(.easeOut, value: xoffset) // Animate the return movement
    }
}
    /*
struct AllLists: View {
    @Binding var isPresenting : Bool
    @State var xoffset = 0.0
    @State var showBook = false
    @State var selectedBook = Book()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var userData: UserData
    @State var showList = false
    @State var selectedList = List()
    @ObservedObject var user: User
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack{
                        Image(systemName: "arrow.left")
                        Text(userData.user.name)
                            .font(.system(size: 14))
                        
                        Spacer()
                        Text("Lists")
                            .font(.system(size: 15, weight: .medium))
                        Spacer()
                        Text(userData.user.name)
                            .font(.system(size: 14))
                            .foregroundColor(.clear)
                        Image(systemName: "arrow.left")
                            .foregroundColor(.clear)

                        
                    }
                    .padding(.horizontal)
                    /*
                    VStack(alignment: .leading){
                        HStack{
                            ProfileThumbnail(image: user.photo, size: 20)
                            Text(userData.user.name)
                                .font(.system(size: 14))
                            Spacer()
                        }
                        
        
                        
                        
                        
                    }
                    .padding()
                     */
                    var lists = [user.readingList] + user.lists

                    ListGrid(showList: $showList, selectedList: $selectedList, lists: lists)
                        .padding(.top)
                    
                }
            }
            .padding(.top)
            .padding(.bottom, 100)
            .background(backgroundColor)
            
            if showList {
                ListView(isPresenting: $showList, list: $selectedList, user: user)
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
                    // Reset the offset or perform any action after the drag ends
                    if self.xoffset > UIScreen.main.bounds.width/2.2 {
                        
                        
                        self.xoffset = UIScreen.main.bounds.width
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isPresenting = false
                        }
                    } else {
                        self.xoffset = 0
                        
                    }
                }
        )
        .animation(.easeOut, value: xoffset) // Animate the return movement
    }
}
*/
struct QuotePrev: View {
    @State private var selectedImageIndex = 0
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isLiked = false
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @Binding var showQuote : Bool
    @Binding var selectedQuote : Quote2
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @Binding var showAuthor: Bool
    @Binding var selectedAuthor: Author
    @State var quote : Quote2
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact

        HStack(alignment: .top){
            Button(action: { showBook = true}) {
                Image(quote.book.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Changed to .fill to ensure the image covers the area
                    .frame(height: UIScreen.main.bounds.height * 0.2)
                    .clipped() // This ensures the image is clipped to the frame bounds
                    .cornerRadius(5) // Apply corner radius directly to the image
                    .shadow(radius: 0.5)
                    //.padding(.trailing, 3)
                    .padding(.trailing)
                
            }
        
                VStack {
                    HStack {
                        HStack {
                            Button(action: {
                                showProfile = true
                                selectedProfile = quote.user
                            }){
                                ProfileThumbnail(image: quote.user.photo, size: 30)
                                
                                Text("\(quote.user.name)")
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.trailing, -1)
                                    .foregroundColor(.black)
                                Text("shared a note on")
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.trailing, -3)

                                Text(quote.book.title)
                                    .font(.system(size: 15, weight: .medium))
                                    .underline(true, color: .black)
                            }
                            Spacer()
                            Text(timeSince(from: quote.timestamp))
                                .padding(.vertical, 2)
                                .font(.system(size: 11))
                                .opacity(0.7)
                            
                        }
                        
                        
                        /*
                        Text("quoted")
                            .font(.system(size: 15))
                            .padding(.horizontal, -2)
                        
                        Button(action: {
                            showBook = true
                            selectedBook = quote.book
                        }){
                            Text("\(quote.book.title)")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.leading, -1)
                                .italic()
                                .foregroundColor(.black)
                            
                        }
                         */
                        Spacer()
                    }
                    .padding(.vertical)
                    /*
                    HStack {
                        Text("\(quote.book.title)")
                            .font(.system(size: 11.5))
                            .underline(true, color: .black)
                            .opacity(0.7)
                            .padding(.bottom, 2)
                            .padding(.top, -12)
                        Spacer()
                    }
                    */
                    if quote.title != "" {
                        HStack {
                            Text(quote.title)
                                .font(.system(size: 16, weight: .medium))
                                //.padding(.top, 10)
                                .padding(.bottom, 8)
                            Spacer()
                        }
                        
                    }
                     
                    VStack(alignment: .leading) {
                        Button(action: {
                            selectedQuote = quote
                            showQuote = true
                            
                           // withAnimation{
                             //   showPost = true
                            //}
                        }){
                            // Charter-Roman
                            // Georgia HoeflerText-Regular
                            // TimesNewRomanPSMT
                                    
                                    VStack(alignment: .leading) {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Spacer()
                                                IndentedQuoteView(text: quote.quote)
                                                //.frame(height: 170)
                                                //.font(.custom("Georgia", size: 13.5))
                                                //.font(.system(size: 14.5))
                                                    .lineSpacing(6)
                                                    .multilineTextAlignment(.leading)
                                                    .opacity(0.9)
                                                    .padding(.bottom, 6)
                                                //.padding(.horizontal, 10)
                                                //.padding(.top, 10)
                                                Spacer()
                                            }

                                            //HighlightedText(text: quote.quote, frameWidth: 315)
                                            //.lineLimit(7)
                                            
                                            /* ——— */
                                            
                                            /*Divider()
                                                .padding(.top, 10)
                                                .padding(.bottom, 6)
                                            */
                                            HStack {
                                                Spacer()
                                                HStack {
                                                    Button(action: {
                                                        showAuthor = true
                                                        selectedAuthor = quote.book.author
                                                    }){
                                                        Text("\(quote.book.author.name), ")
                                                    }
                                                    Button(action: { showBook = true }){
                                                        Text("\(quote.book.title)")
                                                            .underline(true, color: .black)
                                                            .padding(.leading, -4)
                                                    }
                                                    
                                                    
                                                }
                                                .opacity(0.9)
                                                .font(.custom("Georgia", size: 12))

                                                //.font(.system(size: 12.5))
                                                .foregroundColor(.black)
                                                .padding(.trailing, 10)
                                            }
                                            .padding(.bottom, 10)
                                        }
                                        .padding(.vertical, 3)
                                        .background(
                                            VStack{
                                                Spacer()
                                                Rectangle()
                                                    .fill(backgroundColor)
                                                    .frame(height: 24)
                                                
                                                
                                            }
                                                .padding(.bottom, 15)
                                        
                                                
                                        )
                                        /*
                                        .background(
                                            VStack{
                                                Spacer()
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(backgroundColor)
                                                    .frame(height: 39)
                                                
                                            }
                                        
                                                
                                        )
                                        .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(backgroundColor)
                                                    //.fill(Color(hex: "EFEADA"))
                                        
                                                
                                        )
                                        
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray.opacity(0.7), lineWidth: 0.5)
                                        )*/
                                        

                                        
                                        
                                        Text(quote.description)
                                            .font(.system(size: 15))
                                            .lineLimit(5)
                                            .lineSpacing(4)
                                            .multilineTextAlignment(.leading)
                                            .padding(quote.title != ""  ? .vertical : .bottom)
                                            .padding(.top, quote.title == "" ? 2 : 0)

                                    
                                    
                            }
                            
                        }
                        
                            
                    
                   
                    
                    
                    
                        
                        Button(action: {
                            selectedQuote = quote
                            showQuote = true

                        }){
                            VStack(alignment:.leading) {
                                
                                
                               /* Text("\(user.name) quote.description")
                                    .font(.system(size: 15))
                                    .lineLimit(3)
                                    .lineSpacing(4)
                                    .padding(.vertical)
                                    .foregroundColor(.black) */
                            }
                            
                        }
                        
                        HStack {
                            
                            Spacer()
                            
                            Text("\(quote.likes) likes")
                                .font(.system(size: 13))
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
                                    
                                }){
                                    Image(systemName: "heart")
                                        .font(.system(size: 19))
                                        .foregroundColor(.black)
                                }
                            } else {
                                Button(action: {
                                    isLiked.toggle()
                                    quote.likes -= 1
                                    
                                }){
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 19))
                                        .foregroundColor(.pink)
                                }
                            }
                            
                        }
                        .offset(y: 5)
                    }
                    //.padding(.horizontal)

                    
                }
                .foregroundColor(.black)
                .padding(.horizontal, 4)
        }
        .padding()
        .background(backgroundColor)

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

/*
 {
     @State private var selectedImageIndex = 0
     @State var backgroundColor = Color(hex: "#FDFAEF")
     @State var isLiked = false
     @Binding var showBook : Bool
     @Binding var selectedBook : Book
     @Binding var showQuote : Bool
     @Binding var selectedQuote : Quote
     @Binding var showProfile: Bool
     @Binding var selectedProfile: User
     @Binding var showAuthor: Bool
     @Binding var selectedAuthor: Author
     @State var quote : Quote

     
     var body: some View {
                 
         HStack(alignment: .top){
             Button(action: { showBook = true}){
                 Image(quote.book.cover)
                     .resizable()
                     .aspectRatio(contentMode: .fit) // Changed to .fill to ensure the image covers the area
                     .frame(height: 80)
                     .clipped() // This ensures the image is clipped to the frame bounds
                     .cornerRadius(2) // Apply corner radius directly to the image
                     .shadow(radius: 0.5)
                     .padding(.top)
                     .padding(.trailing, 3)
                 
             }
         
                 VStack {
                     HStack {
                         HStack {
                             Button(action: {
                                 showProfile = true
                                 selectedProfile = quote.user
                             }){
                                 ProfileThumbnail(image: quote.user.photo, size: 30)
                                 
                                 Text("\(quote.user.name)")
                                     .font(.system(size: 15, weight: .medium))
                                     .padding(.trailing, -1)
                                     .foregroundColor(.black)
                                 
                             }
                             Spacer()
                             Text(timeSince(from: quote.timestamp))
                                 .padding(.vertical, 2)
                                 .font(.system(size: 11))
                                 .opacity(0.7)
                             
                         }
                         
                         
                         /*
                         Text("quoted")
                             .font(.system(size: 15))
                             .padding(.horizontal, -2)
                         
                         Button(action: {
                             showBook = true
                             selectedBook = quote.book
                         }){
                             Text("\(quote.book.title)")
                                 .font(.system(size: 15, weight: .medium))
                                 .padding(.leading, -1)
                                 .italic()
                                 .foregroundColor(.black)
                             
                         }
                          */
                         Spacer()
                     }
                     .padding(.vertical)
                     HStack {
                         Text("Fiction")
                             .font(.system(size: 11.5))
                             .opacity(0.7)
                             .padding(.bottom, 2)
                             .padding(.top, -12)
                         Spacer()
                     }
                     VStack(alignment: .leading) {
                         Button(action: {
                             selectedQuote = quote
                             showQuote = true
                             
                            // withAnimation{
                              //   showPost = true
                             //}
                         }){
                             // Charter-Roman
                             // Georgia HoeflerText-Regular
                             // TimesNewRomanPSMT
                                     
                                     VStack(alignment: .leading) {
                                         VStack(alignment: .leading) {
                                             Text(quote.quote)
                                                 //.frame(height: 170)
                                                 .font(.custom("Georgia", size: 14))
                                                 //.font(.system(size: 14.5))
                                                 .lineSpacing(4)
                                                 .multilineTextAlignment(.leading)
                                                 .opacity(0.9)
                                                 .padding(.horizontal, 10)
                                                 .padding(.top, 10)

                                             //HighlightedText(text: quote.quote, frameWidth: 315)
                                             //.lineLimit(7)
                                             
                                             /* ——— */
                                             
                                             Divider()
                                                 .padding(.top, 10)
                                                 .padding(.bottom, 6)
                                             
                                             HStack {
                                                 Spacer()
                                                 HStack {
                                                     Button(action: {
                                                         showAuthor = true
                                                         selectedAuthor = quote.book.author
                                                     }){
                                                         Text("\(quote.book.author.name), ")
                                                     }
                                                     Button(action: { showBook = true }){
                                                         Text("\(quote.book.title)")
                                                             .underline(true, color: .black)
                                                             .padding(.leading, -4)
                                                     }
                                                     
                                                     
                                                 }
                                                 .font(.custom("Georgia", size: 12.5))

                                                 //.font(.system(size: 12.5))
                                                 .foregroundColor(.black)
                                                 .padding(.trailing, 10)
                                             }
                                             .padding(.bottom, 10)
                                         }
                                         .padding(.vertical, 3)
                                         .background(
                                             VStack{
                                                 Spacer()
                                                 Rectangle()
                                                     .fill(backgroundColor)
                                                     .frame(height: 24)
                                                 
                                                 
                                             }
                                                 .padding(.bottom, 15)
                                         
                                                 
                                         )
                                         .background(
                                             VStack{
                                                 Spacer()
                                                 RoundedRectangle(cornerRadius: 8)
                                                     .fill(backgroundColor)
                                                     .frame(height: 39)
                                                 
                                             }
                                         
                                                 
                                         )
                                         .background(
                                                 RoundedRectangle(cornerRadius: 8)
                                                     .fill(Color(hex: "EFEADA"))
                                         
                                                 
                                         )
                                         
                                         .overlay(
                                             RoundedRectangle(cornerRadius: 8)
                                                 .stroke(Color.gray.opacity(0.7), lineWidth: 0.5)
                                         )
                                         if quote.title != "" {
                                             Text(quote.title)
                                                 .font(.system(size: 16, weight: .medium))
                                                 .padding(.top, 10)
                                             
                                         }
                                         
                                         
                                         Text(quote.description)
                                             .font(.system(size: 15))
                                             .lineLimit(5)
                                             .lineSpacing(4)
                                             .multilineTextAlignment(.leading)
                                             .padding(quote.title != ""  ? .vertical : .bottom)
                                             .padding(.top, quote.title == "" ? 2 : 0)

                                     
                                     
                             }
                             
                         }
                         
                             
                     
                    
                     
                     
                     
                         
                         Button(action: {
                             selectedQuote = quote
                             showQuote = true

                         }){
                             VStack(alignment:.leading) {
                                 
                                 
                                /* Text("\(user.name) quote.description")
                                     .font(.system(size: 15))
                                     .lineLimit(3)
                                     .lineSpacing(4)
                                     .padding(.vertical)
                                     .foregroundColor(.black) */
                             }
                             
                         }
                         
                         HStack {
                             
                             Spacer()
                             
                             Text("\(quote.likes) likes")
                                 .font(.system(size: 13))
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
                                     
                                 }){
                                     Image(systemName: "heart")
                                         .font(.system(size: 19))
                                         .foregroundColor(.black)
                                 }
                             } else {
                                 Button(action: {
                                     isLiked.toggle()
                                     quote.likes -= 1
                                     
                                 }){
                                     Image(systemName: "heart.fill")
                                         .font(.system(size: 19))
                                         .foregroundColor(.pink)
                                 }
                             }
                             
                         }
                         .offset(y: 5)
                     }
                     //.padding(.horizontal)

                     
                 }
                 .foregroundColor(.black)
                 .padding(.horizontal, 4)
         }
         .padding()
         .background(backgroundColor)

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

struct SphereAutoMessage: View {
    @State var message: String
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
                
                
                VStack{
/*
                    HStack {
                        ProfileThumbnail(image: "logo2", size: 30)
                        
                        Text("sphere")
                            .font(.system(size: 15, weight: .medium))
                            .padding(.trailing, -1)
                        Spacer()
                    }
                    .padding(.top) */
                    

                    HStack{
                        Text(message)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.vertical, 2)
                        Spacer()
                    }
                    
                    VStack(spacing: 12) {
                        ForEach(1...5, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 4.5)
                                .frame(height: 15)
                                .foregroundColor(lightModeController.getForegroundColor().opacity(0.08))
                        }
                    }
                    .padding(.top)


                    
                }
                //.padding(.vertical)
                .cornerRadius(8)
                .padding(.trailing, 2)
                .padding()

                
    }
    

    
}

struct PostPreview: View {
    
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State private var dominantColors: UIImageColors? = nil
    @State private var color1: UIColor? = nil
    @State private var color2: UIColor? = nil
    
    @State private var selectedImageIndex = 0
    @State var isLiked : Bool = false
    @State var post = Note()
    
    @Binding var showPost : Bool
    @Binding var selectedPost : Note
    @State private var scale: CGFloat = 0.1 // Start with a smaller scale
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @Binding var showPostActions : Bool
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @State var coverShown: Bool = true
    @State var inDiscussionView = false
    @EnvironmentObject var userData: UserData
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        HStack(alignment: .top){
            if !inDiscussionView && !coverShown {
                
                Button(action: { showBook = true }){
                    Image(post.book.cover)
                        .resizable()
                        .aspectRatio(contentMode: .fit) // Changed to .fill to ensure the image covers the area
                        .frame(height: UIScreen.main.bounds.height * 0.2 )

                    //.frame(height: iPadOrientation ? UIScreen.main.bounds.height * 0.1 : 80 )
                        .clipped() // This ensures the image is clipped to the frame bounds
                        .cornerRadius(5) // Apply corner radius directly to the image
                        .shadow(radius: 0.5)
                        .padding(.top)
                        .padding(.trailing)
                        //.padding(.trailing, 3)
                    
                }
            }
        VStack {
            

            HStack {
                Button(action: {
                    showProfile = true
                    selectedProfile = post.user
                }){
                    ProfileThumbnail(image: post.user.photo, size: 25)
                    
                    Text("\(post.user.name)")
                        .font(.system(size: 15, weight: .medium))
                        .padding(.trailing, -1)
                }
                Spacer()

                
                
                if inDiscussionView || coverShown {
                    Spacer()
                }
                
            }
            .padding(.top)
            
            Button(action: {
                selectedBook = post.book
                showBook = true
                
                
            }){
                
                                            
                        VStack(alignment: .leading) {
                            let read = userData.user.read(book: post.book)
                           /* HStack {
                                Text("\(post.book.title)")
                                    .font(.system(size: 11.5))
                                    .underline(true, color: .black)
                                //.opacity(0.5)
                                    .padding(.bottom, 2)
                                    .padding(.top, 2)
                                Spacer()
                            }*/
                            if post.spoiler == false || read {
                                
                                if post.title != "" {
                                    Text(post.title)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.top, 2)
                                    
                                }
                                
                                
                                Text(post.description)
                                    .font(.system(size: 15))
                                    .lineLimit(coverShown ? 5 : 7)
                                    .lineSpacing(4)
                                    .multilineTextAlignment(.leading)
                                    .padding(post.title != ""  ? .vertical : .bottom)
                                    .padding(.top, post.title == "" ? 2 : 0)
                            
                                
                            } else {
                                
                                SpoilerAlert()
                            }
                            
                            HStack {
                                Text(timeSince(from: post.timestamp))
                                    .padding(.vertical, 2)
                                    .font(.system(size: 13))
                                    .opacity(0.7)
                                Spacer()
                                
                                Text("\(post.likes) likes")
                                    .font(.system(size: 13))
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
                                        
                                    }){
                                        Image(systemName: "heart")
                                            .font(.system(size: 19))
                                            .foregroundColor(.black)
                                    }
                                } else {
                                    Button(action: {
                                        isLiked.toggle()
                                        post.likes -= 1
                                        
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
                            selectedPost = post
                            showPost = true
                        }
                        .onLongPressGesture(minimumDuration: 1){
                            selectedPost = post
                            showPostActions = true
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
                
            }
            .foregroundColor(.black)
            .padding()
            //.padding(.vertical)
            .background(backgroundColor)
            
            
            
            
            
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



struct ActivityPreview: View {
    
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State private var dominantColors: UIImageColors? = nil
    @State private var color1: UIColor? = nil
    @State private var color2: UIColor? = nil
    @State var media: Book = Book()
    @State private var selectedImageIndex = 0
    @Binding var isPresenting: Bool
    @ObservedObject var user = User()
    @State var showBook = true
    
    @State var showPost = false
    @State var selectedPost = Note()
    
    @State var showNotificationView = false
    @State var selectedBook = Book()
    

    @State private var refreshID = UUID()
    @State var showReview = false
    @State var selectedReview = Review()
    @State var isLiked = false
    @State var showQuote = false
    @State var selectedQuote = Quote2()
    @State var create = false
    @State var postActions = false
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User

    var body: some View {
        NavigationView{
            ScrollView{
                VStack{

                    ReviewPreview(showBook: $showBook, selectedBook: $selectedBook, showReview: $showReview, selectedReview: $selectedReview, showProfile: $showProfile, selectedProfile: $selectedProfile)
                        .padding(.top, -8)


                    PostPreview(showPost: $showPost, selectedPost: $selectedPost, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $postActions, showProfile: $showProfile, selectedProfile: $selectedProfile, coverShown: false)
                        .foregroundColor(.black)
                    
                    PostPreview(showPost: $showPost, selectedPost: $selectedPost, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $postActions, showProfile: $showProfile, selectedProfile: $selectedProfile, coverShown: false)
                        .foregroundColor(.black)
              
                    PostPreview(showPost: $showPost, selectedPost: $selectedPost, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $postActions, showProfile: $showProfile, selectedProfile: $selectedProfile,coverShown: false)
                        .foregroundColor(.black)
                    
                    PostPreview(showPost: $showPost, selectedPost: $selectedPost, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $postActions, showProfile: $showProfile, selectedProfile: $selectedProfile, coverShown: false)
                        .foregroundColor(.black)

                }
                .padding()
                .padding(.bottom, 20)
                .background(backgroundColor)
                
            }
        }
        

    }
    
}


/*
struct Note: View {
    @State var book : Book
    var body: some View {
        

        VStack {
            HStack{
                Rectangle()
                    .foregroundColor(Color(hex: "#8DD4FD"))

                    .frame(width: UIScreen.main.bounds.width * 0.03, height: 16)
                    .padding(.trailing, 3)
                
                Rectangle()
                    .foregroundColor(Color(hex: "#F4B3DB"))

                    .frame(width: UIScreen.main.bounds.width * 0.03, height: 16)
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.2, alignment: .trailing)
            .padding(.trailing, 18)
            .padding(.bottom, -8)

            Image(book.cover)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.28)
                .clipped()
                .cornerRadius(3)
                .shadow(radius: 0.5)

        }

    }
}
*/
struct ReadingChallenge: View {
    @EnvironmentObject var userData: UserData
    @State var goal : Int = 20
    @State var width = 110.0
    var body: some View {
        VStack(alignment: .leading) {
            var currentlyRead = userData.user.pastReads.books.count
         
            VStack(alignment: .leading){
            
                HStack {
                  /*  RoundedRectangle(cornerRadius: 10)
                        .frame(width: width, height: 55)
                        .foregroundColor(Color(hex: "#291F00").opacity(0.05))
                        .overlay(*/
                            VStack(alignment: .leading){
                                ZStack(alignment: .leading){
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: width * 0.8, height: 15)
                                        .foregroundColor(Color(hex: "#291F00").opacity(0.08))
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: CGFloat(width * 0.8 * Double(currentlyRead)) / CGFloat(goal), height: 15)
                                        .foregroundColor(.blue.opacity(0.3))
                                }

                                .padding(.bottom, 2)
                                
                            
                                    Text("\(currentlyRead) / \(goal) books")
                                        .font(.system(size: 12))

                                

                            }
                        //)

                }
                
            }
            
        }
    }
}
/*
struct TableView: View {
    
    @Binding var isPresenting: Bool
    @Binding var showToolbar: Bool
    var columns = ["Book", "Title", "Author", "Rating", "Genre", "Status", "Notes"]
    @State var user: User
    @State var books: [Book]
    @EnvironmentObject var userData: UserData
    @State var showNotes = false
    @State var selectedNotes: [Note] = []
    @State var selectedBook = Book()
    @State var selectedNote: Note = Note()
    @State var showNote = false
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var changeStatus = false
    @State var status: StatusType? = nil
    @State var showAuthor = false
    @State var selectedAuthor = Author()
    @State var showBook = false
    @State var showCharacter = false
    @State var selectedCharacter: Character? = nil
    let gridItems = [
        GridItem(.fixed(80), alignment: .leading), // Book cover image
        GridItem(.flexible(minimum: 150), alignment: .leading), // Title
        GridItem(.flexible(), alignment: .leading), // Author
        GridItem(.flexible(), alignment: .leading), // Rating
        GridItem(.flexible(), alignment: .leading), // Genre
        GridItem(.fixed(70), alignment: .leading), // Status
        GridItem(.fixed(40), alignment: .leading)  // Notes
    ]
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(columns, id: \.self) { column in
                            Text(column)
                                .font(.system(size: 12))
                                .bold()
                        }
                    }
                    .padding(.bottom, 10)
                    
                    Divider()
                
                  
                    
                        ForEach(userData.user.library.indices, id: \.self) { index in
                            VStack {
                            LazyVGrid(columns: gridItems, spacing: 16) {
                            let book = userData.user.library[index]
                            
                                    Group {
                                        Button(action: {
                                            showBook = true
                                            selectedBook = book
                                        }){
                                            Image(book.cover)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 60)
                                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                        }
                                        Button(action: {
                                            showBook = true
                                            selectedBook = book
                                        }){
                                            Text(book.title)
                                                .lineLimit(1)
                                                .padding(.trailing, 5)
                                        }
                                        Button(action:{
                                            showAuthor = true
                                            selectedAuthor = book.author
                                        }){
                                            Text(book.author.name)
                                        }
                                        ReviewStars(num: book.rating)
                                        Text(book.genre)
                                        StatusView(user: user, book: book, changeStatus: $changeStatus, status: status, selectedBook: $selectedBook)
                                        let notes = userData.user.getNotesByBookID(bookid: book.id)
                                        Button(action: {
                                            showNotes = true
                                            selectedNotes = notes
                                            selectedBook = book
                                        }) {
                                            Text("\(notes.count)")
                                        }
                                    }
                                    .foregroundColor(.black)
                                    .font(.system(size: 13))
                                
                            
                            
                        }
                                Divider()
                                    .padding(.vertical, 4)

                    }
                  

                }
                Spacer()

            }
            .padding()
            .padding(.top, 60)
            .padding(.leading, 20)
            .background(backgroundColor)
            Spacer()
            
            if showNotes {
                AllNotesView(isPresenting: $showNotes, showToolbar: $showToolbar, addNew: .constant(false), notes: selectedNotes, book: selectedBook, showNote: $showNote, selectedNote: $selectedNote)
            }
            
            if changeStatus {
                AddToLibraryView(isPresenting: $changeStatus, media: selectedBook, saveChanges: { book, status in
                    userData.user.changeBookStatus(book: book, newStatus: status)
                    
                })
            }
            
            if showAuthor {
                AuthorView(author: $selectedAuthor, showToolbar: .constant(true), isPresenting: $showAuthor)
            }
        }
    }
}*/

struct GoalView: View {
    
    var body: some View {
        VStack {
            Text("Goal")
                .font(.system(size: 16, weight: .medium))
                .padding(.vertical)
            
        }
    }
}

struct StatusButton: View {
    @State var book: Book
    @State private var changeStatus: Bool = false
    @State private var status: StatusType? = nil
    @State var fontSize: Double = 13.0
    @EnvironmentObject var userData: UserData

    @State private var thisStatus: StatusType = .tbr
    @EnvironmentObject var notificationCoordinator: NotificationCoordinator

    var body: some View {
        Button(action: {
            changeStatus = true
            status = thisStatus
        }) {
            Text(buttonText)
                .padding(7)
                .font(.system(size: fontSize, weight: .medium))
                .lineLimit(1)
                .foregroundColor(.black)
                .background(thisStatus.color)
                .cornerRadius(8)
        }
        .onAppear{
            thisStatus = userData.user.getStatus(bookid: book.id) ?? .tbr
        }
        .sheet(isPresented: $changeStatus) {
            AddToLibraryView(isPresenting: $changeStatus, media: book, saveChanges: { book, status in
                let currentStatus = userData.user.getStatus(bookid: book.id)
                if (currentStatus != nil) && currentStatus != .tbr {
                    userData.user.addBook(book: book, status: status)
                    
                    notificationCoordinator.sendMarkBookStatusNotification(book: book, status: status)
                } else {
                    userData.user.addBook(book: book, status: status)
                    notificationCoordinator.sendAddedToLibraryNotification()
                }
                updateView()

            })
            .presentationDetents([.fraction(0.8)])
        }
    }

    private var buttonText: String {
        switch thisStatus {
        case .read:
            return "Read"
        case .current:
            return "Reading"
        case .tbr:
            return "To be Read"
        default:
            return "Unknown"
        }
    }
/*
    private var backgroundColor: some View {
        let color: Color
        switch thisStatus {
        case .read:
            color = Color(.green).opacity(0.1)
        case .current:
            color = Color(.purple).opacity(0.1)
        case .tbr:
            color = Color(.yellow).opacity(0.1)
        default:
            color = Color(.gray).opacity(0.1)
        }
        return RoundedRectangle(cornerRadius: 8)
            .foregroundColor(color)
    }*/
    func updateView(){
        thisStatus = userData.user.getStatus(bookid: book.id) ?? .tbr
    }
}





struct FollowButton: View {
    @State var isFollowing = false
    @ObservedObject var user: User
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        
        Button(action: {
            isFollowing.toggle()
            user.follow(user: userData.user)
            
        }) {
            
            RoundedRectangle(cornerRadius: 35)
                .frame(width: UIScreen.main.bounds.width * 0.25, height: 30)
                .foregroundColor(isFollowing ? Color(hex: "#291F00").opacity(0.05) : Color(hex: "#291F00").opacity(0.05))
                //.opacity(0.1)
                .shadow(radius: 0.5)
                .overlay(
                    Text(isFollowing ? "Following" : "Follow")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.black)
                )
        }
        
    }
}

struct ProfileTopBar: View {
    
    var user: User
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        
        VStack{
            ZStack{
                HStack {
                    
                    
                    Spacer()
                    
                    Text(user.handle)
                        .font(.system(size:13, weight: .medium))
                    Spacer()
                    
                    
                    
                }
                HStack {
                    Spacer()
                    FollowButton(user: user)
                        .padding(.trailing)
                }
               
            }
            .padding(.vertical)
            
            
        }
        .background(backgroundColor)

    }
}

struct MyProfileTopBar: View {
    @EnvironmentObject var lightModeController: LightModeController

    var user: User
    @Binding var isEditing: Bool
    //Color(hex: "#F1EFE9")

    var body: some View {
        
        VStack{
            ZStack{
                HStack {
                    /*Image(systemName: "arrow.left")
                     .foregroundColor(.black)
                     .font(.system(size:14, weight: .medium))
                     
                     .padding(.leading, UIScreen.main.bounds.width/15)
                     */
                    
                    /*Image(systemName: "ellipsis")
                        .padding(.leading)
                        .foregroundColor(.clear)
                        .font(.system(size:14))
                    */
                    
                    Spacer()
                    
                    Text(user.handle)
                        .font(.system(size:13, weight: .medium))
                    Spacer()
                    
                    /*
                     Button(action: {
                     }){
                     Image(systemName: "bell.slash")
                     .foregroundColor(.clear)
                     .padding(.trailing, UIScreen.main.bounds.width/15)
                     
                     } */
                    
                    
                    
                    /*Button(action: {
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.black)
                            .font(.system(size:14))
                            .padding(.trailing)
                    }*/
                    
                }
                HStack{
                    Spacer()
                    
                   
                    /*ProfileEditButton(user: user)
                        .padding(.trailing)*/
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            
            
        }
        .background(lightModeController.getBackgroundColor())

    }
}

struct ProfilePicker: View {
    
    @State private var selectedIndex = 0
    private let titles = ["List", "Reviews", "Posts", "Comments"]
    //var user: User
    

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    
                    ForEach(0..<self.titles.count) { index in
                        Button(action: {
                            self.selectedIndex = index
                        }) {
                            Text(self.titles[index])
                                .font(.system(size: 15))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.vertical)
                                .foregroundColor(self.selectedIndex == index ? .black : .gray)
                        }
                        .background(Color.clear)
                    }
                }
                .background(GeometryReader { geo in
                    Color.clear.preference(key: SegmentPreferenceKey.self, value: geo.frame(in: .global))
                })
                .onPreferenceChange(SegmentPreferenceKey.self) { value in
                    DispatchQueue.main.async {
                        self.selectedIndex = self.getSelectedIndex(from: value, geometry: geometry)
                    }
                }

                Rectangle()
                    .frame(width: geometry.size.width / CGFloat(self.titles.count), height: 2.2)
                    .offset(x: CGFloat(self.selectedIndex) * (geometry.size.width / CGFloat(self.titles.count)), y:-8)
                    .foregroundColor(.black)
                    .animation(.linear)
            }
        }
        .padding(.horizontal, 8)

       /* if self.selectedIndex == 0 {
            //Grid(user: user)
                .padding(.top)
        } else {
            AlbumGrid(user: user)
                .padding(.top)

        } */
        
        
        
    }

    private func getSelectedIndex(from value: CGRect, geometry: GeometryProxy) -> Int {
        for i in 0..<self.titles.count {
            let segmentWidth = geometry.size.width / CGFloat(self.titles.count)
            let minX = CGFloat(i) * segmentWidth
            let maxX = minX + segmentWidth
            if value.minX >= minX && value.maxX <= maxX {
                return i
            }
        }
        return 0
    }
}
/*
struct CustomSegmentedPicker: View {
    
    @State private var selectedIndex = 0
    private let titles = ["Books", "Posts", "Lists"]
    @ObservedObject var user: User
    @EnvironmentObject var userData: UserData
    @Binding var isLiked: Bool
    @Binding var showPost: Bool
    @Binding var selectedPost: Post
    @Binding var showBook: Bool
    @Binding var selectedBook: Book
    @Binding var showPostActions: Bool
    @Binding var selectedList: List
    @Binding var showList: Bool
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @Binding var showEReader: Bool
    @Binding var showToolbar: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    
                    ForEach(0..<self.titles.count) { index in
                        Button(action: {
                            self.selectedIndex = index
                        }) {
                            Text(self.titles[index])
                                .font(.system(size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(self.selectedIndex == index ? .black : .gray)
                        }
                        .background(Color.clear)
                    }
                }
                .background(GeometryReader { geo in
                    Color.clear.preference(key: SegmentPreferenceKey.self, value: geo.frame(in: .global))
                })
                .onPreferenceChange(SegmentPreferenceKey.self) { value in
                    DispatchQueue.main.async {
                        self.selectedIndex = self.getSelectedIndex(from: value, geometry: geometry)
                    }
                }

                Rectangle()
                    .frame(width: geometry.size.width / CGFloat(self.titles.count), height: 2.2)
                    .offset(x: CGFloat(self.selectedIndex) * (geometry.size.width / CGFloat(self.titles.count)), y:-8)
                    .foregroundColor(.black)
                    .animation(.linear)
                
                if self.selectedIndex == 1 {
                    
                    VStack{
                        
                        if userData.user.posts != nil {
                            ForEach(0..<userData.user.posts.count){ index in
                                PostPreview(post: userData.user.posts[index], showPost: $showPost, selectedPost: $selectedPost, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $showPostActions, showProfile: $showProfile, selectedProfile: $selectedProfile, coverShown: false)
                                    .foregroundColor(.black)

                            }
                        }
                    }
                        
                    
                    
                } else if self.selectedIndex == 0 {
                    VStack {
                        ThreeGrid(books: userData.user.currentReads.books, showBook: $showBook, selectedBook: $selectedBook, viewModel: ContentViewModel(book: $selectedBook))
                        
                    }
                } else {
                    var lists = [userData.user.currentReads, userData.user.pastReads, userData.user.readingList]  // + userData.user.lists
                    
                    ListGrid(showList: $showList, selectedList: $selectedList, lists: lists)
                }
            }
        }
        .padding(.horizontal, 8)

        
        
    }

    private func getSelectedIndex(from value: CGRect, geometry: GeometryProxy) -> Int {
        for i in 0..<self.titles.count {
            let segmentWidth = geometry.size.width / CGFloat(self.titles.count)
            let minX = CGFloat(i) * segmentWidth
            let maxX = minX + segmentWidth
            if value.minX >= minX && value.maxX <= maxX {
                return i
            }
        }
        return 0
    }
}
*/

struct SearchResultsPicker: View {
    
    @State private var selectedIndex = 0
    private let titles = ["All", "Books", "Movies", "TV", "Podcasts"]
    //var user: User
    

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    
                    ForEach(0..<self.titles.count) { index in
                        Button(action: {
                            self.selectedIndex = index
                        }) {
                            Text(self.titles[index])
                                .font(.system(size: 14))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.vertical)
                                .foregroundColor(self.selectedIndex == index ? .black : .gray)
                        }
                        .background(Color.clear)
                    }
                }
                .background(GeometryReader { geo in
                    Color.clear.preference(key: SegmentPreferenceKey.self, value: geo.frame(in: .global))
                })
                .onPreferenceChange(SegmentPreferenceKey.self) { value in
                    DispatchQueue.main.async {
                        self.selectedIndex = self.getSelectedIndex(from: value, geometry: geometry)
                    }
                }

                Rectangle()
                    .frame(width: geometry.size.width / CGFloat(self.titles.count), height: 2.2)
                    .offset(x: CGFloat(self.selectedIndex) * (geometry.size.width / CGFloat(self.titles.count)), y:-8)
                    .foregroundColor(.black)
                    .animation(.linear)
            }
        }
        .padding(.horizontal, 8)
        .frame(height: 40)

        
        
    }

    private func getSelectedIndex(from value: CGRect, geometry: GeometryProxy) -> Int {
        for i in 0..<self.titles.count {
            let segmentWidth = geometry.size.width / CGFloat(self.titles.count)
            let minX = CGFloat(i) * segmentWidth
            let maxX = minX + segmentWidth
            if value.minX >= minX && value.maxX <= maxX {
                return i
            }
        }
        return 0
    }
}



struct SegmentPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

struct Cell: View {
    @State var media: Book = Book()
    
    var body: some View {
        
        ZStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width * 0.475, height: UIScreen.main.bounds.width * 0.475)
                        .foregroundColor(Color(hex: "#F1EFE9"))
            
            VStack {
                Text(media.title)
                    .foregroundColor(.black)
                    .font(.system(size: 15, weight: .medium))
                    .padding(.top, 250)
                
                Text("Notes")
                    .foregroundColor(.black)
                    .font(.system(size: 12, weight: .medium))
                    .padding(.bottom, 40)
                
                Image(media.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fill) // Changed to .fill to ensure the image covers the area
                    .frame(width: UIScreen.main.bounds.width * 0.45)
                    .clipped() // This ensures the image is clipped to the frame bounds
                    .cornerRadius(6) // Apply corner radius directly to the image
                    .shadow(radius: 0.5)
                // Removed padding since we want the image to fill the rectangle exactly
            }
                        
                }
                .frame(width: UIScreen.main.bounds.width * 0.475, height: UIScreen.main.bounds.width * 0.475) // Ensuring the ZStack has a defined frame
                .clipped() // This ensures the image is clipped to the frame bounds
                
    }
}
//#Preview {
  //  ProfileView()

//}
