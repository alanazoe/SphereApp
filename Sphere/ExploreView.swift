//
//  ExploreView.swift
//  media discussion
//
//  Created by Alana Greenaway on 1/29/24.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var allBooks: Library
    @EnvironmentObject var allPosts: PostLibrary
    @ObservedObject var viewModel: ExploreViewModel
    @Binding var showToolbar: Bool
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var fullScreen = false
    @EnvironmentObject var lightModeController: LightModeController
    @EnvironmentObject var navigation: Nav
    @State var showBookIPhone = false
    @State var showBook = false
    var body: some View {
            
            let iPadOrientation = horizontalSizeClass != .compact

            ZStack {
                VStack {
                    ScrollView {
                        //GeometryReader { geometry in
                            //let isLandscape = geometry.size.width > geometry.size.height

                            VStack(alignment: .leading) {
                                /*
                                 Picker(selection: $viewModel.selectedTab, label: Text("")) {
                                 Text("Books").tag(0)
                                 Text("Posts").tag(1)
                                 Text("Reviews").tag(2)
                                 Text("Lists").tag(3)
                                 }
                                 .pickerStyle(SegmentedPickerStyle())
                                 .padding([.horizontal, .bottom])
                                 */
                                /*
                                 HStack {
                                 Text("Popular This Week")
                                 .font(.system(size: 17, weight: .medium))
                                 .padding(.bottom)
                                 .padding(.top)
                                 Spacer()
                                 }
                                 .padding(.horizontal)
                                 */
                                /*
                                 HStack {
                                 
                                 Button(action: {
                                 
                                 
                                 }){
                                 
                                 HStack {
                                 // Image(systemName: "person.crop.square")
                                 if viewModel.selectedTab == 0 {
                                 //Text("Popular Books")
                                 } else if viewModel.selectedTab == 1{
                                 Text("Popular Notes")
                                 
                                 } else if viewModel.selectedTab == 2{
                                 Text("Popular Reviews")
                                 
                                 } else {
                                 //Text("Popular Lists")
                                 }
                                 }
                                 .font(.custom("Baskerville-SemiBold", size: 18))
                                 .foregroundColor(lightModeController.getForegroundColor())
                                 .padding([.horizontal, .top]) */
                                /*.background(
                                 RoundedRectangle(cornerRadius: 10)
                                 .foregroundColor(Color(hex: "#ECE8DA"))
                                 
                                 )
                                 
                                 }
                                 
                                 }
                                 .padding(.leading)
                                 */
                                
                                // TabView(selection: $viewModel.selectedTab) {
                                
                                
                                VStack {
                                    
                                        if iPadOrientation {
                                            RecommendedList()
                                        }
                                        iPadExploreGrid(longPress: .constant(false), selectedBook: $viewModel.selectedBook, showBook: $viewModel.showBook)
                                            .frame(width: iPadOrientation ? 720 : UIScreen.main.bounds.width * 0.95)
                                            .padding(.top, iPadOrientation ? 0 : 25)
                                        
                                /*    } else {
                                        iPadLandscapeExploreGrid(longPress: $viewModel.longPress, selectedBook: $viewModel.selectedBook, showBook: $viewModel.showBook)
                                        // .padding(.horizontal, UIScreen.main.bounds.width * 0.15)
                                        
                                    }*/
                                    
                                    
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 80)
                                //.tag(0)
                                //.frame(width: UIScreen.main.bounds.width)
                                .background(lightModeController.getBackgroundColor())
                                .ignoresSafeArea()
                                /*
                                 VStack {
                                 PopularPosts(popularPosts: allPosts.posts, showBook: $viewModel.showBook, selectedBook: $viewModel.selectedBook, showPost: $viewModel.showPost, selectedPost: $viewModel.selectedPost, showProfile: $viewModel.showProfile, selectedProfile: $viewModel.selectedProfile, postActions: $viewModel.postActions, isLiked: $viewModel.isLiked)
                                 Spacer()
                                 }
                                 .padding(.bottom, 80)
                                 .tag(1)
                                 //.frame(width: UIScreen.main.bounds.width)
                                 .background(lightModeController.getBackgroundColor())
                                 .ignoresSafeArea()
                                 
                                 VStack {
                                 PopularReviews(popularReviews: userData.user.getAllReviews(), showBook: $viewModel.showBook, selectedBook: $viewModel.selectedBook, showReview: $viewModel.showReview, selectedReview: $viewModel.selectedReview, showProfile: $viewModel.showProfile, selectedProfile: $viewModel.selectedProfile)
                                 Spacer()
                                 }
                                 .padding(.bottom, 80)
                                 .tag(2)
                                 //.frame(width: UIScreen.main.bounds.width)
                                 .background(lightModeController.getBackgroundColor())
                                 .ignoresSafeArea()
                                 *//*
                                    VStack {
                                    PopularLists(popularLists: userData.user.lists, showList: $viewModel.showList, selectedList: $viewModel.selectedList)
                                    Spacer()
                                    }
                                    .padding(.bottom, 80)
                                    .tag(1)
                                    //.frame(width: UIScreen.main.bounds.width)
                                    .background(lightModeController.getBackgroundColor())
                                    .ignoresSafeArea()
                                    }
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))*/
                            //}
                        }
                }
                .frame(width: min(UIScreen.main.bounds.width * 0.95, 1000))
                .scrollIndicators(.hidden)
                .onChange(of: viewModel.showBook){
                    if !iPadOrientation {
                        showBookIPhone.toggle()

                        /*
                        if showBookIPhone{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
                                showBookIPhone.toggle()
                            }
                            } else {
                                showBookIPhone.toggle()
                            }
                         */
                    }
                }
                
            }
            .padding(.top, iPadOrientation ? 150 : 50)
            
            .frame(width: UIScreen.main.bounds.width)
            .background(lightModeController.getBackgroundColor())
            .sheet(isPresented: $viewModel.showPost){
                PublicNoteView(isPresenting: $viewModel.showPost, note: $viewModel.selectedPost, fullScreen: $fullScreen)
                
            }
            .sheet(isPresented: $viewModel.showList){
                ListView(isPresenting: $viewModel.showList, list: $viewModel.selectedList, user: userData.user)

            }
                if viewModel.selectedTab == 0 {
                    
                    SearchBar2(searchText: $viewModel.searchText, searched: $viewModel.searched, showEReader: $viewModel.showEReader, showToolbar: $showToolbar)
                        .frame(width: min(UIScreen.main.bounds.width * 0.95, 1000))
                        .padding(.bottom, -8)
                        .padding(.top, horizontalSizeClass == .compact ? 0 : 80)

                    
                } else if viewModel.selectedTab == 1 {
                    SearchLists(searchText: $viewModel.searchText, searched: $viewModel.searched, showEReader: $viewModel.showEReader, showToolbar: $showToolbar)
                        .frame(width: min(UIScreen.main.bounds.width, 1000))
                        .padding(.bottom, -8)
                        .padding(.top, horizontalSizeClass == .compact ? 0 : 80)
                }
               
              /*
                if viewModel.showPost {
                    Rectangle()
                        .ignoresSafeArea()
                        .opacity(0.2)
                    PostView(post: $viewModel.selectedPost, showingPost: $viewModel.showPost, showEReader: $viewModel.showEReader, showToolbar: $showToolbar)
                }*/
                
                if viewModel.showReview {
                    Rectangle()
                        .ignoresSafeArea()
                        .opacity(0.2)
                    ReviewView(isPresenting: $viewModel.showReview, review: $viewModel.selectedReview)
                }
                
               
                AnimateView(showView: $showBookIPhone) {
                    ContentView(book: $viewModel.selectedBook, isPresenting: $viewModel.showBook, showToolbar: $showToolbar)
                }
                
                
                       
              
                
                
                if viewModel.create {
                    CreateView(create: $viewModel.create)
                }
                
                if viewModel.showSearch {
                    // SearchView(searchMode: .all, isPresenting: $viewModel.showSearch)
                }
                
                
                
                if viewModel.showProfile {
                    ProfileView(user: viewModel.selectedProfile, isPresenting: $viewModel.showProfile, showToolbar: $showToolbar)
                }
                
              //  if !viewModel.showList && !viewModel.showBook && !viewModel.showProfile && !viewModel.showPost && !viewModel.showReview {
                if iPadOrientation {
                    
                    VStack {
                        HStack {
                            
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
                                
                                
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 5)
                        .padding(.top)
                        .padding(.horizontal)
                        Spacer()
                    }
                }
                    
                        /*
                        SearchPosts(searchText: $viewModel.searchText, searched: $viewModel.searched, showEReader: $viewModel.showEReader, showToolbar: $showToolbar)
                            .frame(width: min(UIScreen.main.bounds.width, 1000))
                            .padding(.bottom, -8)
                            .padding(.top, horizontalSizeClass == .compact ? 0 : 80)

                    } else if viewModel.selectedTab == 2 {
                        SearchPosts(searchText: $viewModel.searchText, searched: $viewModel.searched, showEReader: $viewModel.showEReader, showToolbar: $showToolbar)
                            .frame(width: min(UIScreen.main.bounds.width, 1000))
                            .padding(.bottom, -8)
                            .padding(.top, horizontalSizeClass == .compact ? 0 : 80)

                    } else {
                        SearchLists(searchText: $viewModel.searchText, searched: $viewModel.searched, showEReader: $viewModel.showEReader, showToolbar: $showToolbar)
                            .frame(width: min(UIScreen.main.bounds.width, 1000))
                            .padding(.bottom, -8)
                            .padding(.top, horizontalSizeClass == .compact ? 0 : 80)

                    }
                         */
                    //}
        }
            
      
    }
}


struct ExplorePicker: View {
    var picker = ["Books", "Lists", "Reviews", "Posts"]
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            Tag(tag:"Books", selected: selectedTab == 0)
            Tag(tag:"Lists", selected: selectedTab == 1)
            Tag(tag:"Reviews", selected: selectedTab == 2)
            Tag(tag:"Posts", selected: selectedTab == 3)
            Spacer()

        }
        .padding(.horizontal)
    }
}

struct PopularLists: View {
    var popularLists: [List]
    @Binding var showList: Bool
    @Binding var selectedList: List
    
    var body: some View {
        VStack {
            
            ListGrid(showList: $showList, selectedList: $selectedList, lists: popularLists, inExplore: true)
        }
    }
}

struct PopularPosts: View {
    var popularPosts: [Note]
    @Binding var showBook: Bool
    @Binding var selectedBook: Book
    @Binding var showPost: Bool
    @Binding var selectedPost: Note
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @Binding var postActions: Bool
    @Binding var isLiked: Bool
    
    var body: some View {
        VStack{
            

            ForEach(popularPosts) { note in
                PublicNotePreview(note: note, showNote: $showPost, selectedNote: $selectedPost, showBook: $showBook, selectedBook: $selectedBook, showPostActions: $postActions, showProfile: $showProfile, selectedProfile: $selectedProfile, showCover: true, pub: true)
                    .foregroundColor(.black)
                    
            }
        }
        
    }
}

struct PopularReviews: View {
    var popularReviews: [Review]
    @Binding var showBook: Bool
    @Binding var selectedBook: Book
    @Binding var showReview: Bool
    @Binding var selectedReview: Review
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    
    
    var body: some View {
        VStack {
            

            ForEach(popularReviews) { review in
                ReviewPreview(review: review, showBook: $showBook, selectedBook: $selectedBook, showReview: $showReview, selectedReview: $selectedReview, showProfile: $showProfile, selectedProfile: $selectedProfile)
                
            }
        }
        
    }
}


struct iPadExploreGrid: View {
    @State private var showPopover = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var library: Library
    @EnvironmentObject var allBooks: Library
    @Binding var longPress: Bool
    @State var isTapped = false
    @State var bookWidth = 0.0
    @Binding var selectedBook: Book
    @Binding var showBook: Bool
    @State var iPadOrientation = false
    @State var changeStatus = false
    @EnvironmentObject var lightModeController: LightModeController
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var showBookIPad = false
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact

        let columns = Array(repeating: GridItem(.flexible(), spacing: iPadOrientation ? 20 : 10, alignment: .top), count: 3)
        //GeometryReader { geometry in
            
            LazyVGrid(columns: columns, spacing: iPadOrientation ? 40 : 25) {
                ForEach(allBooks.library) { book in
                    Button(action: {
                        selectedBook = book
                        showBook = true
                    }) {
                        VStack() {
                            Image(book.cover)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: iPadOrientation ? UIScreen.main.bounds.width / 3.69 : UIScreen.main.bounds.width / 3.4)
                                .clipped() // This will clip the overflow
                                .cornerRadius(iPadOrientation ? 14 : 8)
                                .shadow(radius: 0.6)
                            
                                .onTapGesture {
                                    selectedBook = book
                                    showBook = true
                                }
                            
                                .onLongPressGesture(minimumDuration: 0.6){
                                    // bookWidth = 20.0
                                    selectedBook = book
                                    longPress = true
                                }
                            
                        }
                    }
                    .transaction { transaction in
                        transaction.disablesAnimations = true
                    }
                }
            }
            .onChange(of: showBook){
                if iPadOrientation {
                    showBookIPad.toggle()
                }
            }
            .sheet(isPresented: $showBookIPad) {
                ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: .constant(false), fullscreen: false)
                    //.presentationDetents([.fraction(0.99)])

            }
        //}
        
    }
}

struct iPadLandscapeExploreGrid: View {
    @State private var showPopover = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var library: Library
    @EnvironmentObject var allBooks: Library
    @Binding var longPress: Bool
    @State var isTapped = false
    @State var bookWidth = 0.0
    @Binding var selectedBook: Book
    @Binding var showBook: Bool
    @State var iPadOrientation = false
    @State var changeStatus = false

    var body: some View {

        let columns = Array(repeating: GridItem(.flexible(), spacing: 20, alignment: .top), count: 5)
        GeometryReader { geometry in
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(allBooks.library) { book in
                    Button(action: {
                        selectedBook = book
                        showBook = true
                    }) {
                        VStack(alignment: .leading) {
                            Image(book.cover)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width / 6 /*4.7*/ )
                                .clipped() // This will clip the overflow
                                .cornerRadius(5)
                                .shadow(radius: 0.6)
                            
                                .onTapGesture {
                                    selectedBook = book
                                    showBook = true
                                }
                            
                                .onLongPressGesture(minimumDuration: 0.6){
                                    // bookWidth = 20.0
                                    selectedBook = book
                                    longPress = true
                                }
                            
                        }
                        .padding()
                    }
                    .transaction { transaction in
                        transaction.disablesAnimations = true
                    }
                }
            }
            .padding()
            .sheet(isPresented: $showBook) {
                ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: .constant(false), fullscreen: false)
            }
        }
        
    }
}

struct ExploreGrid: View {
    @State private var showPopover = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var allBooks: Library
    @Binding var showMedia : Book
    @Binding var longPress : Bool
    @State var isTapped = false
    @State var bookWidth = 0.0
    @Binding var selectedBook : Book
    @Binding var showBook : Bool
    @Binding var viewModel: ContentViewModel
    var body: some View {

        
        if true {
            let (media, media2) = splitBooksList(allBooks.library)
        
        
       
        
        VStack(alignment: .center) {
            
            ScrollView {
                
                HStack(alignment: .top){
                    LazyVStack(spacing: 20) {
                        ForEach(Array(media.enumerated()), id: \.offset) { index, m in
                            
                            //NavigationLink(destination: ContentView( media: m), isActive: $isTapped){
                                
                                Button(action: {
                                    selectedBook = m
                                    showBook = true
                                    
                                }){
                                VStack(alignment: .leading) {
                                    Image(m.cover)                                   .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: (UIScreen.main.bounds.height) / 4.82)
                                        .clipped() // This will clip the overflow
                                        .cornerRadius(5)
                                        .onTapGesture {
                                            selectedBook = m
                                            showBook = true
                                        }
                                        
                                        .onLongPressGesture(minimumDuration: 1){
                                           // bookWidth = 20.0
                                            showMedia = m
                                            longPress = true
                                        }
                                        
                               
                                    Text(m.title)
                                        .font(.system(size: 14, weight: .medium))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                        .padding(.top, 3)
                                        .padding(.bottom, 2)
                                        .lineLimit(1)
                                        .onTapGesture {
                                            selectedBook = m
                                            showBook = true
                                        }
                                        .onLongPressGesture(minimumDuration: 1){
                                           // bookWidth = 20.0
                                            showMedia = m
                                            longPress = true
                                        }

                                    Text(m.author.name)
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                        .padding(.bottom, 4)
                                        .onTapGesture {
                                            selectedBook = m
                                            showBook = true
                                        }
                                        .onLongPressGesture(minimumDuration: 1){
                                           // bookWidth = 20.0
                                            showMedia = m
                                            longPress = true
                                        }
                                    
                                    Text(m.synopsis)
                                        .font(.system(size: 12.5, weight: .regular))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                        .padding(.top, 3)
                                        .padding(.bottom, 2)
                                        .lineLimit(4)
                                        .onTapGesture {
                                            selectedBook = m
                                            showBook = true
                                        }
                                        .onLongPressGesture(minimumDuration: 1){
                                           // bookWidth = 20.0
                                            showMedia = m
                                            longPress = true
                                        }
                                
                                    
                                    

                                    
                                }
                                
                            }
                            .transaction({ transaction in
                                transaction.disablesAnimations = true
                            })
                            
                            
                        }
                        
                    }
                    Spacer()
                    LazyVStack(spacing: 20) {
                        ForEach(Array(media2.enumerated()), id: \.offset) { index, m in
                            
                            Button(action: {
                  
                                
                            }){
                                VStack(alignment: .leading) {
                                    Image(m.cover)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: (UIScreen.main.bounds.height) / 4.82)
                                        .clipped() // This will clip the overflow
                                        .cornerRadius(5)
                                        .onTapGesture {
                                            selectedBook = m
                                            showBook = true
                                        }
                                        
                                        .onLongPressGesture(minimumDuration: 1){
                                           // bookWidth = 20.0
                                            showMedia = m
                                            longPress = true
                                        }
                                        
                                    Text(m.title)
                                        .font(.system(size: 14, weight: .medium))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                        .padding(.top, 3)
                                        .padding(.bottom, 2)
                                        .onTapGesture {
                                            selectedBook = m
                                            showBook = true
                                        }
                                        
                                        .onLongPressGesture(minimumDuration: 1){
                                           // bookWidth = 20.0
                                            showMedia = m
                                            longPress = true
                                        }
                        

                                
                                        
                                    Text(m.author.name)
                                            .font(.system(size: 12))
                                            .foregroundColor(.black)
                                            .padding(.bottom, 4)
 
                                    Text(m.synopsis)
                                        .font(.system(size: 12.5, weight: .regular))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                        .padding(.top, 3)
                                        .padding(.bottom, 2)
                                        .lineLimit(4)
                                        .onTapGesture {
                                            selectedBook = m
                                            showBook = true
                                            viewModel = ContentViewModel(book: selectedBook)
                                            
                                        }
                                        .onLongPressGesture(minimumDuration: 1){
                                           // bookWidth = 20.0
                                            showMedia = m
                                            longPress = true
                                        }
                             
                                   

                                }
                               
                            }
                            
                            
                            
                        }
                        
                    }
                    
                }
                .padding(.top, 4)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 30)
            }
            
        }
        

        }
        
    }
    
    private func splitBooksList(_ books: [Book]) -> ([Book], [Book]) {
        var firstList: [Book] = []
        var secondList: [Book] = []

        for (index, book) in books.enumerated() {
            if index % 2 == 0 {
                firstList.append(book) // Add to the first list if index is even
            } else {
                secondList.append(book) // Add to the second list if index is odd
            }
        }
        
        return (firstList, secondList)
    }
    
}


struct TopInfo: View {
    @State var book : Book
    @Binding var fadeAndMoveUp : Bool
    
    var body: some View {
        VStack {
            Text("AUTHOR")
                .multilineTextAlignment(.center)
                .font(.system(size:10.5, weight:.medium))
                .opacity(0.5)
                .padding(.bottom, 2)
            
            Text("\(book.author.name)")
                .padding(.leading, -2)
                .font(.system(size:13.5, weight:.medium))
            
                .multilineTextAlignment(.center)
            //.textCase(.uppercase)
            
        
        //.opacity(0.6)
    
    
    Spacer()
    
    Divider()
        .padding(.horizontal, 2)
    
    Spacer()
    
    VStack {
        Text("READERS")
            .multilineTextAlignment(.center)
            .font(.system(size:10.5, weight:.medium))
            .opacity(0.5)
            .padding(.bottom, 2)
        
        Text(formatLargeNumber(book.readers))
        //Text("\(media.readers)")
        //.opacity(0.8)
        
        //.opacity(0.6)
    }
    
    
    Spacer()
    
    Divider()
        .padding(.horizontal, 2)
    
    
    Spacer()
    
    VStack {
        Text("RATING")
            .multilineTextAlignment(.center)
            .font(.system(size:10.5, weight:.medium))
            .opacity(0.5)
            .padding(.bottom, 2)
        
        HStack {
            Button(action: {
                withAnimation {
                    // This is where the scrolling action is triggered
                    
                }
            }) {
                Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.orange)
                    .opacity(1)
                    .padding(.leading, -5)
                Text("4.5")
                    .padding(.leading, -5)
                    .foregroundColor(.black)
                // Your additional styles here
            }
        }
        //ReviewStars(num: 4.5)
    }
    .foregroundColor(.black)
        
    
    Spacer()
    
            Divider()
                .padding(.horizontal, 2)
            
            Spacer()
            
            //GenreTag(book: book)
            Spacer()
            
            
            /*
    Divider()
        .padding(.horizontal, 2)
    
    
    Spacer()
            Button(action: {}){
                
                
      VStack {
            Text("DISCUSSION")
                .multilineTextAlignment(.center)
                .font(.system(size:10.5, weight:.medium))
                .opacity(0.5)
                .padding(.bottom, 6)
            
            HStack {
                
                Image(systemName: "message")
                //.opacity(0.8)
                    .font(.system(size: 10, weight: .bold))
                
                if book.discussion.posts.count == 0 {
                  

                    
                } else {
                    Text("\(book.discussion.posts.count)")
                        .padding(.leading, -5)
                }
                
            }
        }*/
        
    
    
    
}
.opacity(fadeAndMoveUp ? 1 : 0) // Start fully transparent
.offset(x: fadeAndMoveUp ? 0 : 40) // Start 40 pixels below
.foregroundColor(.black)
.padding(.top)
.font(.system(size:13.5, weight:.medium))
.padding(.bottom, 3)
.padding(.bottom, 3)
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




struct MoreLikeThis: View {
    @EnvironmentObject var userData: UserData
    @State var media: Book
    @State var isPresenting = true
    var body: some View {

        
            VStack(alignment: .leading){
                
         
               
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            Text("More Like This")
                                .font(.system(size: 13, weight: .medium))
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.black).opacity(0))
                            
                        }
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color(.black).opacity(0.05))
                                    .frame(height: 44)
                            
                            
                            )
                    
                    //.background(Color(.black).opacity(0.05))
                
            
                
                
            }
            .padding()
        
    }
}

