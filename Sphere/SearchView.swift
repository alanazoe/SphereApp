//
//  SearchView.swift
//  media discussion
//
//  Created by Alana Greenaway on 1/31/24.
//

import SwiftUI

enum SearchMode : Int {
    case library = 0
    case all = 1
}

/*
struct SearchView: View {
    @EnvironmentObject var userData : UserData
    @EnvironmentObject var allBooks: Library

    @State var searchText = ""
    @State private var searchHistory = ["History 1", "History 2", "History 3"] // Example search history
    @State private var searched = false
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var searchMode : SearchMode
    @Binding var isPresenting : Bool
    @State var xoffset = 0.0
    //Color(hex: "#F1EFE9")
    @State var showList = false
    @State var selectedList = List(id: UUID(), title: "", books: [])
    @State private var selectedIndex = 0 {
            didSet {
                searchMode = SearchMode(rawValue: selectedIndex) ?? .library
            }
        }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    HStack() {
                        Button(action: {isPresenting.toggle()}){
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                        }
                        .transaction({ transaction in
                            transaction.disablesAnimations = true
                        })
                        Spacer()
                        
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    VStack {
                        if searchMode == .library {
                            HStack(alignment: .center) {
                                Button(action: { searchMode = .library }){
                                    Text("Your Library")
                                        .foregroundColor(.black)
                                        .font(.system(size: 15, weight: .medium))
                                }
                                .padding(.trailing)
                                
                                Button(action: { searchMode = .all }){
                                    Text("All Books")
                                        .foregroundColor(.black)
                                        .font(.system(size: 15))
                                }
                                
                            }
                            .padding(.trailing)
                            
                        } else if searchMode == .all {
                            HStack(alignment: .center) {
                                Button(action: { searchMode = .library }){
                                    Text("Your Library")
                                        .foregroundColor(.black)
                                        .font(.system(size: 15))
                                }
                                .padding(.trailing)
                                
                                
                                Button(action: { searchMode = .all }){
                                    Text("All Books")
                                        .foregroundColor(.black)
                                        .font(.system(size: 15, weight: .medium))
                                }
                                
                            }
                            .padding(.trailing)
                            
                        }
                    }
                    .padding(.top, 40)
                    .padding(.bottom)
                    VStack {
                        if searchMode == .library {
                            
                            
                            HStack {
                                SearchBar(searchText: $searchText, searched: $searched)
                                    .padding(.bottom)
                                
                                
                            }
                            .padding(.top)
                            
                            
                        } else {
                            HStack {
                                
                                SearchBar(searchText: $searchText, searched: $searched, placeholder: "Search Sphere")
                                    .padding(.bottom)
                            }
                            .padding(.top)
                            
                            
                            
                        }
                        
                        
                    
                        if searchMode == .library {
                            if searchText != "" {
                                ListSearchResults(searchText: $searchText, books: userData.user.currentReads.books + userData.user.pastReads.books + userData.user.readingList.books, searched: $searched, showEReader: $showEReader, showEReader: $showEReader)
                            }
                        } else if searchMode == .all {
                            if searchText != "" {
                                
                                ListSearchResults(searchText: $searchText, books: allBooks.library, searched: $searched)
                            }
                        }
                        
                        
                        
                        Spacer()
                    }
                    
                }
                .background(backgroundColor)
                
                if showList {
                    ListView(isPresenting: $showList, list: $selectedList, user: userData.user)
                }
                
            }
            
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
        .onChange(of: searchMode) { newMode in
             selectedIndex = newMode.rawValue
        }
        .overlay(
            VStack {
                var lists = [userData.user.currentReads, userData.user.pastReads, userData.user.readingList]  // + userData.user.lists

                if searchText == "" {
                    
                        TabView(selection: $searchMode) {
                            ListGrid(showList: $showList, selectedList: $selectedList, lists: lists)
                            // add  + userData.user.lists
                                .tag(SearchMode.library) // Use enum cases for tagging
                            CategoryGrid()
                                .tag(SearchMode.all)
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: searchMode == .library ? CGFloat(lists.count) / 2 * 190 : 6 * 190, alignment: .top)

                }
                
                
            }
            
                .offset(x: xoffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width > 0 && searchMode == .library {
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
                .padding(.top, 80)
        
        )
        .animation(.easeOut, value: xoffset) // Animate the return movement

    }
}
 */
/*
struct myTabView: View {
    @State var views : [any View]
    @Binding var selectedIndex : Int
    @State var offset = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top){
                ForEach(views, id\.self) { view in
                    // display the view
                    
                }
                
            }
        }
        .ignoresSafeArea()
        .offset(x: offset * CGFloat(selectedIndex))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.translation.width > 0 && searchMode == .library {
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
        .animation(.easeOut, value: offset)
        .frame(height: )

    }
}
*/

struct ListGrid: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    @EnvironmentObject var userData: UserData
    @Binding var showList: Bool
    @Binding var selectedList: List
    @State var lists: [List]
    var inExplore = false
    
    var body: some View {
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(lists, id: \.self) { list in
                    
                    if list.books.count > 0 {
                        Button(action: {
                            selectedList = list
                            showList.toggle()
                        }){
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(list.title)
                                        .font(.system(size: 15, weight: .medium))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                        .padding(.top)
                                    Spacer()
                                    Text("\(list.books.count) books")
                                        .font(.system(size: 12))
                                        .padding(.top)
                                }
                                .padding(.horizontal)
                                
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(list.books) { book in
                                            Image(book.cover)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 120)
                                                .clipShape(RoundedRectangle(cornerRadius: 2))
                                                .shadow(radius: 0.5)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .scrollIndicators(.hidden)
                                
                                Text(list.description)
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 12.5))
                                    .lineLimit(5)
                                    .padding(.horizontal)
                                    .padding(.top, 3)
                                    .lineSpacing(3)
                                
                                //HStack{
                                
                                // ProfileThumbnail(image: list.user.image, size: 30)
                                //Text(list.user.name)
                                // Spacer()
                                
                                //}
                                
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
                
                
                
            }
            
        
    }
}

struct ListPreview: View {
    @State var list: List
    @Binding var showList: Bool
    @Binding var selectedList: List
    
    var body: some View {
            Button(action: {
                selectedList = list
                showList.toggle()
            }){
                VStack(alignment: .leading) {
                    HStack {
                        Text(list.title)
                            .font(.system(size: 15, weight: .medium))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .padding(.top)
                        Spacer()
                        Text("\(list.books.count) books")
                            .font(.system(size: 12))
                            .padding(.top)
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(list.books) { book in
                                Image(book.cover)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 2))
                                    .shadow(radius: 0.5)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .scrollIndicators(.hidden)
                    
                    Text(list.description)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 12.5))
                        .lineLimit(5)
                        .padding(.horizontal)
                        .padding(.top, 3)
                        .lineSpacing(3)
                    
                    //HStack{
                    
                    // ProfileThumbnail(image: list.user.image, size: 30)
                    //Text(list.user.name)
                    // Spacer()
                    
                    //}
                    
                }
                .foregroundColor(.black)
            }
        
    }
}


struct ListView : View {
    @Binding var isPresenting : Bool
    @Binding var list : List
    @State var xoffset = 0.0
    @ObservedObject var user : User
    @State var showBook = false
    @State var selectedBook = Book()
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var userData: UserData
    @State var isLiked = false
    @State var contentViewModel = ContentViewModel(book: Book())
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    /*

                    HStack{
                        Image(systemName: "arrow.left")
                            .font(.system(size: 16, weight: .medium))

                        Spacer()
                    }
                    .padding(.leading)*/
                    VStack(alignment: .leading){
                        
                        
                        HStack {
                            Spacer()
                            Text(list.title)
                                .padding(.top, 20)
                                .padding(.horizontal)
                                .padding(.bottom)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                .font(.custom("EBGaramondRoman-SemiBold", size: 20))

                                //.font(.system(size: 18, weight: .medium))
                                .lineLimit(3)
                                .padding(.bottom)
                            Spacer()
                        }
                        Text(list.description)
                        .multilineTextAlignment(.leading)
                        .font(.system(size:15))
                        .lineLimit(3)
                        .lineSpacing(4)
            

                        
                        
                        
                    }
                    .padding()
                    .padding(.horizontal)
                    HStack {
                            ProfileThumbnail(image: userData.user.photo, size: 20)
                            Text(user.name)
                            .font(.system(size: 14))
                        
                        
                        Spacer()


                        Text("0/\(list.books.count) read")
                            .font(.system(size: 13.5))
                            .padding(.horizontal)
                        Text("32 likes")
                            .font(.system(size: 13.5))
                            .padding(.trailing)
                        if !isLiked {
                            Button(action: {
                                isLiked.toggle()
                                //post.likes += 1
                                
                            }){
                                Image(systemName: "heart")
                                    .font(.system(size: 19))
                                    .foregroundColor(.black)
                            }
                        } else {
                            Button(action: {
                                isLiked.toggle()
                                //post.likes -= 1

                            }){
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 19))
                                    .foregroundColor(.pink)
                            }
                        }
                        
                    }
                    .padding([.top, .horizontal])
                    .padding(.horizontal)
                   
                        iPadListGrid(listBooks: list.books, longPress: .constant(false), selectedBook: $selectedBook, showBook: $showBook)
                    }
                    
                    
                
            }
            .padding(.top)
            .background(backgroundColor)
            
            if showBook {
                ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: .constant(true))
            }
            /*
            VStack{
                Spacer()
                Button(action:{ }){
                    
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 120, height: 38)
                        .foregroundColor(.black)
                        .overlay(
                            Text("40 comments")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white)
                        )
                        
                }
            }
            .padding(.bottom, 100)*/

        }
// Animate the return movement
    }
}

struct iPadListGrid: View {
    @State private var showPopover = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var library: Library
    @EnvironmentObject var allBooks: Library
    @State var listBooks: [Book]
    @Binding var longPress : Bool
    @State var isTapped = false
    @State var bookWidth = 0.0
    @Binding var selectedBook : Book
    @Binding var showBook : Bool
    @State var iPadOrientation = false
    @State var changeStatus = false
    var body: some View {
        
        let columns = Array(repeating: GridItem(.flexible(), spacing: 20, alignment: .top), count: 3)
        GeometryReader { geometry in
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(listBooks) { book in
                    Button(action: {
                        selectedBook = book
                        showBook = true
                    }) {
                        VStack(alignment: .leading) {
                            Image(book.cover)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width / 3.6 /*4.7*/ )
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
                        .padding(.horizontal)
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
    
    private func splitBooksList(_ books: [Book]) -> ([Book], [Book], [Book]) {
        var firstList: [Book] = []
        var secondList: [Book] = []
        var thirdList: [Book] = []

        for (index, book) in books.enumerated() {
            switch index % 3 {
            case 0:
                firstList.append(book) // Add to the first list if index % 3 == 0
            case 1:
                secondList.append(book) // Add to the second list if index % 3 == 1
            default:
                thirdList.append(book) // Add to the third list if index % 3 == 2
            }
        }
        
        return (firstList, secondList, thirdList)
    }
    
}

struct CategoryGrid: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    // The tags based on the image provided
    let tags = [
        "Sphere Originals",
        "Editor's Picks",
        "Adventure",
        "Contemporary Lit",
        "Diverse Lit",
        "Fantasy",
        "Historical Fiction",
        "Horror",
        "Humor",
        "Mystery",
        "New Adult"
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(tags, id: \.self) { tag in
                    Button(action: {
                        // Handle button tap
                    }) {
                        Text(tag)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue.opacity(0.1)))
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
        }
    }
}

struct SearchBar: View {
    @State var searchText = ""
    @State  var searched = false
    @State var placeholder = "Search your library"
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks : Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    //@Binding var showEReader : Bool
    @State var showList = false
    @State var selectedList = List(id: UUID(), title: "", books: [])
    @EnvironmentObject var userData : UserData
    //@Binding var isPresenting : Bool
    @State var xoffset = 0.0
    //@Binding var showToolbar: Bool
    @State var database: [Book]
    @Binding var showToolbar: Bool
    var body: some View {
        
        
        VStack {
            HStack {
              
                
                TextField(placeholder, text: $searchText)
                    .onTapGesture {
                        // When the TextField is tapped, set isTextFieldFocused to true
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
                    .onChange(of: searchText){
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
                    .background(Color(.black).opacity(0.05))
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
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .padding(.trailing)
                }
            }
            Spacer()
            
            if searchText == "" && !isTextFieldFocused && !isGenre {
                var lists = [userData.user.currentReads, userData.user.pastReads, userData.user.readingList] +  userData.user.lists
                VStack {
                    ListGrid(showList: $showList, selectedList: $selectedList, lists: lists)
                    Spacer()
                }
                .background(backgroundColor)
            }
            
           // var userLibrary = userData.user.currentReads.books + userData.user.pastReads.books + userData.user.readingList.books

            if searchText != "" && !isGenre  {
                
                ListSearchResults(searchText: $searchText, books: database, searched: $searched, showToolbar: $showToolbar)
                
            }
            
            if searchText != "" && isGenre && searched  {
                
                //ListGenreSearchResults(searchText: $searchText, books: database, searched: $searched)
                
            }
            
        
            
        }
        .background(backgroundColor)
        /*
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
         */
        
    }
}
struct SelectBookBar: View {
    @State var searchText = ""
    @State var searched = false
    @State var placeholder = "Search your library"
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks: Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    @State var showList = false
    @State var selectedList = List(id: UUID(), title: "", books: [])
    @EnvironmentObject var userData: UserData
    @State var xoffset = 0.0
    @State var database: [Book]
    @Binding var selectedBook: Book?

    

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
                    SingleSelectionGrid(searchText: $searchText, books: database, selectedBook: $selectedBook)
                .padding(.top)

             //   }
            
        }
        .background(backgroundColor)
    }
}


struct SearchSelectBooksBar: View {
    @State var searchText = ""
    @State var searched = false
    @State var placeholder = "Search your library"
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks: Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    @State var showList = false
    @State var selectedList = List(id: UUID(), title: "", books: [])
    @EnvironmentObject var userData: UserData
    @State var xoffset = 0.0
    @State var database: [Book]
    @Binding var selectedBooks: [Book]

    

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

            if searchText != "" {
                ScrollView {
                    SelectionGrid(searchText: $searchText, books: database, selectedBooks: $selectedBooks)
                }
                .padding(.top)
            }
        }
        .background(backgroundColor)
    }
}

struct GenericSearchBar: View {
    @Binding var searchText : String
    @Binding  var searched : Bool
    @State var placeholder: String
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks : Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    @EnvironmentObject var lightModeController: LightModeController
    @EnvironmentObject var navigation: Nav

    var body: some View {
        
        
        VStack {
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
                        isGenre = false
                        
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
                    .cornerRadius(40)
                    //.padding(3)
                    //.padding(searchText != "" ? .leading : .horizontal)

                
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
                    //.padding(.trailing)
                    
                }
            }
           
            .onAppear{
                navigation.hideToolbar()

            }
            .onDisappear{
                navigation.showToolbarTrue()

            }
            
            
            /*  if searchText == "" && isTextFieldFocused {
                VStack {
                    //SEARCH SUGGESTIONS
                    Spacer()
                }
                .background(backgroundColor)
               
                
            }
            if searchText != "" && !isGenre  {
                
                //SEARCH RESULTS
                
            }
            
    
            */
        
            
    }
        
    }
}


struct SearchBar2: View {
    @Binding var searchText : String
    @Binding  var searched : Bool
    @State var placeholder = "Search titles, authors, tropes..."
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks : Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    @Binding var showEReader : Bool
    @Binding var showToolbar: Bool
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        
        
        VStack {
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
                        isGenre = false
                        
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
                    .cornerRadius(40)
                    //.padding(3)
                    //.padding(searchText != "" ? .leading : .horizontal)

                
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
                    //.padding(.trailing)
                }
            }
            Spacer()
            
            if searchText == "" && isTextFieldFocused && !isGenre {
                VStack {
                    ListSearchSuggestions(searchText: $searchText, searched: $searched, isGenre: $isGenre)
                    Spacer()
                }
                .background(backgroundColor)
                .onAppear{
                    showToolbar = false
                }
                .onDisappear{
                    showToolbar = true
                }
            }
            if searchText != "" && !isGenre  {
                
                ListSearchResults(searchText: $searchText, books: allBooks.library, searched: $searched, showToolbar: $showToolbar)
                
            }
            
            if searchText != "" && isGenre && searched  {
                
                //ListGenreSearchResults(searchText: $searchText, books: allBooks.library, searched: $searched)
                
            }
            
        
            
    }
        
    }
}

// example: searching [book] chapter [3]
struct SearchPosts: View {
    @Binding var searchText : String
    @Binding  var searched : Bool
    @State var placeholder = "Search posts & reviews..."
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks : Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    @Binding var showEReader : Bool
    @Binding var showToolbar: Bool
    var body: some View {
        
        
        VStack {
            HStack {
                TextField(placeholder, text: $searchText)
                    .onTapGesture {
                        // When the TextField is tapped, set isTextFieldFocused to true
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
                    .onChange(of: searchText){
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
                    .background(Color(.black).opacity(0.05))
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
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .padding(.trailing)
                }
            }
            Spacer()
            
            if searchText == "" && isTextFieldFocused && !isGenre {
                VStack {
                    Text("Post Search suggestions here")
                    //ListSearchSuggestions(searchText: $searchText, searched: $searched, isGenre: $isGenre)
                    Spacer()
                }
                .background(backgroundColor)
            }
            if searchText != "" && !isGenre  {
                
                Text("list post search results here")
                //  ListSearchResults(searchText: $searchText, books: allBooks.library, searched: $searched)
                
            }
            
            
        
            
    }
    }
}

struct SearchLists: View {
    @Binding var searchText : String
    @Binding  var searched : Bool
    @State var placeholder = "Search lists..."
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks : Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    @Binding var showEReader : Bool
    @Binding var showToolbar: Bool
    var body: some View {
        
        
        VStack {
            HStack {
                TextField(placeholder, text: $searchText)
                    .onTapGesture {
                        // When the TextField is tapped, set isTextFieldFocused to true
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
                    .onChange(of: searchText){
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
                    .background(Color(.black).opacity(0.05))
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
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .padding(.trailing)
                }
            }
            Spacer()
            
            if searchText == "" && isTextFieldFocused && !isGenre {
                VStack {
                    Text("Post Search suggestions here")
                    //ListSearchSuggestions(searchText: $searchText, searched: $searched, isGenre: $isGenre)
                    Spacer()
                }
                .background(backgroundColor)
            }
            if searchText != "" && !isGenre  {
                
                Text("list post search results here")
                //  ListSearchResults(searchText: $searchText, books: allBooks.library, searched: $searched)
                
            }
            
            
        
            
    }
    }
}

struct ListSearchSuggestions: View {
    @Binding var searchText : String
    @Binding  var searched : Bool
    //@State var placeholder = "Search your library"
    @Binding var isGenre : Bool
    var body: some View {
        
        
                
                
                ScrollView {
                    VStack(alignment: .leading) {
                    Text("Categories")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                    
                    ForEach(Genre.allCases) { genre in
                        Button(action: {
                            
                            isGenre = true
                            searchText = genre.rawValue
                            
                            
                        }){
                            Text(genre.rawValue)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.black)
                            
                        }
                        Divider()
                            .padding(.vertical, 2)
                        
                    }
                }
                    
                Spacer()

            }
            .padding(.horizontal)
        
    }
}


struct ListSearchResults2: View {
    @Binding var searchText : String// Consider this as user input that changes
    @State var books: [Book] // Your books array
    @Binding var showBook: Bool
    @Binding var selectedBook: Book
    @Binding var searched : Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var lightModeController: LightModeController

    private var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter { book in
                book.title.localizedCaseInsensitiveContains(searchText) || book.author.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {

        ScrollView {
            
            if filteredBooks.count < 1 {
                
                Text("no results for \(searchText)")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .padding(.top, 2)
                    .padding(.bottom)
                
            }
            HStack(alignment: .top) {
                
                LazyVStack(alignment: .leading, spacing: 20) {
                    
                    ForEach(Array(filteredBooks.enumerated()), id: \.offset) { index, m in
                            HStack {
                                
                                Image(m.cover)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                                    .clipped()
                                    .cornerRadius(3)
                                
                                VStack(alignment: .leading) {
                                    
                                    BookTitleText(text: m.title, size: 16)
                                    BodyText(text: "\(m.author.name)", size: 15)
                                        
                                    
                                }
                                .padding(.leading, 4)
                                Spacer()
                                Image(systemName: "ellipsis")
                                
                            }
                            .padding(.vertical, 1)
                            .onTapGesture {
                                showBook.toggle()
                                selectedBook = m
                            }
                        
                    }
                }
                .padding(.top, 12)
            }
            .padding(.horizontal)
        }
        
        .background(lightModeController.getBackgroundColor())
        .foregroundColor(lightModeController.getForegroundColor())

    }
}

struct MiniBookPreview2: View {
    @State var book: Book
    @Binding var showBook: Bool
    @Binding var selectedBook: Book
    
    var body: some View {
        HStack {
            
            Image(book.cover)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
                .clipped()
                .cornerRadius(3)
            
            VStack(alignment: .leading) {
                
                BookTitleText(text: book.title, size: 16)
                BodyText(text: "\(book.author.name)", size: 15)
                    
                
            }
            .padding(.leading, 4)
            Spacer()
            Image(systemName: "ellipsis")
            
        }
        .padding(.vertical, 1)
        .onTapGesture {
            showBook.toggle()
            selectedBook = book
        }
    }
}

struct ListSearchResults: View {
    @Binding var searchText : String// Consider this as user input that changes
    @State var books: [Book] // Your books array
    @State var showBook = true
    @Binding var searched : Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var showEReader = false
    // Computed property to filter books based on searchText
    @Binding var showToolbar: Bool
    private var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter { book in
                book.title.localizedCaseInsensitiveContains(searchText) || book.author.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        

            
        ScrollView {
            
            if filteredBooks.count < 1 {
                Text("no results for \(searchText)")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .padding(.top, 2)
                    .padding(.bottom)
            }
            HStack(alignment: .top) {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(filteredBooks.enumerated()), id: \.offset) { index, m in
                        NavigationLink(destination: ContentView(book:  .constant(filteredBooks[index]), isPresenting: $showBook, showToolbar: $showToolbar)) {
                            HStack {
                                Image(m.cover)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: searched ? (UIScreen.main.bounds.height) / 9 : (UIScreen.main.bounds.height) / 18)
                                    .clipped()
                                    .cornerRadius(3)
                                VStack(alignment: .leading) {
                                    Text(m.title)
                                        .font(.system(size: 17, weight: .medium))
                                        .foregroundColor(.black)
                                    Text("\(m.author.name)")
                                        .font(.system(size: 15))
                                        .foregroundColor(.black)
                                        .padding(.top, 2)
                                        .padding(.bottom)
                                    
                                    
                                    
                                    
                                    
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 12))
                                            .foregroundColor(.orange)
                                            .opacity(1)
                                        
                                        Text("4.5")
                                            .font(.system(size: 13))
                                            .padding(.leading, -5)
                                            .opacity(0.6)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                        .transaction({ transaction in
                            transaction.disablesAnimations = true
                        })
                        .padding(.vertical, 1)
                        //Divider()
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        
        .background(backgroundColor)
    }
}


/*struct ListGenreSearchResults: View {
    @Binding var searchText : String// Consider this as user input that changes
    @State var books: [Book] // Your books array
    @State var showBook = true
    @Binding var searched : Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var showEReader : Bool
    @Binding var showToolbar: Bool
    // Computed property to filter books based on searchText
    private var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter { book in
                book.genre.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        

            
        ScrollView {
            
            Text(searchText)
            
            if filteredBooks.count < 1 {
                Text("no GENRE results for \(searchText)")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .padding(.top, 2)
                    .padding(.bottom)
            }
            HStack(alignment: .top) {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(filteredBooks.enumerated()), id: \.offset) { index, m in
                        NavigationLink(destination: ContentView(book: .constant(filteredBooks[index]), isPresenting: $showBook, showToolbar: $showToolbar)) {
                            HStack {
                                Image(m.cover)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: searched ? (UIScreen.main.bounds.height) / 9 : (UIScreen.main.bounds.height) / 18)
                                    .clipped()
                                    .cornerRadius(3)
                                VStack(alignment: .leading) {
                                    Text(m.title)
                                        .font(.system(size: 17, weight: .medium))
                                        .foregroundColor(.black)
                                    Text("\(m.author.name)")
                                        .font(.system(size: 15))
                                        .foregroundColor(.black)
                                        .padding(.top, 2)
                                        .padding(.bottom)
                                    
                                    
                                    
                                    
                                    
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 12))
                                            .foregroundColor(.orange)
                                            .opacity(1)
                                        
                                        Text("4.5")
                                            .font(.system(size: 13))
                                            .padding(.leading, -5)
                                            .opacity(0.6)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                        .transaction({ transaction in
                            transaction.disablesAnimations = true
                        })
                        .padding(.vertical, 1)
                        //Divider()
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        
        .background(backgroundColor)
    }
}
*/

