//
//  LibraryView.swift
//  media discussion
//
//  Created by Alana Greenaway on 1/29/24.
//

import SwiftUI

struct YearInReview: View {
   //@State var year: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14){
           /* Text("Year in Review")
                .padding(.bottom)
                .font(.system(size: 16, weight: .medium))*/

            Text("2024")
                .font(.system(size: 16, weight: .medium))
            ReadingChallenge()

        }
    }
}

struct ToBeReadQueue: View {
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var draggedBook: Book? = nil
    @State var dragOffset: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("To be read")
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                    Image(systemName: "plus")
                }
                .padding(.bottom)

                VStack(alignment: .leading) {
                    ForEach(Array(userData.user.queue.enumerated()), id: \.offset) { index, book in
                        if index == 0 {
                            HStack {
                                Image(book.cover)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading) {
                                        Text(book.title)
                                            .font(.system(size: 15, weight: .medium))
                                        Text(book.author.name)
                                            .font(.system(size: 12))
                                    }
                                    .padding(.leading)
                                }
                                Spacer()
                                Image(systemName: "ellipsis")
                            }
                            .padding(.top)
                            .offset(y: draggedBook == book ? dragOffset : 0)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if draggedBook == nil {
                                            draggedBook = book
                                        }
                                        dragOffset = value.translation.height
                                    }
                                    .onEnded { value in
                                        moveBook(book, by: value.translation.height)
                                        draggedBook = nil
                                        dragOffset = 0
                                    }
                            )
                            /*.onDrag {
                                self.draggedBook = book
                                return NSItemProvider()
                            }
                            .onDrop(of: [.text], delegate: DropViewDelegate(destinationItem: book, books: $userData.user.queue, draggedItem: $draggedBook))*/
                        }
                        if index == 1 {
                            Text("Next")
                                .font(.system(size: 15))
                                .padding(.vertical)
                        }
                        if index > 0 {
                            HStack {
                                Image(book.cover)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.system(size: 15))
                                    Text(book.author.name)
                                        .font(.system(size: 12))
                                }
                                .padding(.leading)
                                Spacer()
                                Image(systemName: "line.3.horizontal")
                                    .font(.system(size: 16))
                            }
                            .background(backgroundColor)
                            .padding(.bottom)
                            .offset(y: draggedBook == book ? dragOffset : 0)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if draggedBook == nil {
                                            draggedBook = book
                                        }
                                        dragOffset = value.translation.height
                                    }
                                    .onEnded { value in
                                        moveBook(book, by: value.translation.height)
                                        draggedBook = nil
                                        dragOffset = 0
                                    }
                            )
                            /*.onDrag {
                                self.draggedBook = book
                                return NSItemProvider()
                            }
                            .onDrop(of: [.text], delegate: DropViewDelegate(destinationItem: book, books: $userData.user.queue, draggedItem: $draggedBook))*/
                        }
                    }
                    .onMove(perform: move)
                }
                .padding(.top)
            }
            .padding()
        }
        .background(backgroundColor)
        .toolbar {
            EditButton()
        }
    }

    private func move(from source: IndexSet, to destination: Int) {
        userData.user.queue.move(fromOffsets: source, toOffset: destination)
    }

    private func moveBook(_ book: Book, by offset: CGFloat) {
        guard let index = userData.user.queue.firstIndex(of: book) else { return }
        let targetIndex = Int((CGFloat(index) + offset / 60).rounded())
        if targetIndex >= 0 && targetIndex < userData.user.queue.count && targetIndex != index {
            userData.user.queue.move(fromOffsets: IndexSet(integer: index), toOffset: targetIndex)
        }
    }
}

struct DropViewDelegate: DropDelegate {
    
    let destinationItem: Book
    @Binding var books: [Book]
    @Binding var draggedItem: Book?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        // Swap Items
        if let draggedItem {
            let fromIndex = books.firstIndex(of: draggedItem)
            if let fromIndex {
                let toIndex = books.firstIndex(of: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation {
                        self.books.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                }
            }
        }
    }
}

struct Navigation: View {
    @Binding var showLibrary: Bool
    @Binding var showLists: Bool
    @Binding var showReviews: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Button(action: {
                showLibrary.toggle()
            }){
                HStack{
                    Image(systemName: "books.vertical")
                    
                    Text("Library")
                    //.underline()
                }
            }
            Button(action: {
                showReviews.toggle()
            }){
                HStack {
                    Image(systemName: "star")
                    
                    Text("Reviews")
                    //.underline()
                }
            }
            HStack {
                Image(systemName: "text.quote")
                Text("Quotes")
                    //.underline()
            }
            Button(action: {
                showLists.toggle()
            }){
                HStack {
                    Image(systemName: "list.number")
                    Text("Lists")
                    //.underline()
                }
            }

            /*Text("Genres")
                .underline()*/

        }
        .font(.system(size: 15))
        .foregroundColor(.black)

    }
}

struct TBRQueue: View {
    @Binding var showQueue: Bool
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        Button(action: {
            showQueue.toggle()
        }){
            VStack(alignment: .leading, spacing: 14){
                Text("To Be Read")
                    .font(.system(size: 16, weight: .medium))
                VStack(alignment: .leading){
                    Text("CURRENT")
                        .font(.system(size: 12))
                        .opacity(0.7)
                    if userData.user.queue.count > 0 {
                        Text(userData.user.queue[0].title)
                            .lineLimit(1)

                    }
                    if userData.user.queue.count > 1 {
                        
                        Text("LATER")
                            .font(.system(size: 12))
                            .opacity(0.7)
                            .padding(.top)
                        Text(userData.user.queue[1].title)
                            .lineLimit(1)

                    }
                    if userData.user.queue.count > 2 {
                        
                        Text(userData.user.queue[2].title)
                            .lineLimit(1)
                    }
                    if userData.user.queue.count > 3 {
                        
                        Text(userData.user.queue[3].title)
                            .lineLimit(1)

                    }
                    
                }
            }
            .font(.system(size: 15))
            .foregroundColor(.black)

        }
        
    }
}

class LightModeController: ObservableObject {
    @Published var darkMode: Bool
    @Published var backgroundColor: Color
    @Published var foregroundColor: Color
    @Published var accentColor: Color
    @Published var buttonColor: Color
    
    init() {
        self.darkMode = false
        self.backgroundColor = Color(hex: "#fffdf4")
        self.foregroundColor = Color(.black)
        self.accentColor = Color(hex: "#171615")
        self.buttonColor = Color(hex: "#302f2e")
    }

    func switchMode(){
        if darkMode {
            backgroundColor = Color(hex: "#fffdf4")
            foregroundColor = Color(.black)
            accentColor = Color(hex: "#171615")
            buttonColor = Color(hex: "#302f2e")
        } else {
            backgroundColor = Color(hex: "#171615")
            foregroundColor = Color(hex: "#efede6")
            accentColor = Color(.black)
            buttonColor = Color(hex: "#fffdf4")

        }
        darkMode.toggle()
    }
    
    func getBackgroundColor()-> Color {
        return backgroundColor
    }
    
    func getForegroundColor()-> Color {
        return foregroundColor
    }
    
    func getAccentColor()-> Color {
        return accentColor
    }
    func isDarkMode()-> Bool {
        return darkMode
    }
    
    func getButtonColor() -> Color {
        return buttonColor
    }
}
struct LibrarySearchView: View {
    @Binding var isPresenting: Bool
    @EnvironmentObject var lightModeController: LightModeController
    @State var searched = false
    @State var searchText = ""
    @EnvironmentObject var userData: UserData
    @State var showBook = false
    @State var selectedBook = Book()

    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Image(systemName: "chevron.left")
                        .onTapGesture {
                            isPresenting.toggle()
                        }
                    GenericSearchBar(searchText: $searchText, searched: $searched, placeholder: "What do you want to read?")
                }
                .padding(.horizontal)
                
                
                
                if searchText != ""  {
                    
                    ListSearchResults2(searchText: $searchText, books: userData.user.getAllBooks(), showBook: $showBook, selectedBook: $selectedBook, searched: $searched)
                    
                } else {
                    Spacer()
                    BookTitleText(text: "Find your next favorite book")
                        .padding(.bottom, 3)
                    
                    BodyText(text: "Search for authors, books, lists, or genres.", size: 15, weight: 0.2)
                        .padding(.bottom)
                    
                    
                    
                    
                    Spacer()
                }
            }
            
            if showBook {
                ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: .constant(true))
            }
            
        }
        .background(lightModeController.getBackgroundColor())
        .foregroundColor(lightModeController.getForegroundColor())
    }
}
struct LibrarySidebar: View {
    @Binding var isPresenting: Bool
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController
    var body: some View {
        ScrollView {
            VStack{
                HStack {
                    Spacer()
                    Button(action: {
                        isPresenting.toggle()
                    }){
                        Image(systemName: "xmark")
                            .font(.system(size: 14))
                            .padding()
                    }
                    
                }
                VStack {
                    /*
                    VStack {
                        ProfileThumbnail(image: userData.user.photo, size: 110)
                        
                        Text(userData.user.handle)
                            .font(.system(size: 20, weight: .medium))
                            .padding(.vertical)
                    }
                    .padding(.vertical)
                    .padding(.top, 40)*/
                    /*
                     HStack(spacing: 40) {
                     HeadingSubheadingText(headingNumber: userData.user.getAllBooks().count, subheading: "BOOKS")
                     HeadingSubheadingText(headingNumber: 5, subheading: "ACHIEVEMENTS")
                     }
                     .padding(.top)
                     */
                    HStack {
                        BodyText(text: "Monthly Reading Goal", size: 14, weight: 0.2)
                        Spacer()
                    }

                    ReadingChallenge()
                    Spacer()
                    //BodyText(text: "Your account", size: 14)
                    VStack(alignment: .leading){
                        

                        VStack(alignment: .leading, spacing: 20){
                           // BodyText(text: "Your activity", size: 14, weight: 0.2)
                             //   .opacity(0.7)
                            SidebarButton(systemImageName: "star", text: "Ratings & Reviews")
                                                        
                            Divider()
                            SidebarButton(systemImageName: "square.and.pencil", text: "Posts")
                            
                            Divider()
                            SidebarButton(systemImageName: "quote.opening",text: "Quotes")
                            
                            Divider()
                            
                            SidebarButton(systemImageName: "bookmark", text: "Saved")
                            
                            Divider()

                            SidebarButton(systemImageName: "message",text: "Comments")
                            
                            SidebarButton(systemImageName: "gear",text: "Settings")
                            
                            Divider()
                        }
                            .padding(.top)
                            .padding(.top)

                            VStack(alignment: .leading, spacing: 20){

                               
                                
                                
                            }
                        

                    }
                    
                }
                .padding(.top, 30)
                
                
            }
        }
        .padding()
        .foregroundColor(lightModeController.getForegroundColor())
        .background(lightModeController.getBackgroundColor())
        .frame(width: UIScreen.main.bounds.width * 0.82)
        
    }
}

struct SidebarButton: View {
    var systemImageName: String
    var text: String
    var body: some View {
        HStack {
            Image(systemName: systemImageName)
                .font(.system(size: 15.5, weight: .medium))
            
            BodyText(text: text, size: 17)
                .padding(.leading, 3)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .opacity(0.5)
                .font(.system(size: 13))
        }
    }
}

struct HeadingSubheadingText: View {
    var headingNumber: Int
    var subheading: String
    var body: some View {
        VStack {
            BodyText(text: formatLargeNumber(headingNumber), size: 20)
            BodyText(text: subheading, size: 10.5)
                .multilineTextAlignment(.center)
                .opacity(0.5)
                .padding(.bottom, 2)
                
            
            
        }
    }
}
struct LibraryView: View {
    @State private var showPopover = false
    @State private var isPresentingProfilePopup = false
    @FocusState private var isInputActive: Bool
    @State private var showSearch = false
    @State private var searchText = ""
    @State private var searchHistory = ["History 1", "History 2", "History 3"]
    @State private var searched = false
    @EnvironmentObject var userData: UserData
    @State var longPress = false
    @State var create = false
    @State var showBook = false
    @State var showBookIPad = false
    @State var showBookIPhone = false

    @State var selectedBook = Book()
    @State var showLibrary = false
    @State var showEReader = false
    @Binding var showToolbar: Bool
    @State var selectedTab = 0
    @State var addBook = false
    @State var showQueue = false
    @State var showLists = false
    @State var showList = false
    @State var selectedList = List()

    @State var showReviews = false
    @State private var isLandscape = false
    @State var showFeedback = false
    @EnvironmentObject var navigation: Nav
    @State var showReader = false
    @State var showMessages = false
    @State var caroView = false
    @EnvironmentObject var lightModeController: LightModeController
    @State var showQuotes = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State var contentOffset = UIScreen.main.bounds.width
    @State var showingBook = false
    @Binding var showSidebar: Bool
    @State var selectedBooks: [Book] = []
    @State var showingBooks: String = "Library"
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            ZStack {
                
                // hidden sidebar behind view
                    HStack {
                        Spacer()
                        LibrarySidebar(isPresenting: $showSidebar)
                    }
                        
                        
                
                VStack {
                    
                    HStack {
                        
                       /*
                        if !lightModeController.isDarkMode(){
                            
                           /* Image("Sphere-Dark-Logo-Text-250px")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: iPadOrientation ? calculateWidth(refWidth: 90) : 82)
                                .padding(.horizontal)
                                .padding(.top)*/


                        } else {
                            Image("Sphere-Light-Logo-Text-250px")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: iPadOrientation ? calculateWidth(refWidth: 90) : 82)
                               .padding(.horizontal)
                               .padding(.top)



                        }
                        */
                        //Text("width: \(UIScreen.main.bounds.width)")
                        //Text("height: \(UIScreen.main.bounds.height)")

                        /*
                        Text("Sphere")
                            .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                            .padding()
                            .font(.custom("Baskerville-SemiBold", size: 25))
                            .opacity(1)
                         */

                        Spacer()
                        

                        if iPadOrientation {
                            
                            Image(systemName: "book.closed")
                                .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                            //.padding()
                                .padding(.trailing, 2)
                                .onTapGesture {
                                    showLists = false
                                    caroView = true
                                    showSearch = false
                                    selectedTab = 0
                                    showQuotes = false
                                    
                                }
                            
                            /*ZStack{
                             Image(systemName: "list.bullet")
                             
                             .foregroundColor(lightModeController.getForegroundColor())
                             
                             
                             }
                             .padding()
                             .padding(.trailing, 2)*/
                            
                                .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                                .onTapGesture {
                                    showLists = true
                                    caroView = false
                                    showSearch = false
                                    showQuotes = false
                                    
                                }
                            
                            MenuIcon()
                                .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                                .contentShape(Rectangle()) // Define the tappable shape
                                .frame(width: 50, height: 50) // Make the tappable area larger
                                .onTapGesture {
                                    caroView = false
                                    selectedTab = 0
                                    showSearch = false
                                    showLists = false
                                    showQuotes = false
                                }
                            
                            Image(systemName: "text.quote")
                            //.padding(.trailing, 2)
                            //.padding()
                                .onTapGesture {
                                    showSearch = false
                                    showLists = false
                                    caroView = false
                                    showQuotes = true
                                    
                                    
                                }
                        } else {
                            // IPhone view
                            MenuIcon()
                                .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                                .onTapGesture {
                                    showSidebar.toggle()
                                }
                        }
                        Image(systemName: "magnifyingglass")
                            .padding(.leading)
                            .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                            .opacity(1)
                            .onTapGesture {
                                selectedTab = 1
                                showSearch = true
                                showLists = false
                                caroView = false
                                showQuotes = false


                            }
                            .background(
                                RoundedRectangle(cornerRadius: 5.0)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(hex: "#291F00").opacity(iPadOrientation ? 0.08 : 0))
                                    .offset(x: showSearch == true ? 0 : showQuotes ? -46 : showLists ? -92 : caroView ? -138 : 0)
                                    .animation(.linear(duration: 0.1))
                            )
                        /*
                        Image(systemName: "ellipsis.message")
                            .foregroundColor(foregroundColor)
                            .padding(.trailing)
                            .opacity(1)
                            .onTapGesture {
                                selectedTab = 3
                                showMessages = true
                            } */
                        /*
                            .background(
                                RoundedRectangle(cornerRadius: 5.0)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(hex: "#291F00").opacity(0.08))
                                    .offset(x: showSearch == true ? 0 : -46)
                                    .animation(.linear(duration: 0.1))
                            )*/
                    }
                    .padding(.horizontal, iPadOrientation ? 5 : 0)
                    .padding(.top, iPadOrientation ? 8 : 0)
                    .padding(.horizontal)
                    .padding([.horizontal, .vertical], iPadOrientation ? 8 : 0)
                    /*
                    ScrollView(.horizontal){
                        HStack(alignment: .center, spacing: 30) {
                            let allLists = userData.user.lists
                            
                            // Static BodyText views with underline
                            /*ZStack {
                                // Rounded rectangle underline
                                RoundedRectangle(cornerRadius: 9)
                                    .fill(lightModeController.getForegroundColor()) // Adjust the color as needed
                                    .frame(height: 6) // Height of the underline
                                    .frame(maxWidth: .infinity)
                                    .offset(y: 15) // Positioning below the text
                                // BodyText for "Reading"
                                BodyText(text: "Reading", size: 16, weight: 0.2)
                            }
                            
                            BodyText(text: "To Be Read", size: 16, weight: 0.2)
                            */
                            
                            StatusView(status: .current)
                            StatusView(status: .tbr)

                            // Ensure allLists contains identifiable items
                            ForEach(allLists, id: \.id) { list in
                                BodyText(text: list.title, size: 16, weight: 0.2)
                            }
                        }
                    }
                    .padding(.horizontal, iPadOrientation ? 5 : 0)
                    .padding(.horizontal)
                    .padding([.horizontal], iPadOrientation ? 8 : 0)
                    .padding(.top)*/
                    HStack{
                        
                        Button(action: {
                            showLists.toggle()
                        }){
                            HStack {
                                BodyText(text: showingBooks, size: 16, weight: 0.2)
                                    .foregroundColor(lightModeController.getForegroundColor())
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(lightModeController.getForegroundColor())
                                    .font(.system(size: 15))
                                    .padding(.leading, -4)
                                
                                
                            }
                            .padding(.horizontal, 9)
                            .padding(.vertical, 11)
                            .background(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                                    .fill(lightModeController.isDarkMode() ? lightModeController.getForegroundColor().opacity(0.05) : Color(hex: "#fffffc").opacity(0.7))
                                //.shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                                
                                
                            )
                        }
                        Spacer()
                        
                    }
                        .padding(.horizontal, iPadOrientation ? 5 : 0)
                        .padding(.horizontal)
                        .padding([.horizontal], iPadOrientation ? 8 : 0)
                        .padding(.top)
                        
                    
                    TabView(selection: $selectedTab) {
                        VStack {
                            HStack(alignment: .top) {
                                /*
                                VStack(alignment: .leading) {
                                    Navigation(showLibrary: $showLibrary, showLists: $showLists, showReviews: $showReviews)
                                        .padding(.bottom)
                                    Spacer()
                                    YearInReview()
                                        .padding(.vertical)

                                    TBRQueue(showQueue: $showQueue)
                                        .padding(.top)
                                        .padding(.top)
                                        .padding(.bottom, 70)
                                                 
                                        
                                }
                                .padding()
                                .padding(.top)
                                .padding(.leading, 5)
                                .padding(.leading)
                                .frame(width: UIScreen.main.bounds.width * 0.2)*/
                                /*if showLists {
                                    ScrollView{
                                        HStack{
                                            Text("Lists")
                                                .font(.system(size: 20, weight: .medium))
                                                .padding(.vertical)
                                                .padding(.top, 30)
                                            Spacer()
                                        }
                                        .frame(width: 720)
                                        AllLists(showList: $showList, selectedList: $selectedList)
                                            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                                    }
                                    
                                } else */
                                
                                if caroView {
                                    CarouselView(longPress: $longPress, selectedBook: $selectedBook, showBook: $showBook, iPadOrientation: true)
                                        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                                } else if !isLandscape {
                                    LibraryGrid(longPress: $longPress, selectedBook: $selectedBook, showBook: $showBook, iPadOrientation: true, books: $selectedBooks)
                                        .padding(.horizontal, iPadOrientation ? UIScreen.main.bounds.width * 0.05 : 0)
                                } else {
                                    LandscapeLibraryGrid(showMedia: $selectedBook, longPress: $longPress, selectedBook: $selectedBook, showBook: $showBook, iPadOrientation: true)
                                    .padding(.horizontal, isLandscape ? UIScreen.main.bounds.width * 0.15 : UIScreen.main.bounds.width * 0.05)
                                        
                                }
                            }
                            
                        }
                        .tag(0)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .background(lightModeController.getBackgroundColor().ignoresSafeArea().shadow(radius: 8))
                /*.sheet(isPresented: $showSearch) {
                        SearchLibraryView(isPresenting: $showSearch)
                    
                }*/
                .sheet(isPresented: $showReviews) {
                    AllReviews(isPresenting: $showReviews, user: userData.user)
                }
                .offset(x: showSidebar ? -UIScreen.main.bounds.width * 0.82 : 0)
                .animation(.easeInOut(duration: 0.3), value: showSidebar) // Smooth animation
                

                /*
                .sheet(isPresented: $showLibrary) {
                    ScrollView {
                        HStack {
                            Text("Library")
                                .padding()
                                .font(.system(size: 17, weight: .medium))
                            Spacer()
                            Button(action: {
                                addBook = true
                            }) {
                                Image(systemName: "plus")
                            }
                        }
                        .padding()
                        TableView(isPresenting: $showLibrary, showToolbar: $showToolbar, user: userData.user, books: userData.user.library)
                    }
                    .background(backgroundColor)
                }*/
                .sheet(isPresented: $addBook) {
                    AddBookToLibraryView(isPresenting: $addBook)
                }
                
                .sheet(isPresented: $showLists) {
                    ScrollView {
                        ListAllLists(showList: $showList, selectedList: $selectedList)
                    
                        
                    }
                    .scrollIndicators(.hidden)
                    .presentationDetents([.fraction(0.8)])
                    .presentationDragIndicator(.visible)   // Optional: Show a drag indicator

                 .background(
                                             RoundedCorners(tl: 50, tr: 50) // Adjust radius here
                                            .fill(Color.white)
                  )

                    
                }
                .onChange(of: selectedList){ newList in
                    selectedBooks = selectedList.books
                    showingBooks = selectedList.title
                    showLists = false
                    
                    
                }
                .sheet(isPresented: $showMessages){
                    ConvosView()

                }
                .overlay(
                    longPress ?
                        BookPreviewPopup(book: selectedBook, isPresenting: $longPress, showEReader: $showEReader, showToolbar: $showToolbar)
                            .animation(.easeInOut)
                        :
                        nil
                )

                .sheet(isPresented: $showBookIPad) {
                    ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar, fullscreen: false)
                        .presentationDetents([.fraction(0.999)])

                }
                if iPadOrientation {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                showFeedback = true
                            }){
                                Text("Feedback")
                                    .font(.system(size: 13))
                                    .opacity(0.7)
                            }
                        }
                    }
                    .padding(.horizontal, iPadOrientation ? UIScreen.main.bounds.width * 0.05 : 0)
                    
                    
                    .sheet(isPresented: $showFeedback){
                        FeedbackView(isPresenting: $showFeedback)
                    }
                    .padding(.bottom, 80)
                }
                if showSearch {
                    
                    LibrarySearchView(isPresenting: $showSearch)
                    
                }
                if showSidebar {
                    HStack {
                        VStack{
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.82)
                        .background(lightModeController.getBackgroundColor().opacity(0.001))
                        .onTapGesture{
                            showSidebar.toggle()
                        }
                        Spacer()
                    }
                }
                
                if create {
                    CreateView(create: $create)
                        .animation(.easeInOut)
                }
                
                if showReader {
                    ReaderView(book: navigation.getSelectedBook() ?? Book(), showToolbar: $showToolbar)
                }
                AnimateView(showView: $showBookIPhone) {
                    ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar, fullscreen: false)
                }
                /*
                ZStack {
                    if showingBook {
                        ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar, fullscreen: false)
                            .onAppear {
                                contentOffset = UIScreen.main.bounds.width
                                withAnimation(.easeInOut(duration: 0.28)){
                                    contentOffset = 0
                                }
                            }
                            .onChange(of: showBookIPhone) {
                                contentOffset = 0
                                withAnimation(.easeInOut(duration: 0.28)){
                                    contentOffset = UIScreen.main.bounds.width
                                }
                            }
                            .offset(x: contentOffset)
                        
                    }
                }
                .onChange(of: showBookIPhone) { newValue in

                    if showBookIPhone {
                        showingBook.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            navigation.hideToolbar()
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
                            // Action to perform after animation ends
                            showingBook.toggle()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            navigation.showToolbarTrue()
                        }
                        
                    }
                    
                    
                }*/
            

         
                    
               
                
            }
            .onAppear{
                showToolbar = true
                selectedBooks = userData.user.getAllBooks()
            }
            .sheet(isPresented: $showQueue) {
                ToBeReadQueue()
            }
            .sheet(isPresented: $isPresentingProfilePopup) {
                ProfilePopup(isPresentingProfilePopup: $isPresentingProfilePopup)
                    .presentationDetents([.fraction(0.9)])
            }
            .onAppear {
                self.isLandscape = isLandscape
            }
            .onChange(of: isLandscape) { newValue in
                self.isLandscape = newValue
            }
            .onChange(of: showBook) {
                let iPadOrientation = horizontalSizeClass != .compact
                
                if iPadOrientation {
                    showBookIPad.toggle()
                } else {
                    showBookIPhone.toggle()

                }
            }
        }
    }
    

}

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.size.width
        let height = rect.size.height

        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addQuadCurve(to: CGPoint(x: tl, y: 0), control: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width - tr, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: tr), control: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.closeSubpath()

        return path
    }
}

struct LandscapeLibraryGrid: View {
    @State private var showPopover = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var library: Library
    @Binding var showMedia : Book
    @Binding var longPress : Bool
    @State var isTapped = false
    @State var bookWidth = 0.0
    @Binding var selectedBook : Book
    @Binding var showBook : Bool
    @State var iPadOrientation = false
    var body: some View {


        if userData.user.currentReads.books != nil {
            let (media, media2, media3) = splitBooksList(userData.user.currentReads.books + userData.user.readingList.books + userData.user.pastReads.books)
        
            GeometryReader { geometry in
        VStack(alignment: .center) {
            
            ScrollView {
                
                HStack(alignment: .top){
                    LazyVStack(spacing: 20) {
                        ForEach(Array(media.enumerated()), id: \.offset) { index, m in
                            

                                Button(action: {
                                    selectedBook = m
                                    showBook = true
                                    
                                }){
                                VStack(alignment: .leading) {
                                    Image(m.cover)                                   .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width / 3.6)
                                        .clipped() // This will clip the overflow
                                        .cornerRadius(5)
                                        .shadow(radius: 0.6)

                                        .onTapGesture {
                                            selectedBook = m
                                            showBook = true
                                        }
                                        
                                        .onLongPressGesture(minimumDuration: 0.6){
                                           // bookWidth = 20.0
                                            showMedia = m
                                            longPress = true
                                        }
                                        
                              
                                    HStack {
                                        if m.currentPage != nil && m.totalPages != nil {
                                            ProgressView(value: Double(m.currentPage!) / Double(m.totalPages!))
                                                .padding(.horizontal, 1)
                                                .padding(.vertical, 8)
                                                .progressViewStyle(LinearProgressViewStyle(tint: .black))
                                                .opacity(0.7)
                                        } else {
                                            ProgressView(value: 0.00025)
                                                .padding(.horizontal, 1)
                                                .padding(.vertical, 8)
                                                .progressViewStyle(LinearProgressViewStyle(tint: .black))
                                                .opacity(0.7)
                                        } /*else if let stat = userData.user.getStatus(bookid: m.id) {
                                            HStack {
                                                StatusView(user: userData.user, book: m, changeStatus: $changeStatus, selectedBook: $selectedBook)
                                                Spacer()
                                            }
                                            }*/
                                            
                                     
      
                                    }
                                    .frame(width: geometry.size.width / 3.6)

                                    //.padding(.top, 2)

                                    .padding(.bottom, 4)

                                    
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
                                        .frame(width: geometry.size.width / 3.6)                                        .clipped() // This will clip the overflow
                                        .cornerRadius(5)
                                        .shadow(radius: 0.6)
                                        .onTapGesture {
                                            selectedBook = m
                                            showBook = true
                                        }
                                        
                                        .onLongPressGesture(minimumDuration: 0.6){
                                           // bookWidth = 20.0
                                            showMedia = m
                                            longPress = true
                                        }

                             
                                    
                                    HStack {
                                        if m.currentPage != nil && m.totalPages != nil {
                                            ProgressView(value: Double(m.currentPage!) / Double(m.totalPages!))
                                                .padding(.horizontal, 1)
                                                .padding(.vertical, 8)
                                                .progressViewStyle(LinearProgressViewStyle(tint: .black))
                                                .opacity(0.7)
                                        } else {
                                            ProgressView(value: 0.00025)
                                                .padding(.horizontal, 1)
                                                .padding(.vertical, 8)
                                                .progressViewStyle(LinearProgressViewStyle(tint: .black))
                                                .opacity(0.7)
                                        } /*else if let stat = userData.user.getStatus(bookid: m.id) {
                                            HStack {
                                                StatusView(user: userData.user, book: m, changeStatus: $changeStatus, selectedBook: $selectedBook)
                                                Spacer()
                                            }
                                            }*/
                                            
                                     
      
                                    }
                                    .frame(width: geometry.size.width / 3.6)
                                    .padding(.bottom, 4)

                                }
                               
                            }
                            
                            
                            
                        }
                        
                    }
                    Spacer()
                    LazyVStack(spacing: 20) {
                        ForEach(Array(media3.enumerated()), id: \.offset) { index, m in
                            
                            Button(action: {
                  
                                
                            }){
                                VStack(alignment: .leading) {
                                    Image(m.cover)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width / 3.6)                                        .clipped() // This will clip the overflow
                                        .cornerRadius(8)
                                        .shadow(radius: 0.6)
                                        .onTapGesture {
                                            selectedBook = m
                                            showBook = true
                                        }
                                        
                                        .onLongPressGesture(minimumDuration: 0.6){
                                           // bookWidth = 20.0
                                            showMedia = m
                                            longPress = true
                                        }

                             
                                    
                                    HStack {
                                        if m.currentPage != nil && m.totalPages != nil {
                                            ProgressView(value: Double(m.currentPage!) / Double(m.totalPages!))
                                                .padding(.horizontal, 1)
                                                .padding(.vertical, 8)
                                                .progressViewStyle(LinearProgressViewStyle(tint: .black))
                                                .opacity(0.7)
                                        } else {
                                            ProgressView(value: 0.00025)
                                                .padding(.horizontal, 1)
                                                .padding(.vertical, 8)
                                                .progressViewStyle(LinearProgressViewStyle(tint: .black))
                                                .opacity(0.7)
                                        } /*else if let stat = userData.user.getStatus(bookid: m.id) {
                                            HStack {
                                                StatusView(user: userData.user, book: m, changeStatus: $changeStatus, selectedBook: $selectedBook)
                                                Spacer()
                                            }
                                            }*/
                                            
                                     
      
                                    }
                                    .frame(width: geometry.size.width / 3.6)
                                    .padding(.bottom, 4)

                                }
                               
                            }
                            
                            
                            
                        }
                        
                    }
                    
                }
                .padding(.trailing)
                .padding(.top, 4)
                //.padding(.leading, 10)
                //.padding(.trailing, 10)
                .padding(.top, 30)
            }
            .scrollIndicators(.hidden)
            
        }
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

struct CarouselView: View {
    @State private var showPopover = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var library: Library
    @Binding var longPress: Bool
    @State var isTapped = false
    @State var bookWidth = 0.0
    @Binding var selectedBook: Book
    @Binding var showBook: Bool
    @State var iPadOrientation = false
    @State private var currentIndex = 0  // Add a state variable to track the current tab index
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        
        if userData.user.currentReads.books != nil {
            var books = userData.user.currentReads.books + userData.user.readingList.books + userData.user.pastReads.books
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    TeasingTabView(selectedTab: $currentIndex, spacing: iPadOrientation ? 20 : 50) { // Bind TabView's selection to currentIndex
                            Array(books.enumerated().map { index, book in
                                AnyView(
                            VStack(alignment: .leading) {
                            
                                    VStack(alignment: .leading) {
                                        Image(book.cover)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: iPadOrientation ? geometry.size.width / 1.6 : 290)
                                            .clipped()
                                            .cornerRadius(15)
                                            .shadow(radius: 0.6)
                                            .onTapGesture {
                                                selectedBook = book
                                                showBook = true
                                            }
                                            .onLongPressGesture(minimumDuration: 0.6) {
                                                showBook = true
                                                selectedBook = book
                                                longPress = true
                                            }
                                        
                                        HStack {
                                            
                                            let currentPage = book.ebook.getCurrentPage()
                                            
                                            let totalPages = book.ebook.getPageCount()
                                            
                                            
                                            ProgressBar(totalPages: totalPages, currentPage: currentPage, height: 5)
                                                .padding(.vertical, 8)
                                                .padding(.horizontal, 1)

                                                   /* ProgressView(value: Double(currentPage) / Double(totalPages))
                                                        .padding(.horizontal, 1)
                                                        .padding(.vertical, 8)
                                                        .progressViewStyle(LinearProgressViewStyle(tint: .black))
                                                        .opacity(0.7)*/
                                               
                                        }
                                        .frame(width: iPadOrientation ? geometry.size.width / 1.6 : 290)
                                        .padding(.bottom, 4)
                                    }
                                
                            }
                            .padding()
                            )
                           // .tag(index)  // Assign a tag to each page in the TabView
                        }
                                  )
                    }
                    
                    //.tabViewStyle(PageTabViewStyle())
                    
                    
                    // Display the current tab number and total number of tabs
                    Text("\(currentIndex + 1) / \(books.count) books")
                        .font(.system(size: 12))
                        .opacity(0.7)
                        .padding(.vertical)
                }
                
                .frame(height: geometry.size.height)

            }
        }
    }
}


struct TeasingTabView: View {
    @Binding var selectedTab: Int
    let spacing: CGFloat
    let views: () -> [AnyView]

    @State private var dragOffset = CGFloat.zero
    
    var viewCount: Int { views().count }

    var body: some View {
        VStack(spacing: spacing) {
            GeometryReader { geo in
                let width = geo.size.width * 0.7
                
                LazyHStack(spacing: spacing) {
                    Color.clear
                        .frame(width: geo.size.width * 0.15 - spacing)
                    ForEach(0..<viewCount, id: \.self) { idx in
                        views()[idx]
                            .frame(width: width)
                            .padding(.vertical)
                    }
                }
                .offset(x: -CGFloat(selectedTab) * (width + spacing) + dragOffset) // Adjust offset with drag
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let threshold = width / 2
                            let predictedEndOffset = value.predictedEndTranslation.width

                            // Determine if the swipe was significant enough to change the tab
                            if predictedEndOffset > threshold {
                                withAnimation {
                                    dragOffset = width + spacing  // Simulate snapping effect
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    selectedTab = max(0, selectedTab - 1)
                                    dragOffset = 0  // Reset drag offset after tab change
                                    
                                }
                                
                            } else if predictedEndOffset < -threshold {
                                withAnimation {
                                    dragOffset = -(width + spacing)  // Simulate snapping effect
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    selectedTab = min(viewCount - 1, selectedTab + 1)
                                        dragOffset = 0  // Reset drag offset after tab change
                                    
                                }
                            } else {
                                withAnimation {
                                    dragOffset = 0  // Reset the drag offset if not swiped enough
                                }
                            }
                        }
                )
            }
            /*
            // Indicator Dots
            HStack {
                ForEach(0..<viewCount, id: \.self) { idx in
                    Circle().frame(width: 8)
                        .foregroundColor(idx == selectedTab ? .primary : .secondary.opacity(0.5))
                        .onTapGesture {
                            withAnimation {
                                selectedTab = idx
                            }
                        }
                }
            }*/
        }
    }
}

struct LibraryGrid: View {
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
    @Binding var books: [Book]
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact

        let columns = Array(repeating: GridItem(.flexible(), spacing: iPadOrientation ? 20 : 10, alignment: .top), count: 2)
        //GeometryReader { geometry in
        //let userBooks = userData.user.getAllBooks()
        ScrollView{
            LazyVGrid(columns: columns, spacing: iPadOrientation ? 40 : 25) {
                ForEach(books) { book in
                    Button(action: {
                        selectedBook = book
                        showBook = true
                    }) {
                        VStack() {
                            Image(book.cover)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width / 2.2)
                                .clipped() // This will clip the overflow
                                .cornerRadius(iPadOrientation ? 14 : 7)
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
            .padding(.horizontal, UIScreen.main.bounds.width * 0.025)
            .padding(.top)
            .padding(.top)
            .padding(.top, 3)

        }

        
    }
}

struct iPadLibraryGrid: View {
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

        let columns = Array(repeating: GridItem(.flexible(), spacing: iPadOrientation ? 20 : 10, alignment: .top), count: 2)
        //GeometryReader { geometry in
            
        let userBooks = userData.user.getAllBooks()
        
            LazyVGrid(columns: columns, spacing: iPadOrientation ? 40 : 25) {
                ForEach(userBooks) { book in
                    Button(action: {
                        selectedBook = book
                        showBook = true
                    }) {
                        VStack() {
                            Image(book.cover)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width / 2.3)
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

struct Favorites: View {
    @State private var showPopover = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var library: Library

    @State var books : [Book]
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
        //Color(.white)


    @State var isTapped = false

    var body: some View {
        if !books.isEmpty {
            let columns = splitBooksList(books: books, into: 4)
        
            VStack {
               
                HStack(alignment: .top, spacing: 13) {
                    ForEach(0..<4) { columnIndex in
                        LazyVStack(spacing: 20) {
                            ForEach(columns[columnIndex], id: \.self) { book in
 
                                VStack(alignment: .leading) {
                                    Image(book.cover)                                   .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: horizontalSizeClass == .compact ? (UIScreen.main.bounds.width) / 4.9 : min((UIScreen.main.bounds.width) / 5.4, 200 ))
                                        .clipped() // This will clip the overflow
                                        .cornerRadius(5)
                                        .onTapGesture{
                                            isTapped.toggle()
                                            selectedBook = book
                                            showBook = true
                                        }
                                    
                                    
                                    
                                }
                                .onTapGesture {
                                    //  isPresenting = false
                                }
                                
                            }
                        }
                                
                            }
                            
                    
                }
                .padding(.horizontal)
            }
            .background(backgroundColor)
        }
    }
    
    private func splitBooksList(books: [Book], into columnCount: Int) -> [[Book]] {
        var columns: [[Book]] = Array(repeating: [], count: columnCount)
        for (index, book) in books.enumerated() {
            let columnIndex = index % columnCount
            columns[columnIndex].append(book)
        }
        return columns
    }
}
struct ThreeGrid: View {
    @State private var showPopover = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var library: Library
    @State var books : [Book]
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @State var inExplore = false
    @Binding var viewModel: ContentViewModel

    
        //Color(.white)


    @State var isTapped = false

    var body: some View {
        if !books.isEmpty {
            let columns = splitBooksList(books: books, into: 3)
        

                VStack {
                
                HStack(alignment: .top, spacing: 10) { // Adjust spacing as necessary
                    ForEach(0..<3) { columnIndex in
                        LazyVStack(spacing: 20) {
                            ForEach(columns[columnIndex], id: \.self) { book in
                                
                                VStack(alignment: .leading) {
                                    Image(book.cover)                                   .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        
                                        .frame(idealWidth: (UIScreen.main.bounds.width) / 3.5,  maxWidth: 250 /*, width: (UIScreen.main.bounds.width) / 3.5*/)
                                        .clipped() // This will clip the overflow
                                        .cornerRadius(5)
                                        .onTapGesture{
                                            isTapped.toggle()
                                            selectedBook = book
                                            showBook = true
                                            viewModel = ContentViewModel(book: selectedBook)
                                        }
                                    
                                    
                                }
                                .onTapGesture {
                                    //  isPresenting = false
                                }
                                
                                
                                
                                
                            }
                            
                        }
                    }
                    
                }
                .padding(.horizontal)
                    
                }
                .frame(idealWidth: UIScreen.main.bounds.width, maxWidth: 1000)
                .background(backgroundColor)
            
                
                
        }
    }
    
    private func splitBooksList(books: [Book], into columnCount: Int) -> [[Book]] {
        var columns: [[Book]] = Array(repeating: [], count: columnCount)
        for (index, book) in books.enumerated() {
            let columnIndex = index % columnCount
            columns[columnIndex].append(book)
        }
        return columns
    }
}

struct FourGrid: View {
    @State private var showPopover = false
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var library: Library

    @State var books : [Book]
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    
        //Color(.white)


    @State var isTapped = false

    var body: some View {
        if !books.isEmpty {
            let columns = splitBooksList(books: books, into: 4)
        
            ScrollView(.horizontal){
                HStack(alignment: .top, spacing: 10) { // Adjust spacing as necessary
                    ForEach(0..<4) { columnIndex in
                                ForEach(columns[columnIndex], id: \.self) { book in
                                    
                                    VStack(alignment: .leading) {
                                        Image(book.cover)                                   .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: (UIScreen.main.bounds.width) / 4.9)
                                            .clipped() // This will clip the overflow
                                            .cornerRadius(5)
                                            .onTapGesture{
                                                isTapped.toggle()
                                                selectedBook = book
                                                showBook = true
                                            }
                                        
                                       
                                    }
                                    .onTapGesture {
                                        //  isPresenting = false
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                            
                        
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
            .background(backgroundColor)
        }
    }
    
    private func splitBooksList(books: [Book], into columnCount: Int) -> [[Book]] {
        var columns: [[Book]] = Array(repeating: [], count: columnCount)
        for (index, book) in books.enumerated() {
            let columnIndex = index % columnCount
            columns[columnIndex].append(book)
        }
        return columns
    }
}



struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}

struct BookPreviewPopup: View {
    var book: Book
    @EnvironmentObject var userData: UserData
    @Binding var isPresenting : Bool
    @State var showBook = true
    @Binding var showEReader : Bool
    @Binding var showToolbar: Bool
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: {
                showBook = true
                
            }){
                Image(book.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: (UIScreen.main.bounds.height) / 3.5)
                    .cornerRadius(10)
                    .clipped() // This will clip the overflow
            }
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 230, height: 190)
                .foregroundColor(.white)
                .overlay(
                    VStack {
                        
                        Button("Mark as read"){
                            if let index =  userData.user.currentReads.books.firstIndex(where: { $0.id == book.id }) {
                                userData.user.currentReads.books.remove(at: index)
                            }
                            
                            userData.user.pastReads.books.insert(book, at: 0)
                            
                            isPresenting = false
                            
                        }
                        
                        Divider()
                        
                        Button("Move to list"){
                            if let index =  userData.user.currentReads.books.firstIndex(where: { $0.id == book.id }) {
                                userData.user.currentReads.books.remove(at: index)
                            }
                            
                            userData.user.readingList.books.insert(book, at: 0)
                            
                            isPresenting = false

                        }
                        
                        Divider()
                        
                        Button("Share"){
                            
                        }
                        
                        Divider()
                        
                        Button("Remove from Library"){
                            if let index =  userData.user.currentReads.books.firstIndex(where: { $0.id == book.id }) {
                                userData.user.currentReads.books.remove(at: index)
                            }
                            isPresenting = false
                        }
                        .foregroundColor(.red)
                    }
                        .foregroundColor(.black)

                    
                )
                .padding(.top)
            Spacer()
        }
        .padding(.horizontal, 100)
        .padding(.top, 100)
        .background(VisualEffectBlur(blurStyle: .systemThinMaterialLight).edgesIgnoringSafeArea(.all))
        .onAppear{
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
        }
        .onTapGesture {
            isPresenting = false
        }
        .animation(.linear(duration: 1))

    }
}

