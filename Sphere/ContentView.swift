//
//  ContentView.swift
//  media discussion
//
//  Created by Alana Greenaway on 1/28/24.
//

import SwiftUI
import CoreData
import UIImageColors
import MessageUI


struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var library: Library
    @Binding var book: Book
    @Binding var isPresenting: Bool
    @Binding var showToolbar: Bool
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var fullscreen: Bool
    //@Binding var showReader: Bool
    
    init(book: Binding<Book>, isPresenting: Binding<Bool>, showToolbar: Binding<Bool>, fullscreen: Bool = true) {
        self._book = book
        _viewModel = StateObject(wrappedValue: ContentViewModel(book: book.wrappedValue))
        self._isPresenting = isPresenting
        self._showToolbar = showToolbar
        self._fullscreen = State(initialValue: fullscreen)
    }
    var body: some View {
        
        iPadContentView(book: $book, isPresenting: $isPresenting, showToolbar: $showToolbar, fullscreen: fullscreen)
        
        
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
struct iPadContentView: View {
    @StateObject var viewModel: ContentViewModel
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var library: Library
    @Binding var book: Book
    @Binding var isPresenting: Bool
    @State var fullscreen = true
    @Binding var showToolbar: Bool
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    //@State var backgroundColor = Color(hex: "#FDFAEF")
    @State var showAllNotes = false
    @State var showFeedback = false
    @State var showGenre: Bool = false
    @State var selectedGenre: Genre? = nil
    @EnvironmentObject var navigation: Nav
    @State var showShare = false
    @EnvironmentObject var lightModeController: LightModeController
    @State var showCharacter: Bool = false
    @State var selectedCharacter: Character? = Character(name: "Alana")
    @State var showNote = false
    @State var selectedNote: Note = Note()
    @State var titleNotVisible = false
    @State var headerPadding = 0.0
    @State var xoffset = 0.0
    @EnvironmentObject var notificationCoordinator: NotificationCoordinator

    init(book: Binding<Book>, isPresenting: Binding<Bool>, showToolbar: Binding<Bool>, fullscreen: Bool = true) {
        self._book = book
        _viewModel = StateObject(wrappedValue: ContentViewModel(book: book.wrappedValue))
        self._isPresenting = isPresenting
        self._showToolbar = showToolbar
        self._fullscreen = State(initialValue: fullscreen)
    }
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            
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
                        
                        if viewModel.toolbarActive {
                            Text(viewModel.book.title)
                                .font(.system(size: 12, weight:.medium))
                        }
                        /*
                         Button(action: {
                         
                         }){
                         Image(systemName: "ellipsis")
                         .font(.system(size: 17, weight: .medium))
                         .padding(.trailing)
                         
                         }
                         */
                        if !titleNotVisible{
                            Button(action: {
                                showShare.toggle()
                                viewModel.showRateView = false
                                
                            }){
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 17, weight: .medium))
                            }
                        }
                        
                        
                        
                        
                    }
                    .foregroundColor(lightModeController.getForegroundColor())
                    //.ignoresSafeArea()
                    .padding(.horizontal)
                    .padding(.vertical, headerPadding)
                    .overlay(
                        VStack {
                            if titleNotVisible {
                                Text(viewModel.book.title)
                                    .font(.custom("EBGaramondRoman-SemiBold", size: 13.5))
                                //.font(.system(size: 13.5, weight: .medium))
                                    .padding(.top)
                                
                                Text(viewModel.book.author.name)
                                    .font(.system(size: 12))
                                    .opacity(0.7)
                                    .padding(.bottom)
                    
                                
                            }
                            
                        }
                    )
                    
                    ScrollView {
                        
                        ZStack {
                            
                            ScrollViewReader { value in
                                ScrollView {
                                    VStack {
                                        HStack {
                                            Spacer()
                                            VStack{
                                                
                                                
                                                
                                                if isLandscape {
                                                    // Your image here
                                                    Image(book.cover)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 200)
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                        .shadow(radius: 0.5)
                                                        .padding(.top, iPadOrientation ? 20 : 0)
                                                        .padding(.bottom, 70)
                                                    
                                                } else {
                                                    Image(book.cover)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 270)
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                        .shadow(radius: 0.5)
                                                        .padding(.top, iPadOrientation ? 20 : 0)
                                                        .padding(.bottom, iPadOrientation ? 70 : 30)
                                                }
   
                                                
                                                
                                            }
                                            Spacer()
                                        }
                                        //.padding(.top, 30)
                                        Spacer()
                                        
                                        VStack(alignment: .leading) {
                                            
                                            
                                            
                                            VStack(alignment: .leading) {
                                                HStack{
                                                    VStack(alignment: .leading) {
                                                        Text(book.title)
                                                        //Baskerville-SemiBold
                                                            .font(.custom("Baskerville", size: 20).weight(.medium))
                                                            .scaleEffect(x: 1.0, y: 1.15) // Stretch vertically
                                                            .padding(.horizontal, 5)

                                                    
                                                            .padding(.top, 20)
                                                            .multilineTextAlignment(.leading)
                                                            //.padding(.bottom)
                                                            .background(
                                                                GeometryReader { geometry in
                                                                    Color.clear
                                                                        .onChange(of: geometry.frame(in: .global).minY) { newValue in
                                                                            // Check if the title is out of view
                                                                            if newValue < 0 {
                                                                                withAnimation{
                                                                                    titleNotVisible = true
                                                                                    headerPadding = 8
                                                                                    
                                                                                }
                                                                            } else {
                                                                                withAnimation {
                                                                                    titleNotVisible = false
                                                                                    headerPadding = 0
                                                                                }
                                                                            }
                                                                        }
                                                                }
                                                            )
                                                        /*
                                                        HStack() {
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
                                                         
                                                        */
                                                        /*
                                                        HStack(alignment:.top) {
                                                           
                                                            Spacer()
                                                            
                                                            if iPadOrientation {
                                                                Button(action: { viewModel.showAuthor = true}){
                                                                    
                                                                    
                                                                    VStack(alignment: .leading) {
                                                                        Text("AUTHOR")
                                                                            .multilineTextAlignment(.center)
                                                                            .font(.system(size:10.5, weight:.medium))
                                                                            .opacity(0.5)
                                                                            .padding(.bottom, 2)
                                                                        
                                                                        Text("\(book.author.name)")
                                                                            .padding(.leading, -2)
                                                                            .font(.system(size:13.5, weight:.medium))
                                                                            .multilineTextAlignment(.center)
                                                                            .lineLimit(1)
                                                                        //.textCase(.uppercase)
                                                                        
                                                                    }
                                                                    .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                                                                    //.opacity(0.6)
                                                                }
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                Divider()
                                                                    .padding(.horizontal, 2)
                                                                
                                                            }
                                                            
                                                            
                                                        
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
                                                                            value.scrollTo("reviewsSection", anchor: .bottom)
                                                                        }
                                                                    }) {
                                                                        Image(systemName: "star.fill")
                                                                            .font(.system(size: 12))
                                                                            .foregroundColor(.orange)
                                                                            .opacity(1)
                                                                            .padding(.leading, -5)
                                                                        if viewModel.book.rating != 0 {
                                                                            Text("\(String(format: "%.1f", viewModel.book.rating))")
                                                                                .padding(.leading, -5)
                                                                                .foregroundColor(lightModeController.getForegroundColor())
                                                                        } else{
                                                                            Text("-")
                                                                                .padding(.leading, -5)
                                                                                .foregroundColor(lightModeController.getForegroundColor())
                                                                        }
                                                                        // Your additional styles here
                                                                    }
                                                                }
                                                                
                                                                
                                                            }
                                                            
                                                            
                                                            if viewModel.book.readers >= 1000 {
                                                                Divider()
                                                                    .padding(.horizontal, 2)
                                                                    .frame(height: 40)
                                                                
                                                                
                                                                
                                                                VStack {
                                                                    Text("READERS")
                                                                        .multilineTextAlignment(.center)
                                                                        .font(.system(size:10.5, weight:.medium))
                                                                        .opacity(0.5)
                                                                        .padding(.bottom, 2)
                                                                    Text(viewModel.formatLargeNumber(viewModel.book.readers))
                                                                    
                                                                }
                                                            }
                                                            
                                                            /*
                                                             
                                                             Divider()
                                                             .padding(.horizontal, 2)
                                                             
                                                             Button(action: { viewModel.isPresentingDiscPopup = true}){
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
                                                             
                                                             Text("\(book.discussion.posts.count)")
                                                             .padding(.leading, -5)
                                                             
                                                             
                                                             }
                                                             }
                                                             
                                                             }
                                                             .foregroundColor(.black)
                                                             */
                                                            
                                                            
                                                        }
                                                        .font(.system(size:13.5, weight:.medium))*/
                                                    }
                                                    
                                                   
                                                    Spacer()
                                                   
                                                    HStack(alignment:.center) {
                                                        
                                                        if iPadOrientation {
                                                            Button(action: { viewModel.showAuthor = true}){
                                                                
                                                                
                                                                VStack(alignment: .leading) {
                                                                    Text("AUTHOR")
                                                                        .multilineTextAlignment(.center)
                                                                        .font(.system(size:10.5, weight:.medium))
                                                                        .opacity(0.5)
                                                                        .padding(.bottom, 2)
                                                                    
                                                                    Text("\(book.author.name)")
                                                                        .padding(.leading, -2)
                                                                        .font(.system(size:13.5, weight:.medium))
                                                                        .multilineTextAlignment(.center)
                                                                        .lineLimit(1)
                                                                    //.textCase(.uppercase)
                                                                    
                                                                }
                                                                .foregroundColor(lightModeController.isDarkMode() ? Color(hex: "#FDFAEF") : lightModeController.getForegroundColor())
                                                                //.opacity(0.6)
                                                            }
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            Divider()
                                                                .padding(.horizontal, 2)
                                                            
                                                        }
                                                        
                                                        
                                                        
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
                                                                        value.scrollTo("reviewsSection", anchor: .bottom)
                                                                    }
                                                                }) {
                                                                    Image(systemName: "star.fill")
                                                                        .font(.system(size: 12))
                                                                        .foregroundColor(.orange)
                                                                        .opacity(1)
                                                                        .padding(.leading, -5)
                                                                    if viewModel.book.rating != 0 {
                                                                        Text("\(String(format: "%.1f", viewModel.book.rating))")
                                                                            .padding(.leading, -5)
                                                                            .foregroundColor(lightModeController.getForegroundColor())
                                                                    } else{
                                                                        Text("-")
                                                                            .padding(.leading, -5)
                                                                            .foregroundColor(lightModeController.getForegroundColor())
                                                                    }
                                                                    // Your additional styles here
                                                                }
                                                            }
                                                            .padding(.horizontal, 5)

                                                            
                                                            
                                                            
                                                        }
                                                        
                                                        /*
                                                        if viewModel.book.readers >= 1000 {
                                                            Divider()
                                                                .padding(.horizontal, 2)
                                                                .frame(height: 40)
                                                            
                                                            
                                                            
                                                            VStack {
                                                                Text("READERS")
                                                                    .multilineTextAlignment(.center)
                                                                    .font(.system(size:10.5, weight:.medium))
                                                                    .opacity(0.5)
                                                                    .padding(.bottom, 2)
                                                                Text(viewModel.formatLargeNumber(viewModel.book.readers))
                                                                
                                                            }
                                                        }*/
                                                        
                                                        /*
                                                         
                                                         Divider()
                                                         .padding(.horizontal, 2)
                                                         
                                                         Button(action: { viewModel.isPresentingDiscPopup = true}){
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
                                                         
                                                         Text("\(book.discussion.posts.count)")
                                                         .padding(.leading, -5)
                                                         
                                                         
                                                         }
                                                         }
                                                         
                                                         }
                                                         .foregroundColor(.black)
                                                         */
                                                        
                                                        
                                                    }
                                                    .padding(.top)
                                                    .font(.system(size:13.5, weight:.medium))
                                                   
                                                }
                                                .padding(.horizontal, iPadOrientation ? 5 : 0)
                                                
                                                .padding(.bottom, 6)
                                                Spacer()
                                                VStack(alignment: .leading) {
                                                    
                                                    if viewModel.isPresentingMoreInfo {
                                                        Text(book.synopsis)
                                                            .multilineTextAlignment(.leading)
                                                            //.font(Font(UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(0.1))))
                                                            .font(Font(UIFont.systemFont(ofSize: iPadOrientation ? 15 : 16.8, weight: UIFont.Weight(0.05))))
                                                            .lineSpacing(5)
                                                            .padding(.top, 20)
                                                            .padding(.horizontal, 5)
                                                            .padding(.bottom)
                                                        
                                                    } else {
                                                        Text(book.synopsis)
                                                            .multilineTextAlignment(.leading)
                                                            //.font(.system(size: iPadOrientation ? 15 : 16.5))
                                                            .font(Font(UIFont.systemFont(ofSize: iPadOrientation ? 15 : 16.8, weight: UIFont.Weight(0.05))))
                                                        
                                                            

                                                            .lineLimit(9)
                                                            .lineSpacing(5)
                                                            .padding(.top, 20)
                                                            .padding(.horizontal, 5)
                                                            .padding(.bottom)
                                                        
                                                    }
                                                    
                                                    HStack(alignment: .center){
                                                        
                                                        GenreTag(book: book, showGenre: $showGenre, selectedGenre: $selectedGenre)
                                                        // if book is already in library
                                                        
                                                        
                                                        
                                                        Spacer()
                                                        if !iPadOrientation {
                                                            
                                                            
                                                           /* HStack(spacing: 12) {
                                                                
                                                                
                                                                NotesButton(viewModel: viewModel, showAllNotes: $showAllNotes, fontSize: 13.0, frameHeight: 29.0)
                                                                    .cornerRadius(30)
                                                                
                                                               
                                                                
                                                            }
                                                            .padding(.trailing)*/
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            Button(action: { viewModel.showAuthor = true}){
                                                                
                                                                
                                                                HStack() {
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
                                                                //.opacity(0.6)
                                                            }
                                                        }
                                                        
                                                        
                                                        
                                                    }
                                                    .padding(.top, 10)
                                                    .padding(.bottom)
                                                    
                                                   /* HStack {
                                                        Spacer()
                                                        DiscussionButton(viewModel: viewModel, fontSize: 13.0, frameHeight: 35.0)
                                                            .cornerRadius(30)
                                                        
                                                        QuotesButton(viewModel: viewModel, fontSize: 13.0, frameHeight: 35.0)
                                                            .cornerRadius(30)
                                                    }*/
                                                    
                                                    

                                                   
                                                    HStack {
                                                        if viewModel.book.getPostCount() > 0 {
                                                            Text("\(viewModel.book.getPostCount())")
                                                                .font(.system(size: 16.5, weight: .medium))
                                                                .padding(.trailing, -4)
                                                        }
                                                        
                                                        Image(systemName: "message")
                                                            .font(.system(size: 15, weight: .medium))

                                                           // .padding(.trailing, -2)
                                                        
                                                        //Text("1.2k discussion posts")
                                                         //   .font(.system(size: 17.5, weight: .medium))
                                                        
                                                     
                                                 
                                                    }
                                                    .onTapGesture{
                                                        viewModel.isPresentingDiscPopup = true
                                                    }
                                                   
                                                    
                                                    if userData.user.getStatus(bookid: viewModel.book.id) == .read {
                                                        if viewModel.book.getPostCount() > 0 {
                                                            MiniPostPreview3(post: viewModel.book.discussion.posts[0], showPost: $viewModel.showPost, selectedPost: $viewModel.selectedPost, showPoster: false)
                                                        }
                                                    } else {
                                                        VStack {
                                                            HStack {
                                                                Spacer()
                                                                BodyText(text: "✧･ﾟ: *✧･ﾟ:* Spoilers Ahead *:･ﾟ✧*:･ﾟ✧", size: 14.5, weight: 0.1)
                                                                    .padding(.bottom)
                                                                Spacer()
                                                                
                                                            }
                                                            BodyText(text: "Mark book as \"read\" or continue to discussion with spoilers", size: 14.5)
                                                        }
                                                        .padding(.vertical, 40)
                                                        .padding(.horizontal, 15)
                                                        .background(
                                    
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                                                                .fill(Color(hex: "#fffffc").opacity(0.7))
                                                            
                                                        )
                                                    }
                                                        
                                                    /*
                                                     HStack(alignment:.center) {
                                                     
                                                     Button(action: { viewModel.showAuthor = true}){
                                                     
                                                     
                                                     VStack(alignment: .leading) {
                                                     Text("AUTHOR")
                                                     .multilineTextAlignment(.center)
                                                     .font(.system(size:10.5, weight:.medium))
                                                     .opacity(0.5)
                                                     .padding(.bottom, 2)
                                                     
                                                     Text("\(viewModel.book.author.name)")
                                                     .padding(.leading, -2)
                                                     .font(.system(size:13.5, weight:.medium))
                                                     .multilineTextAlignment(.center)
                                                     //.textCase(.uppercase)
                                                     
                                                     }
                                                     .foregroundColor(.black)
                                                     //.opacity(0.6)
                                                     }
                                                     
                                                     Spacer()
                                                     Divider()
                                                     .padding(.horizontal, 2)
                                                     
                                                     // MoreLikeThis(media: viewModel.book)
                                                     
                                                     
                                                     
                                                     Spacer()
                                                     Button(action: { viewModel.isPresentingDiscPopup = true}){
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
                                                     
                                                     Text("\(viewModel.book.discussion.posts.count)")
                                                     .padding(.leading, -5)
                                                     
                                                     
                                                     }
                                                     }
                                                     
                                                     }
                                                     .foregroundColor(.black)
                                                     
                                                     
                                                     }
                                                     .padding(.top)
                                                     .font(.system(size:13.5, weight:.medium))
                                                     .padding(.bottom, 3)
                                                     .padding(.bottom, 3)
                                                     */
                                                    
                                                    
                                                }
                                                .gesture(
                                                    
                                                    DragGesture()
                                                    
                                                        .onChanged { _ in
                                                            
                                                            showShare = false
                                                            viewModel.showRateView = false
                                                        }
                                                )
                                                .onTapGesture{
                                                    viewModel.isPresentingMoreInfo.toggle()
                                                    showShare = false
                                                    viewModel.showRateView = false
                                                    
                                                }
                                                
                                                
                                                
                                                Spacer()
                                                
                                                
                                                
                                                
                                            }
                                            .padding(.horizontal, iPadOrientation ? 10 : 0)
                                            
                                            
                                            Spacer()
                                            VStack(alignment: .leading) {
                                                
                                                
                                                HStack(alignment: .top) {
                                                    
                                                    VStack(alignment: .leading) {
                                                        
                                                        HStack {
                                                            ProfileThumbnail(image: userData.user.photo, size: 30)
                                                            if let rating = userData.user.getRating(bookid: viewModel.book.id) {
                                                                Text("You")
                                                                    .font(.system(size: 14, weight: .medium))
                                                                    .padding(.trailing, -4)
                                                                Text("rated")
                                                                    .font(.system(size: 14))
                                                                    .padding(.trailing, -4)
                                                                
                                                                ReviewStar(rating: rating.stars)
                                                            } else {
                                                                BodyText(text: "Rate or review", size: 14)
                                                            }
                                                            Spacer()
                                                                
                                                        }
                                                        .padding(.horizontal)
                                                        .padding(.vertical)
                                                        .foregroundColor(.white)
                                                        .background(
                                                            Color(hex: "#3A4D64")
                                                                
                                                        )
                                                        .cornerRadius(7)
                                                        .onTapGesture{
                                                            if let rating = userData.user.getRating(bookid: viewModel.book.id) {
                                                                viewModel.initialRating = rating.stars
                                                            }
                                                            viewModel.showRateView = true
                                                        }
                                                        /*
                                                        let reviews = viewModel.book.getAllReviews()
                                                        HStack {
                                                            
                                                            /*Text("Reviews")
                                                             .font(.system(size: 16, weight: .medium))
                                                             /*Text("\($viewModel.book.reviews.count) reviews")
                                                              .font(.system(size: 14, weight: .medium))*/
                                                             */
                                                            
                                                            
                                                            if viewModel.book.rating > 0 {
                                                                Text("Reviews")
                                                                    .font(.system(size: 17.5, weight: .medium))

                                                                ReviewStar(rating: viewModel.book.rating, size: 15.5)
                                                                
                                                            }
                                                            /*
                                                            if reviews.count == 1 {
                                                                Text("\(reviews.count) review")
                                                                    .font(.system(size: 15.5, weight: .medium))
                                                            } else if reviews.count > 1 {
                                                                Text("\(reviews.count) reviews")
                                                                    .font(.system(size: 15.5, weight: .medium))
                                                            }
                                                            
                                                            if !iPadOrientation {
                                                                Spacer()
                                                                RateReviewButton(viewModel: viewModel)
                                                                    .cornerRadius(30)
                                                                    .padding(.top, 4)
                                                                
                                                            }*/
                                                        }
                                                        
                                                        
                                                        if reviews.count == 0 {
                                                            VStack(alignment: .center){
                                                                /*
                                                                 Button(action: { }){
                                                                 SphereAutoMessage("No reviews yet, be the first")
                                                                 //Text("No reviews yet, be the first")
                                                                 // .font(.system(size: 15, weight: .medium))
                                                                 //.padding(.top, 2)
                                                                 
                                                                 } */
                                                            }
                                                        }
                                                         */
                                                    }
                                                    
                                                    .padding(.vertical)
                                                    
                                                    
                                                    Spacer()
                                                    
                                                    
                                                    
                                                }
                                                
                                                let reviews = viewModel.book.getAllReviews()
                                                
                                                if reviews.count == 0 {
                                                    SphereAutoMessage(message: "No reviews yet, be the first")
                                                    
                                                }
                                                ForEach(reviews) { review in
                                                    MiniReviewPreview2(review: review)
                                                    Divider()
                                                }
                                                
                                                HStack{
                                                    Spacer()
                                                }
                                                .frame(height: 100)
                                                
                                                
                                                
                                                
                                                //ReviewFeed()
                                            }
                                            .padding(.vertical)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        .background(lightModeController.getBackgroundColor())
                                        
                                        
                                    }
                                    
                                    
                                }
                                .padding(.top, 50)
                                .sheet(isPresented: $viewModel.isPresentingBuy){
                                    PurchasePopup(isPresenting: $viewModel.isPresentingBuy, media: $viewModel.book)
                                        .presentationDetents([.fraction(0.6)])
                                }
                                .sheet(isPresented: $viewModel.showRateView) {
                                    RateView(media: viewModel.book, isPresenting: $viewModel.showRateView, rating: $viewModel.rating, initialRating: $viewModel.initialRating)
                                        .presentationDetents([.fraction(0.4)])
                                        .background(lightModeController.getBackgroundColor())
                                }
                                .sheet(isPresented: $viewModel.showQuotes) {
                                    BookQuotesView(book: viewModel.book)
                                        .background(lightModeController.getBackgroundColor())
                                }
                            }
                            
                            
                            
                        }
                        
                        
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.03)
                    .foregroundColor(lightModeController.getForegroundColor())
                    .background(lightModeController.getBackgroundColor())
                    .ignoresSafeArea()
                    .scrollIndicators(.hidden)
                    .gesture(
                        DragGesture()
                            .onChanged { _ in
                                showShare = false
                                viewModel.showRateView = false
                                
                            }
                    )
                    .onTapGesture {
                        showShare = false
                        viewModel.showRateView = false
                        
                    }
                    
                    .sheet(isPresented: $viewModel.showActivity){
                        ActivitySheet(
                            isPresenting: $viewModel.showActivity, user: viewModel.selectedUser, book: viewModel.book,
                            activity: viewModel.selectedUser.getPostsByID(bookid: viewModel.book.id),
                            review: viewModel.selectedUser.getReviewByID(bookid: viewModel.book.id)
                        )
                        .presentationDetents([.fraction(0.86)])
                        
                        
                    }
                    /*
                     .sheet(isPresented: $viewModel.isPresentingMoreInfo) {
                     MoreInfo(isPresenting: $viewModel.isPresentingDiscPopup, media: $viewModel.book)
                     .presentationDetents([.fraction(0.9)])
                     }*/
                    /*
                     .sheet(isPresented: $viewModel.showRateView) {
                     RateView(media: viewModel.book, isPresenting: $viewModel.showRateView, rating: $viewModel.rating, initialRating: $viewModel.initialRating)
                     .presentationDetents([.fraction(0.8)])
                     .background(viewModel.backgroundColor)
                     }*/
                    
                    
                    .navigationViewStyle(StackNavigationViewStyle())
                    /*
                     .sheet(isPresented: $showAllNotes){
                     AllNotesView(isPresenting: $showAllNotes)
                     }
                     */
                    
                    
                    
                    VStack {
                        
                      
                        //Spacer()
                        ZStack{
                            VStack{
                                if iPadOrientation && viewModel.isPresentingAddToLibrary && !viewModel.showRateView {
                                    HStack {
                                        AddToLibraryView(isPresenting: $viewModel.isPresentingAddToLibrary, media: viewModel.book, saveChanges: { book, status in
                                            
                                            if let currentStatus = userData.user.getStatus(bookid: book.id) {
                                                userData.user.addBook(book: book, status: status)
                                                
                                                notificationCoordinator.sendMarkBookStatusNotification(book: book, status: status)
                                            } else {
                                                userData.user.addBook(book: book, status: status)
                                                
                                                notificationCoordinator.sendAddedToLibraryNotification()
                                            }
                                        })
                                        .background(lightModeController.getBackgroundColor())
                                        .frame(width: 240, height: 280)
                                        .cornerRadius(7)
                                        .shadow(radius: 0.5)
                                        .padding(.bottom)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    
                                    //.padding(.vertical, -12)
                                }
                                /*
                                 if viewModel.showRateView  && !viewModel.isPresentingAddToLibrary {
                                 HStack {
                                 
                                 RateView(media: viewModel.book, isPresenting: $viewModel.showRateView, rating: $viewModel.rating, initialRating: $viewModel.initialRating)
                                 
                                 .background(lightModeController.getBackgroundColor())
                                 .frame(width: 280)
                                 .cornerRadius(7)
                                 .shadow(radius: 0.5)
                                 Spacer()
                                 
                                 
                                 }
                                 .padding(.horizontal)
                                 .padding(.vertical, -12)
                                 }*/
                                HStack(spacing: 8) {
                                    if let status: StatusType = userData.user.getStatus(bookid: viewModel.book.id){
                                        if status != nil {
                                            StatusButton(book: viewModel.book, fontSize: 14)
                                            
                                            
                                        }
                                    } else {
                                        AddToListButton(book: $viewModel.book)
                                    }
                                    
                                    if iPadOrientation {
                                        
                                        
                                        RateReviewButton(viewModel: viewModel)
                                            .cornerRadius(10)
                                        
                                        NotesButton(viewModel: viewModel, showAllNotes: $showAllNotes)
                                            .cornerRadius(10)
                                        
                                        DiscussionButton(viewModel: viewModel)
                                            .cornerRadius(10)
                                        
                                        QuotesButton(viewModel: viewModel)
                                            .cornerRadius(10)
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                    if userData.user.library.contains(viewModel.book) || viewModel.book.price == 0.0 {
                                        Button(action: {
                                            navigation.chooseBook(book: viewModel.book)
                                            navigation.goToReader()
                                            userData.user.currentReads.moveToFront(book: viewModel.book)
                                        }) {
                                            RoundedRectangle(cornerRadius: 40)
                                                .fill(
                                                    RadialGradient(
                                                        gradient: Gradient(colors: [
                                                            Color(hex: lightModeController.isDarkMode() ? "#fffdf4" : "#4A4A48"), // Lighter center
                                                            Color(hex: lightModeController.isDarkMode() ? "#f4f0ea" : "#1F1F1E")  // Darker edges
                                                        ]),
                                                        center: .center,
                                                        startRadius: 0,
                                                        endRadius: 100 // Adjust as needed for effect
                                                    )
                                                )
                                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                                .frame(height: 38)
                                                .overlay(
                                                    Text("Read")
                                                        .font(.system(size: 15, weight: .medium))
                                                        .foregroundColor(lightModeController.isDarkMode() ? .black : .white)
                                                )
                                        }
                                    } else {
                                        
                                        Button(action: {
                                            viewModel.isPresentingBuy = true
                                        }){
                                            
                                            RoundedRectangle(cornerRadius: 40)
                                                .frame(height: 38)
                                                .foregroundColor(Color(hex: lightModeController.isDarkMode() ? "#fffdf4" : "#302f2e"))
                                            
                                                .shadow(radius: 0.5)
                                                .overlay(
                                                    Text("Read $\(String(format: "%.2f", viewModel.book.price))")
                                                        .font(.system(size: 15, weight: .medium))
                                                        .foregroundColor(lightModeController.isDarkMode() ? .black : .white)
                                                    
                                                )
                                        }
                                    }
                                    
                                }
                                .padding(.top, 3)

                                .padding(.bottom)
                                .padding(.horizontal)
                                .background(lightModeController.getBackgroundColor())
                            }
                            /*
                             HStack(alignment: .center) {
                             
                             ProgressBar(totalPages: book.ebook.getPageCount(), currentPage: book.ebook.getCurrentPage() + 1, height: 1.5)
                             // .padding(.top)
                             
                             }
                             //.padding(.horizontal, UIScreen.main.bounds.width * 0.10)
                             //.frame(height: 50)
                             .background(backgroundColor)
                             .padding(.bottom, 65)*/
                        }
                    }
                    .sheet(isPresented: $showShare){
                        ShareView(isPresenting: $showShare, book: viewModel.book)
                    }
                    
                    
                    
                }
                
           
                        DiscussionView(isPresenting:  $viewModel.isPresentingDiscPopup, book: $viewModel.book, showToolbar: $showToolbar)
                    
                
                
                if viewModel.showEReader {
                    EReaderView( media: $viewModel.book, currentPageIndex: viewModel.book.currentPage ?? 0, showEReader: $viewModel.showEReader)
                }
                
                if viewModel.showReview {
                    Rectangle()
                        .ignoresSafeArea()
                        .opacity(0.2)
                    
                    ReviewView(isPresenting: $viewModel.showReview, review: $viewModel.selectedReview)
                    
                    
                }
                
                if viewModel.showCreateReview {
                    
                    CreateReview(isPresenting: $viewModel.showCreateReview, book: $viewModel.book, isReview: true, rating: viewModel.rating, showToolbar: $showToolbar)
                }
                
                if viewModel.showProfile {
                    ProfileView(user: viewModel.selectedProfile, isPresenting: $viewModel.showProfile, showToolbar: $viewModel.showToolbar)
                }
                
                if viewModel.showAuthor {
                    AuthorView(author: $viewModel.book.author, isPresenting: $viewModel.showAuthor)
                }
                
                if showAllNotes {
                    //AllNotesView(isPresenting: $showAllNotes)
                    ScrollView {
                        AllNotesView(isPresenting: $showAllNotes, showToolbar: $showToolbar, addNew: .constant(false), notes: userData.user.getNotesByBookID(bookid: viewModel.book.id), book: viewModel.book, showNote: $showNote, selectedNote: $selectedNote, showCharacter: $showCharacter, selectedCharacter: $selectedCharacter)
                    }


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

struct RateReviewButton: View {
    @StateObject var viewModel: ContentViewModel
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        if let rating = userData.user.getRating(bookid: viewModel.book.id) {
            Button(action: {
                viewModel.initialRating = rating.stars
                viewModel.showRateView = true
            }){
                VStack(alignment: .trailing){
                    HStack {
                        Text("You Rated:")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(lightModeController.getForegroundColor())
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.orange)
                                .padding(.trailing, -5)
                            
                            
                            Text("\(String(format: "%.1f", rating.stars))")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(lightModeController.getForegroundColor())
                            
                        }
                    }
                    
                    .padding(7)
                    .background(Color(hex: "#291F00").opacity(0.05))
                    
                }
            }
        } else {
            Button(action: {
                viewModel.initialRating = 5.0
                viewModel.showRateView.toggle()
            }){
                Text("Rate / Review")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(.black))
                    .frame(height: 38)
                    .padding(.horizontal)
                
                    .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#ECE8DA").opacity(0.5))
            }
            
        }
    }
}

struct NotesButton: View {
    @StateObject var viewModel: ContentViewModel
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController
    @Binding var showAllNotes: Bool
    @State var fontSize = 14.0
    @State var frameHeight = 38.0

    var body: some View {
        let allNotes = userData.user.getNotesByBookID(bookid: viewModel.book.id)
        if let status: StatusType = userData.user.getStatus(bookid: viewModel.book.id){
            Button(action: {
                showAllNotes = true
                //navigation.goToFeed()
                //navigation.chooseBook(book: book)
            }){
                HStack {
                    if allNotes.count > 0 {
                        Text("Notes")
                            .padding(.trailing, -2)
                        
                        Text("\(allNotes.count)")
                            .font(.system(size: fontSize, weight: .medium))
                        
                    } else {
                        Text("Notes")

                        /*Image(systemName: "plus")
                            .font(.system(size: 13, weight: .medium))
                        Text("Note")
                            .padding(.leading, -4)*/
                        
                    }
                    
                    
                }
                .font(.system(size: fontSize, weight: .medium))
                .foregroundColor(.black)
                .frame(height: frameHeight)
                .padding(.horizontal)
                
                .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#ECE8DA").opacity(0.5))
            }
        }
    }
}

struct DiscussionButton: View {
    @StateObject var viewModel: ContentViewModel
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController
    @State var fontSize = 14.0
    @State var frameHeight = 38.0

    var body: some View {
        Button(action: {viewModel.isPresentingDiscPopup = true}){
            HStack{

                if viewModel.book.getPostCount() > 0 {
                    Text("\(viewModel.book.getPostCount())")
                        .font(.system(size: 13, weight: .medium))
                        .padding(.trailing, -4)
                }
                
                Image(systemName: "message")
                   // .padding(.trailing, -2)
               
                
            }
            .font(.system(size: fontSize, weight: .medium))
            .foregroundColor(.black)
            .frame(height: frameHeight)
            .padding(.horizontal)
            .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#ECE8DA").opacity(0.5))
        }
    }
}

struct QuotesButton: View {
    @StateObject var viewModel: ContentViewModel
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController
    @State var fontSize = 14.0
    @State var frameHeight = 38.0
    var body: some View {
        Button(action: {
            viewModel.showQuotes.toggle()
        }){
            HStack{
                Image(systemName: "quote.opening")
                    .padding(.trailing, -2)
                
                
            }
            .font(.system(size: fontSize, weight: .medium))
            .foregroundColor(.black)
            .frame(height: frameHeight)
            .padding(.horizontal)
            .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#ECE8DA").opacity(0.5))
        }
    }
}

struct BookQuotesView: View {
    @State var book: Book
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
            VStack {
                HStack {
                    
                    Text("\"\(book.title)\"")
                        .font(.system(size: 17, weight: .medium))
                        .lineLimit(1)
                    
                    Spacer()
                   /*
                    Text("\(book.author.name)")
                        .font(.system(size: 14.5, weight: .medium))
                        .lineLimit(1)*/
                }
                .padding(.vertical)
                .padding([.horizontal, .top])

                ScrollView {
                    VStack() {
                        QuotePreview(quote: Quote(quote: "I believe that imagination is stronger than knowledge. That myth is more potent than history. That dreams are more powerful than facts. That hope always triumphs over experience. That laughter is the only cure for grief. And I believe that love is stronger than death.", book: Book(title: "All I Really Need to Know", author: Author(name: "Robert Fulghum"))))
                        QuotePreview(quote: Quote(quote: "and the moment you doubt whether you can fly, you cease forever to be able to do it. The reason birds can fly and we can't is simply that they have perfect faith, for to have faith is to have wings.", book: Book(title: "Peter Pan", author: Author(name: "Daniel O'Connor"))))
                        QuotePreview(quote: Quote(quote: "I believe that imagination is stronger than knowledge. That myth is more potent than history. That dreams are more powerful than facts. That hope always triumphs over experience. That laughter is the only cure for grief. And I believe that love is stronger than death.", book: Book(title: "All I Really Need to Know", author: Author(name: "Robert Fulghum"))))
                        QuotePreview(quote: Quote(quote: "and the moment you doubt whether you can fly, you cease forever to be able to do it. The reason birds can fly and we can't is simply that they have perfect faith, for to have faith is to have wings.", book: Book(title: "Peter Pan", author: Author(name: "Daniel O'Connor"))))
                    }
                    .padding()

            }
        }

    }
}
                             


struct QuotePreview: View {
    @State var quote: Quote
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isLiked: Bool = false
    @EnvironmentObject var userData: UserData
    @State var replying = false
    @State var replyTo = Comment()
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        VStack(alignment: .leading) {
            
            Image("quoteicon2")
                .resizable()
                .scaledToFit()
                .frame(width: iPadOrientation ? 30 : 16)
                .padding(.bottom, 3)

            HStack(alignment: .top) {
               /* Image("quoteicon2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iPadOrientation ? 30 : 15)*/
                
                
                VStack(alignment: .leading) {
                    
                    Text(quote.quote)
                        .font(.custom("Georgia", size: 14))
                        .lineSpacing(8)
                        .lineLimit(9)
                        .padding(.trailing, 10)
                  

                    
                        
                
            
                }
                .padding(.leading, 25)
                
            }
            .padding(.bottom)
            
            HStack {
                Text("\(quote.likes) likes")
                    .padding(.trailing)
                Text("\(quote.comments.count) comments")
            
                Spacer()
                if !isLiked {
                    Button(action: {
                        isLiked.toggle()
                        quote.likes += 1
                        
                    }){
                        Image(systemName: "heart")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                } else {
                    Button(action: {
                        isLiked.toggle()
                        quote.likes -= 1
                        
                    }){
                        Image(systemName: "heart.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.pink)
                    }
                }

            }
            .padding(.leading, 25)
            .font(.system(size: 12))
            .opacity(0.7)
            .padding(.top)

        }
        .padding(25)
        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
        .background(RoundedRectangle(cornerRadius: 10)
            .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
            .fill(Color(hex: "#fffffc").opacity(0.7))
        )

    }
}

struct UpvoteButton: View {
    @Binding var post: Note
    @Binding var isUpvoted: Bool
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        Button(action: {
            isUpvoted.toggle()
            post.upvote()
        }){
            HStack {
                let netVotes = post.getNetVotes()
               
                Image(systemName: "chevron.up")
                    .padding(.vertical, 8)
                    .font(.system(size: 14.5, weight: .bold))
                    .foregroundColor(isUpvoted ? Color(.black) : Color(.black).opacity(0.4))
                if netVotes > 0 {
                    Text(formatLargeNumber(netVotes))
                        .padding(.leading, -3.5)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(.black))

                }
                
                /* .background(RoundedRectangle(cornerRadius: 40)
                 .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                 .fill(isUpvoted ? Color(.pink).opacity(0.6) : Color(hex: "#fffffc").opacity(0.7))
                 )*/
            }

        }
    }
}

struct CommentButton2: View {
    @Binding var post: Note
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        Button(action: {
            //post.upvote()
        }){
            HStack {
                let comments = post.comments
               
                Image(systemName: "message")
                    .padding(.vertical, 8)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(.black))
                if comments.count > 0 {
                    Text(formatLargeNumber(comments.count))
                        .padding(.leading, -3.5)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(.black))

                }
                
                
                /* .background(RoundedRectangle(cornerRadius: 40)
                 .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                 .fill(isUpvoted ? Color(.pink).opacity(0.6) : Color(hex: "#fffffc").opacity(0.7))
                 )*/
            }
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
            )

        }
    }
}

struct DownvoteButton: View {
    @Binding var post: Note
    @Binding var isDownvoted: Bool

    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        HStack {
            Button(action: {
                isDownvoted.toggle()
                post.downvote()
                
            }){
                Image(systemName: "chevron.down")
                    .padding(.vertical, 8)
                    .font(.system(size: 14.5, weight: .bold))
                    .foregroundColor(isDownvoted ? Color(.black) : Color(.black).opacity(0.4))
                
                /*.background(RoundedRectangle(cornerRadius: 40)
                 .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                 .fill(isDownvoted ? Color(.purple).opacity(0.6) : Color(hex: "#fffffc").opacity(0.7))
                 )*/
            }
            
        }
    }
}

struct UpvoteDownvote: View {
    @State var isUpvoted = false
    @State var isDownvoted = false
    @Binding var post: Note
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        
        HStack {
            HStack {
                UpvoteButton(post: $post, isUpvoted: $isUpvoted)
                Divider()
                    .opacity(0.8)
                DownvoteButton(post: $post, isDownvoted: $isDownvoted)
            }
            .padding(.horizontal, 6)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
            )
            CommentButton2(post: $post)
                .padding(.leading, 4)
            
        }
        .onChange(of: isUpvoted){
            if isUpvoted {
                isDownvoted = false
            }
        }
        .onChange(of: isDownvoted){
            if isDownvoted {
                isUpvoted = false
            }
        }
    }
}
struct PinnedQuotePreview: View {
    @State var quote: Quote
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isLiked: Bool = false
    @EnvironmentObject var userData: UserData
    @State var replying = false
    @State var replyTo = Comment()
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        VStack(alignment: .leading) {
            
            Image("quoteicon2")
                .resizable()
                .scaledToFit()
                .frame(width: iPadOrientation ? 30 : 16)
                .padding(.bottom, 3)

            HStack(alignment: .top) {
               /* Image("quoteicon2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iPadOrientation ? 30 : 15)*/
                
                
                VStack(alignment: .leading) {
                    
                    Text(quote.quote)
                        .font(.custom("Georgia", size: 14))
                        .lineSpacing(8)
                        .lineLimit(9)
                        .padding(.trailing, 10)
                  

                    
                        
                
                   Text("— \(quote.book.author.name), \(quote.book.title)")
                        .lineLimit(1)
                        .font(.custom("Georgia", size: 12))
                        .padding(.top, 6)
                
                
                   
                /*
                    HStack {
                        Text("3 Comments")
                            .font(.system(size: 13.5, weight: .medium))
                        Spacer()
                    }
                    .padding(.top)
                    EComment(comment: Comment(user: userData.user, comment: "this is my favorite line from the book"), replying: $replying, replyTo: $replyTo)
                        .padding(.top, 2)*/
                }
                .padding(.leading, 25)
                
            }
            .padding(.bottom)
            
            HStack {
                if quote.likes > 0 {
                    Text("\(quote.likes) likes")
                        .padding(.trailing)
                }
                if quote.comments.count > 0 {
                    Text("\(quote.comments.count) comments")
                }
                Spacer()
                if !isLiked {
                    Button(action: {
                        isLiked.toggle()
                        quote.likes += 1
                        
                    }){
                        Image(systemName: "heart")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                } else {
                    Button(action: {
                        isLiked.toggle()
                        quote.likes -= 1
                        
                    }){
                        Image(systemName: "heart.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.pink)
                    }
                }

            }
            .padding(.leading, 25)
            .font(.system(size: 12))
            .opacity(0.7)
            .padding(.top)

        }
        .padding(25)
        .frame(width: iPadOrientation ? calculateWidth(refWidth: 720) : UIScreen.main.bounds.width * 0.95)
        .background(RoundedRectangle(cornerRadius: 10)
            .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
            .fill(Color(hex: "#fffffc").opacity(0.7))
        )

    }
}
struct ShareView: View {
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var isPresenting: Bool
    @State private var isShowingShareSheet = false
    @State private var isShowingMessageCompose = false
    @State var book: Book
    @EnvironmentObject var sphereUsers: SphereUsers
    
    @State var searchText = ""
    @State  var searched = false
    @State var isTextFieldFocused = false
    @State var xoffset = 0.0
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Share")
                    .font(.system(size: 15, weight: .medium))
                Spacer()
                
                Button(action:{
                    isPresenting.toggle()
                }){
                    Image(systemName: "xmark")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.black)
                }

                
            }
            .padding(.bottom)

            HStack(spacing: 14) {
                Button(action: {
                    isShowingMessageCompose = true
                    //isShowingShareSheet = true
                }){
                    VStack {
                        Image(systemName: "message.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 40))
                        
                        Text("Message")
                    }
                }
                
                VStack {
                    Image(systemName: "envelope.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)


                    Text("Mail")
                }
                
                VStack {
                    Image(systemName: "link.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color(hex: "#5A6378"))


                    Text("Copy Link")
                }
                Button(action: {
                    isShowingShareSheet = true
                }){
                    VStack {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)

                        Text("Other")
                        
                        
                    }
                }
                Spacer()
                
            }
            .padding(.vertical)
            .font(.system(size: 13))
            .foregroundColor(.black)
            
            Text("Recommend this book")
                .font(.system(size: 14.5))

            
            HStack(){
              
                
                TextField("Search friends", text: $searchText)
                    .onTapGesture {
                        // When the TextField is tapped, set isTextFieldFocused to true
                        isTextFieldFocused = true
                    }
                    .font(.system(size: 16.5))
                    .foregroundColor(.black)
                    .padding(10)
                    //.padding(.vertical, 2)
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
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            Spacer()
                        }
                    )
                    .background(Color(.black).opacity(0.05))
                    .cornerRadius(10)
                    
                

                
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
            
            
           /* Text("Search friends")
                .font(.system(size: 14.5))
*/
            let following = sphereUsers.getUsersById(userIds: userData.user.getAllFollowingIDs())
            ScrollView(.horizontal) {
                HStack(spacing: 14) {
                    ForEach(Array(following.enumerated()), id: \.element.id) { index, user in
                        VStack {
                            
                            ProfileThumbnail(image: user.photo, size: 45)
                            
                            
                            Text(user.name)
                                .font(.system(size: 12))
                            
                            
                        }
                    }
                    
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top)
            
        }
        .padding()
        .sheet(isPresented: $isShowingMessageCompose) {
            MessageComposeViewController(recipients: nil, body: "Check out \"\(book.title)\" on Sphere: https://example.com")
        }
        .sheet(isPresented: $isShowingShareSheet) {
            ActivityViewController(activityItems: [URL(string: "https://example.com")!], applicationActivities: nil)
        }
        .background(backgroundColor)
        

        
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
}


struct MessageComposeViewController: UIViewControllerRepresentable {
    var recipients: [String]?
    var body: String?

    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        var parent: MessageComposeViewController

        init(_ parent: MessageComposeViewController) {
            self.parent = parent
        }

        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        controller.messageComposeDelegate = context.coordinator
        controller.recipients = recipients
        controller.body = body
        return controller
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}

    static func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
}


struct SearchNotesView: View {
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
    @State var searching = false

    
    var body: some View {
        let allBooks = user.getAllBooks()
        
        ZStack {

            VStack(alignment: .leading) {
                    SearchNotesBar2(isPresenting: $searching, book: selectedBook ?? Book(), showToolbar: $showToolbar)
                        .padding(.top)
                    // Side bar
                ScrollView(.horizontal) {
                            HStack(alignment: .center) {
                                
                                Button(action: {
                                    choosingBook.toggle()
                                }) {
                                    Text("All")
                                        .font(.system(size: 14, weight: .medium))
                                        .padding(.vertical)
                                        .frame(height: 90)
                                        .padding(7)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: 40)
                                                .foregroundColor( Color(.gray).opacity(0.2))
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
                                                    .frame(height: 90)
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
                        //.frame(height: UIScreen.main.bounds.width * 0.1)
                       // .padding(.top, UIScreen.main.bounds.height * 0.04)
                        .padding(.top)
                        .padding(.leading)

                    
                    // Selected Notes
                    VStack {
                        if showRecent {
                            ScrollView {
                                RecentNotesView(isPresenting: .constant(true), notes: user.getAllNotes(), showNote: $showNote, selectedNote: $selectedNote, selectedBook: selectedBook ?? Book(), showToolbar: $showToolbar)
                                   // .padding(.trailing, UIScreen.main.bounds.width * 0.05)
                            }
                        } else {
                            ScrollView {
                                AllNotesList(isPresenting: .constant(true), showToolbar: $showToolbar, addNew: .constant(false), notes: selectedNotes, book: selectedBook ?? Book(), showNote: $showNote, selectedNote: $selectedNote, showCharacter: $showCharacter, selectedCharacter: $selectedCharacter)
                                    .onChange(of: selectedNotes) { _ in
                                        selectedChapter = nil
                                    }
                                   // .padding(.trailing, UIScreen.main.bounds.width * 0.05)
                            }
                        }
                    }
                    Spacer()

                }

            
            .onDisappear {
                navigation.reset()
            }
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
                NoteView(isPresenting: $showNote, note: $selectedNote, fullScreen: $fullScreen)
                    .onAppear {
                        showToolbar = false
                    }
                    .onDisappear{
                        showToolbar = true
                    }
                
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


struct SearchSelectNoteFromBook: View {
    @EnvironmentObject var userData: UserData
    @State var book: Book
    @State var selectedNote: Note = Note()
    @State var selectedNotes: [UUID: Note] = [:]
    @State var searching = false
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Publish Note")

                    Text(book.title)
                        .font(.system(size: 13, weight: .medium))
                    Spacer()
                    
                }
                .padding(.top)
                
                if searching {
                    
                } else {
                    
                    ForEach(userData.user.getNotesByBookID(bookid: book.id)) { note in
                        HStack {
                            
                            if selectedNotes[note.id] == nil {
                                Image(systemName: "rectangle.portrait")
                                    .font(.system(size: 16))
                                    .padding(.horizontal)
                            } else {
                                Image(systemName: "checkmark.rectangle.portrait")
                            }
                            Button(action: {
                                selectedNotes[note.id] = note
                                
                            }){
                                NotePreview(note: note, showNote: .constant(false), selectedNote: $selectedNote, showBook: .constant(false), selectedBook: .constant(Book()), showPostActions: .constant(false), showProfile: .constant(false), selectedProfile: .constant(User()))
                            }
                            
                        }
                        
                    }
                }
                Spacer()
            }
            .padding(.horizontal)

        }
        .background(backgroundColor)
    }
}

struct FeedbackView: View {
    @Binding var isPresenting: Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Feedback")
                    .font(.system(size: 20, weight: .medium))
                    .padding(.bottom)
                
                Spacer()
            }
            
            Text("Sphere is built by a small team of developers. We love your feedback.")
                .font(.system(size: 15))
                .padding(.bottom, 20)

            
            
            Text("Tell us about:")
                .font(.system(size: 15))

            Text("- Encountered bugs")
                .font(.system(size: 15))

            Text("- Feature requests")
                .font(.system(size: 15))

            Text("- Anything else you want us to know")
                .font(.system(size: 15))
            
            CustomTextEditor(text: $text)
                .padding(.horizontal, 6)
                .font(.system(size: 17))
                .frame(width: 650, height: 150)
                //.background(secondaryColor)
                .cornerRadius(10)
                .padding(.top)
            
            //checkbox here
            // "Recieve updates"

            
            
 Spacer()
            
        }
        .padding()
        .padding()

        .background(backgroundColor)
    }
}
struct RateView: View {
    @State var media : Book
    @Binding var isPresenting: Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var rating: Float
    
    @EnvironmentObject var userData : UserData
    @Binding var initialRating: Float
    //@State private var rating: Double = 5.0 // Default rating
    @State var showCreateReview : Bool = false
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                /*
                Text("Rate")
                    .font(.system(size: 14, weight: .medium))
                    .padding(.top)
                */
                HStack {
                    Text("Rate \"\(media.title)\"")
                        .font(.system(size: 17, weight: .medium))
                        .padding(.top)
                    Spacer()
                    
                  /*  Button(action:{
                        isPresenting.toggle()
                    }){
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.black)
                    }*/
                    
                }
                /*
                HStack{
                    Image(media.cover)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 0.5)
                        .padding(.top, 40)
                    
                    
                }*/
                
               /* HStack {
                    Text("Your Rating:")
                        .font(.system(size: 14, weight: .medium))
                    */
                RateAndReview(rating: $rating, selectedRating: initialRating)
                //}
                
                
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showCreateReview = true
                        rateBook(rating: Float(rating))
                        // isPresenting = false
                        
                    }){
                        HStack {
                            Image(systemName: "plus")
                                .font(.system(size: 14.5, weight: .medium))
                            
                            Text("Add Review")
                                .padding(.leading, -4)
                                .font(.system(size: 14.5, weight: .medium))
                        }
                        .foregroundColor(lightModeController.getForegroundColor())
                        .padding(8)
                        .padding(.horizontal, 2)
                        .background(lightModeController.getForegroundColor().opacity(0.05))
                        .cornerRadius(30)
                    }
                }
                .padding(.bottom)
                
                Button(action: {
                    
                    rateBook(rating: Float(rating))
                    isPresenting.toggle()
                    
                    
                    
                }){
                    RoundedRectangle(cornerRadius: 40)
                        .overlay(
                            Text("Done")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                        )
                        .frame(height: 38)
                        .foregroundColor(Color(.black).opacity(0.7))
                        
                }
                .padding(.bottom)
                
                
                //Spacer()
            }
            .padding(.horizontal)

            .sheet(isPresented: $showCreateReview) {
                CreateReview(isPresenting: $showCreateReview, book: $media, isReview: true, rating: rating, showToolbar: .constant(false))
            }
        }
        .background(backgroundColor)
        
    }
    
    func rateBook(rating: Float) {
        /*
            // If the book is already rated, remove the old rating
            userData.user.ratings.remove(at: index)
        } else {
            userData.user.pastReads.books.append(media)
            userData.user.library.append(media)
        }*/
        
        
            //print(rating)
            // Add the new rating
            let newRating = Rating(id: UUID(), user: userData.user, book: media, stars: rating)
            userData.user.addRating(rating: newRating)
        
            userData.user.changeBookStatus(book: media, newStatus: .read)


    }

        // media.ratings.append(newRating)
        
    
}



struct RateAndReview: View {
    @Binding var rating: Float // Default rating
    @State var selectedRating: Float // For internal state

    var body: some View {
        VStack {
     

            

                Picker("Rating", selection: $selectedRating) {
                        ForEach(0..<9) { index in
                            HStack {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.orange)
                                    .padding(.trailing, -3)
                                let value = 5.0 - Float(index) * 0.5
                                Text(String(format: "%.1f", value))
                                    .tag(value)
                                    .font(.system(size: 26))

                            }
                            .padding(.vertical)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100, height: 150)
                .clipped()
            
        }
        .onAppear {
            selectedRating = rating // Initialize picker with current rating
        }
        .onChange(of: selectedRating) { newValue in
            rating = newValue // Update binding when picker changes
        }
    }
}



/*
struct iPadContentView: View 
 
 
 
*/
struct StatusView: View {
    @State var changeStatus: Bool = false
    @State var status: StatusType
    @State var fontSize: Double = 13.0
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var notificationCoordinator: NotificationCoordinator

    var body: some View {
        // if read
        if status == .read {
            
       
                Text("Read")
                    .padding(7)
                    .font(.system(size: fontSize, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(.black)

                    .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(hex: "e9f7e4"))
                
                    )
            
            

                
            
        } else if status == .current {
            // if currently reading
      
                Text("Reading")
                    .padding(7)
                    .font(.system(size: fontSize, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(.black)

                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor( Color(hex: "#f7ecf2"))
                    )
                
            
        } else {
            // if tbr
                Text("To be Read")
                    .padding(7)
                    .font(.system(size: fontSize, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(.black)

                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color(hex: "#fff8db"))
                    )
            
            
        
        }
    }
}

struct AddToListButton: View {
    @State var isPresentingAddToLibrary: Bool = false
    @Binding var book: Book
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var lightModeController: LightModeController
    @State var fontSize: Double = 14.0
    @EnvironmentObject var notificationCoordinator: NotificationCoordinator

    
    var body: some View {

            
            Button(action: {
                isPresentingAddToLibrary = true
            }){
                if let status: StatusType = userData.user.getStatus(bookid: book.id){
                    HStack{
                        Image(systemName: "checkmark")
                    }
                    .font(.system(size: fontSize - 2, weight: .medium))
                    .foregroundColor(lightModeController.isDarkMode() ? .white : .black)
                    .frame(width: 3 * fontSize, height: fontSize * 2.68)
                    //.padding(.horizontal)
                    
                    .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#fffdf4").opacity(0.2))
                    .cornerRadius(10)
                    
                } else {
                    HStack{
                        Image(systemName: "plus")
                    }
                    .font(.system(size: fontSize, weight: .medium))
                    .foregroundColor(lightModeController.isDarkMode() ? .white : .black)
                    .frame(width: 3.8 * fontSize, height: fontSize * 2.714)
                    //.padding(.horizontal)
                    
                    .background(lightModeController.isDarkMode() ? Color(hex: "#fffdf4").opacity(0.1) : Color(hex: "#ECE8DA").opacity(0.5))
                    .cornerRadius(10)
                    
                }
            }
    
            .sheet(isPresented: $isPresentingAddToLibrary){
                    AddToLibraryView(isPresenting: $isPresentingAddToLibrary, media: book, saveChanges: { book, status in
                        if let currentStatus = userData.user.getStatus(bookid: book.id) {
                            userData.user.addBook(book: book, status: status)
                            
                            notificationCoordinator.sendMarkBookStatusNotification(book: book, status: status)
                        } else {
                            userData.user.addBook(book: book, status: status)
                            
                            notificationCoordinator.sendAddedToLibraryNotification()
                        }

                    })
                    .presentationDetents([.fraction(0.8)])

                
            }
            .onChange(of: notificationCoordinator.changeButtonTriggered){
                    isPresentingAddToLibrary = true
                
                
            }
            
          
            
 
        
    }
}


/*
 func loadImageColors() {
     guard let uiImage = UIImage(named: media.cover) else {
         return
     }

     uiImage.getColors { colors in
         // Use the extracted colors here
         dominantColors = colors
         
         // Move the code that depends on dominantColors inside this completion closure
         let primarySaturation = Color(dominantColors?.primary ?? .clear).saturation
         let backgroundSaturation = Color(dominantColors?.background ?? .clear).saturation
         let secondarySaturation = Color(dominantColors?.secondary ?? .clear).saturation
         let detailSaturation = Color(dominantColors?.detail ?? .clear).saturation

         if primarySaturation > backgroundSaturation {
             color1 = dominantColors?.primary
         } else {
             color1 = dominantColors?.background
         }
         
         if secondarySaturation > detailSaturation {
             color2 = dominantColors?.secondary
         } else {
             color2 = dominantColors?.detail
         }
     }

     
     
     if let color1 = color1, let color2 = color2 {
         // Compare brightness of color1 and color2
         if Color(color1).brightness > Color(color2).brightness {
             // Swap colors if color1 is brighter than color2
             let temp = color1
             self.color1 = color2
             self.color2 = temp
         }
     }

 }

 */

struct MarkStatusView: View {
    @EnvironmentObject var userData: UserData
    @Binding var isPresenting : Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    var media : Book
    @Binding var selected : Int
    
    var body: some View {
        
        NavigationView {
            VStack{
                
                HStack{
                    Button(action: {
                        isPresenting = false
                    }){
                        Text("Cancel")
                            .font(.system(size: 15, weight: .regular))

                    }
                    .opacity(0)

                    Spacer()
                    Text("Mark Status")
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                    Button(action: {
                        isPresenting = false
                        
                    }){
                        Text("Cancel")
                            .font(.system(size: 15, weight: .regular))

                            .foregroundColor(.black)

                    }

                }
                .padding()
                
                    Button(action: {
                        selected = 1
                    }){
                        
                        HStack(){
                            
                            HStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 4.0)
                                    .frame(width: 60, height: 90)
                                    .foregroundColor(.gray)
                                VStack(alignment: .leading){
                                    Text("To Be Read")
                                        .font(.system(size: 15, weight: .medium))
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 8)
                                        .foregroundColor(.black)
                                        .background(Color(.yellow).opacity(0.1))
                                        .cornerRadius(8)

                                    Text("\(userData.user.readingList.books.count) books")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(.black)
                                    
                                }
                            }
                            Spacer()
                            ZStack{
                                Circle()
                                    .foregroundColor(.black)
                                    .frame(width: 20, height: 20)
                                Circle()
                                    .foregroundColor(backgroundColor)
                                    .frame(width: 16, height: 16)
                                if selected == 1 {
                                    
                                    Circle()
                                        .foregroundColor(.black)
                                        .frame(width: 13, height: 13)
                                }
                            }
                        }
                    }
                    .padding()
                
                HStack(){
                    HStack(alignment: .top){
                        RoundedRectangle(cornerRadius: 4.0)
                            .frame(width: 60, height: 90)
                            .foregroundColor(.gray)
                        VStack(alignment: .leading){
                            Text("Reading")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(Color(.purple).opacity(0.1))
                                .cornerRadius(8)

                            
                            Text("\(userData.user.currentReads.books.count) books")
                                .font(.system(size: 15, weight: .regular))
                            
                        }
                    }
                    Spacer()
                    Button(action: {
                        selected = 2
                    }){
                        ZStack{
                            Circle()
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20)
                            Circle()
                                .foregroundColor(backgroundColor)
                                .frame(width: 16, height: 16)
                            if selected == 2 {
                                
                                Circle()
                                    .foregroundColor(.black)
                                    .frame(width: 13, height: 13)
                            }
                        }
                    }
                    
                }
                .padding()
                
                HStack(){
                    HStack(alignment: .top){
                        RoundedRectangle(cornerRadius: 4.0)
                            .frame(width: 60, height: 90)
                            .foregroundColor(.gray)
                        VStack(alignment: .leading){
                            Text("Read")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(Color(.green).opacity(0.1))
                                .cornerRadius(8)

                            Text("\(userData.user.pastReads.books.count) books")
                                .font(.system(size: 15, weight: .regular))
                            
                        }
                    }
                    Spacer()
                    Button(action: {
                        selected = 3
                    }){
                        ZStack{
                            Circle()
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20)
                            Circle()
                                .foregroundColor(backgroundColor)
                                .frame(width: 16, height: 16)
                            if selected == 3 {
                                
                                Circle()
                                    .foregroundColor(.black)
                                    .frame(width: 13, height: 13)
                            }
                        }
                    }
                    
                }
                .padding()
                
            
                Spacer()
                
                HStack(){
                    HStack(alignment: .top){
                       
                        VStack(alignment: .leading){
                            Text("Create New List")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(Color(.purple).opacity(0.1))
                                .cornerRadius(8)

                            
                            
                        }
                    }
                    Spacer()
                    Button(action: {
                        
                    }){
                        ZStack{
                            Image(systemName: "plus")
                        }
                    }
                    
                
                
                
            }
            .padding()
                
                Spacer()
                if selected != 0 {
                    Button(action: {
                        
                        if selected == 1 {
                            var books = userData.user.readingList.books
                                books.insert(media, at: 0)
                                userData.user.readingList.books = books
                             
                        } else if selected == 2 {
                          var books = userData.user.currentReads.books
                            
                                books.insert(media, at: 0)
                                userData.user.currentReads.books = books
                                //userData.user.library.append(
                           
                        } else if selected == 3 {
                       var books = userData.user.pastReads.books
                                books.insert(media, at: 0)
                                userData.user.pastReads.books = books
                            }
                        
                        isPresenting = false
                        
                    }){
                        RoundedRectangle(cornerRadius: 16.0)
                            .frame(width: 370, height: 50)
                            .foregroundColor(Color(hex: "#291F00"))
                            .opacity(0.1)
                            .overlay(
                                Text("Done")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .medium))
                            
                            )

                    }
                    
                    .padding(.horizontal)
                }
            }
            .background(backgroundColor)
            
        }
        
    }
    
}
/*
struct AddToLibraryView : View {
    @EnvironmentObject var userData: UserData
    @Binding var isPresenting : Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    var media : Book
    @State var selected : Int = 0
    
    var body: some View {
        
            VStack{
                
                HStack{
                    Button(action: {
                        isPresenting = false
                    }){
                        Text("Cancel")
                            .font(.system(size: 15, weight: .regular))

                    }
                    .opacity(0)

                    Spacer()
                    Text("Add To Library")
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                    Button(action: {
                        isPresenting = false
                        
                    }){
                        Text("Cancel")
                            .font(.system(size: 15, weight: .regular))

                            .foregroundColor(.black)

                    }

                }
                .padding()
                
                    Button(action: {
                        selected = 1
                    }){
                        
                        HStack(){
                            
                            HStack(alignment: .top){
                                RoundedRectangle(cornerRadius: 4.0)
                                    .frame(width: 60, height: 90)
                                    .foregroundColor(.gray)
                                VStack(alignment: .leading){
                                    Text("My List")
                                        .font(.system(size: 15, weight: .medium))
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 8)
                                        .foregroundColor(.black)
                                        .background(Color(.yellow).opacity(0.1))
                                        .cornerRadius(8)

                                    Text("\(userData.user.readingList.books.count) books")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(.black)
                                    
                                }
                            }
                            Spacer()
                            ZStack{
                                Circle()
                                    .foregroundColor(.black)
                                    .frame(width: 20, height: 20)
                                Circle()
                                    .foregroundColor(backgroundColor)
                                    .frame(width: 16, height: 16)
                                if selected == 1 {
                                    
                                    Circle()
                                        .foregroundColor(.black)
                                        .frame(width: 13, height: 13)
                                }
                            }
                        }
                    }
                    .padding()
                
                HStack(){
                    HStack(alignment: .top){
                        RoundedRectangle(cornerRadius: 4.0)
                            .frame(width: 60, height: 90)
                            .foregroundColor(.gray)
                        VStack(alignment: .leading){
                            Text("Currently Reading")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(Color(.purple).opacity(0.1))
                                .cornerRadius(8)

                            
                            Text("\(userData.user.currentReads.books.count) books")
                                .font(.system(size: 15, weight: .regular))
                            
                        }
                    }
                    Spacer()
                    Button(action: {
                        selected = 2
                    }){
                        ZStack{
                            Circle()
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20)
                            Circle()
                                .foregroundColor(backgroundColor)
                                .frame(width: 16, height: 16)
                            if selected == 2 {
                                
                                Circle()
                                    .foregroundColor(.black)
                                    .frame(width: 13, height: 13)
                            }
                        }
                    }
                    
                }
                .padding()
                
                HStack(){
                    HStack(alignment: .top){
                        RoundedRectangle(cornerRadius: 4.0)
                            .frame(width: 60, height: 90)
                            .foregroundColor(.gray)
                        VStack(alignment: .leading){
                            Text("Read")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(Color(.green).opacity(0.1))
                                .cornerRadius(8)

                            Text("\(userData.user.pastReads.books.count) books")
                                .font(.system(size: 15, weight: .regular))
                            
                        }
                    }
                    Spacer()
                    Button(action: {
                        selected = 3
                    }){
                        ZStack{
                            Circle()
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20)
                            Circle()
                                .foregroundColor(backgroundColor)
                                .frame(width: 16, height: 16)
                            if selected == 3 {
                                
                                Circle()
                                    .foregroundColor(.black)
                                    .frame(width: 13, height: 13)
                            }
                        }
                    }
              
                
            
                Spacer()
                
               
                    
                
                
                
            }
            .padding()
                
                Spacer()
                if selected != 0 {
                    Button(action: {
                        
                        if selected == 1 {
                            
                            userData.user.addBook(book: media, status: .tbr)
                             
                        } else if selected == 2 {
                            userData.user.addBook(book: media, status: .current)

                           
                        } else if selected == 3 {
                            userData.user.addBook(book: media, status: .read)
                        }
                        
                        isPresenting = false
                        
                    }){
                        RoundedRectangle(cornerRadius: 16.0)
                            .frame(width: 370, height: 50)
                            .foregroundColor(Color(hex: "#291F00"))
                            .opacity(0.1)
                            .overlay(
                                Text("Done")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .medium))
                            
                            )

                    }
                    
                    .padding(.horizontal)
                }
            }
            .background(backgroundColor)
            
        
        
    }
    
}*/



struct AddToLibraryView: View {
    @EnvironmentObject var userData: UserData
    @Binding var isPresenting: Bool
    var media: Book
    @State private var selectedStatus: StatusType = .tbr
    private let statuses: [StatusType] = [.tbr, .current, .read]
    var saveChanges: (Book, StatusType) -> Void
    @State var title = ""
    @State var description = ""

    @State var searchText = ""
    @State var isTextFieldFocused = false

    @State var addToLists: [UUID: List] = [:]
    @State var createNewList = false
    @State var isPrivate = false
    @EnvironmentObject var lightModeController: LightModeController
    @EnvironmentObject var notificationCoordinator: NotificationCoordinator

    var filteredLists: [List] {
            if searchText.isEmpty {
                return userData.user.lists
            } else {
                return userData.user.lists.filter { $0.title.lowercased().hasPrefix(searchText.lowercased()) }
            }
        }
    
    var body: some View {
        VStack {
            HStack {
         
                Text("\(media.title)")
                    .font(.custom("Baskerville", size: 17).weight(.medium))
                    .scaleEffect(x: 1.0, y: 1.15)
                    .lineLimit(1)
                    /*Spacer()
                Button(action: {
                    isPresenting = false
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                }*/
                Spacer()
            }
            .padding(.vertical)
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(spacing: 6){
                        
                        ForEach(statuses, id: \.self) { status in
                            
                            HStack {
                                
                                
                                VStack(alignment: .leading) {
                                    Text(status.displayName)
                                        .font(.system(size: 15, weight: .medium))
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 8)
                                        .foregroundColor(.black)
                                        .background(status.color)
                                        .cornerRadius(8)
                                    
                                }
                                .opacity(selectedStatus == status ? 1 : 0.5)
                                Spacer()
                                
                                
                                
                                ZStack {
                                    if selectedStatus == status {
                                        Image(systemName: "checkmark.circle.fill")
                                            .frame(width: 20, height: 20)
                                            .opacity(0.8)
                                    } else {
                                        Circle()
                                            .foregroundColor(lightModeController.getBackgroundColor())
                                            .frame(width: 20, height: 20)
                                        /* Circle()
                                         .foregroundColor(backgroundColor)
                                         .frame(width: 18, height: 18)
                                         */
                                    }
                                    /*
                                     if selectedStatus == status {
                                     
                                     Circle()
                                     .foregroundColor(.black)
                                     .frame(width: 13, height: 13)
                                     }*/
                                }
                                /*
                                 Text(status == .current ? "\(userData.user.currentReads.books.count)" : status == .read ? "\(userData.user.pastReads.books.count)" : "\(userData.user.readingList.books.count)")
                                 .font(.system(size: 12))
                                 .foregroundColor(.black)
                                 .opacity(0.7)
                                 .padding(.leading, 3)
                                 */
                            }
                            .padding(.vertical, 6)
                            .background(lightModeController.getBackgroundColor())
                            .onTapGesture{
                                selectedStatus = status
                                
                            }
                            
                            Divider()
                                .opacity(0.7)
                            
                            
                            
                            
                            
                        }
                    }
                    HStack(alignment: .top) {
                        Text(createNewList ? "Create New List" : "Add to List")
                            .font(.system(size: 16, weight: .medium))
                            .padding(.vertical)
                            .padding(.top)
                        
                        
                        
                        Spacer()
                        
                        if !createNewList {
                            HStack{
                                Spacer()
                                Button(action: {
                                    createNewList = true
                                    withAnimation {
                                        scrollProxy.scrollTo("creatingList", anchor: .top)
                                    }
                                    
                                }){
                                    HStack {
                                        Image(systemName: "plus")
                                            .font(.system(size: 14.5, weight: .medium))
                                        
                                        Text("Create List")
                                            .padding(.leading, -4)
                                            .font(.system(size: 14.5, weight: .medium))
                                    }
                                    .foregroundColor(lightModeController.getForegroundColor())
                                    .padding(8)
                                    .padding(.horizontal, 2)
                                    .background(lightModeController.getForegroundColor().opacity(0.05))
                                    .cornerRadius(30)
                                    .id("creatingList")

                                    
                                    
                                    
                                }
                            }
                            .padding(.top)
                            .padding(.top)
                            
                        }
                    }
                    .padding(.top)
                    
                    
                    if createNewList{
                        VStack(alignment: .leading){
                            Text("List Name")
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
                                        .stroke(lightModeController.getForegroundColor(), lineWidth: 0.5)
                                        .padding(.horizontal, 2)// Thin black border
                                )
                        }

                        HStack {
                            Text("Make this list private?")
                                .font(.system(size: 16))

                            
                            
                            Spacer()
                            
                            SlideToggle(isOn: $isPrivate)
                                .previewLayout(.sizeThatFits)
                            
                        }
                        .padding(.vertical)
                        VStack(alignment: .leading){
                            Text("List Desciption (optional)")
                                .font(.system(size: 16))
                                .padding(.bottom, -3)
                            
                            CustomTextEditor(text: $description, backgroundColor: UIColor(lightModeController.getBackgroundColor()))
                                .padding(.horizontal, 6)
                                .font(.system(size: 16.5))
                                .frame(height: 150)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(lightModeController.getForegroundColor(), lineWidth: 0.5)
                                        .padding(.horizontal, 2)// Thin black border
                                )
                                .padding(.bottom, 40)
                        }
                        
                    }
                    if !createNewList {
                        
                        
                        TextField("Search", text: $searchText)
                            .onTapGesture {
                                isTextFieldFocused = true
                            }
                            .font(.system(size: 16.5))
                            .foregroundColor(lightModeController.getForegroundColor())
                        
                            .padding(10)
                            .padding(.leading, 30)
                            .onSubmit {
                                // searched = true
                                isTextFieldFocused = false
                            }
                            .onChange(of: searchText){
                                // searched = false
                                //isGenre = false
                                
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
                            .padding(.vertical)
                        
                        
                        ForEach(filteredLists){ list in
                            
                            HStack {
                                HStack{
                                    ZStack{
                                        ForEach(0..<min(3, list.books.count), id: \.self) { index in
                                            
                                            Image(list.books[index].cover)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxWidth: 35, idealHeight: 50)
                                                .cornerRadius(4)
                                                .padding(2)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 4)
                                                        .foregroundColor(lightModeController.getForegroundColor())
                                                )
                                                .offset(x: CGFloat(index * 16))
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    .frame(width: 75, alignment: .leading)
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("\(list.title)")
                                                .font(.system(size: 15.5, weight: .medium))
                                            if list.isPrivate() {
                                                Image(systemName: "lock.fill")
                                                    .font(.system(size: 12))
                                                    .padding(.leading, -3)
                                            }
                                        }
                                        Spacer()
                                        Text(list.books.count == 1 ? "\(list.books.count) book" : "\(list.books.count) books")
                                            .font(.system(size: 13))
                                            .opacity(0.7)
                                    }
                                    .frame(height: 50)
                                    
                                }
                                
                                Spacer()
                                
                                if addToLists[list.id] != nil  {
                                    Image(systemName: "checkmark.circle.fill")
                                        .frame(width: 20, height: 20)
                                        .opacity(0.8)
                                } else {
                                    ZStack {
                                        Circle()
                                            .frame(width: 20, height: 20)
                                        Circle()
                                            .foregroundColor(lightModeController.getBackgroundColor())
                                            .frame(width: 18, height: 18)
                                        
                                        
                                        /* Circle()
                                         .foregroundColor(.black)
                                         .frame(width: 13, height: 13)
                                         */
                                        
                                    }
                                }
                                
                                
                            }
                            .background(lightModeController.getBackgroundColor())
                            .onTapGesture{
                                if addToLists[list.id] != nil  {
                                    addToLists.removeValue(forKey: list.id)
                                } else {
                                    addToLists[list.id] = list
                                }
                            }
                            
                            .padding(.bottom)
                            
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            if !isTextFieldFocused && (addToLists.count > 0  ||  userData.user.getStatus(bookid: media.id) != selectedStatus) {
                Button(action: {
                    saveChanges(media, selectedStatus)
                    if title != "" {
                        makeList(title, media)
                    }
                    addToList()
                    isPresenting = false
                }) {
                    RoundedRectangle(cornerRadius: 40)
                        .overlay(
                            Text("Done")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(lightModeController.isDarkMode() ? .black : .white)

                            )
                        .foregroundColor(Color(hex: lightModeController.isDarkMode() ? "#fffdf4" : "#302f2e"))

                              
                        .frame(height: 38)
                        //.foregroundColor(Color(.black).opacity(0.7))
                }
            }
        }
        .padding(.horizontal)
    

        .onAppear {
            if let currStat = userData.user.getStatus(bookid: media.id){
                selectedStatus = currStat
            }
        }
        .foregroundColor(lightModeController.getForegroundColor())
        .background(lightModeController.getBackgroundColor())
    }
    func makeList(_ title: String, _ book: Book) {
        let newList = List(user: userData.user.id, title: title, description: description, books: [book])
        if isPrivate {
            newList.makePrivate()
        }
        userData.user.addList(list: newList)
    }
    
    func addToList(){
        for (listid, list) in addToLists {
            list.books.append(media)
        }
        //notificationCoordinator.sendAddToListNotification(book: media, list: addToLists[0])
    }
}


struct SlideToggle: View {
    @Binding var isOn: Bool

    var body: some View {
        ZStack {
            // Background of the toggle
            RoundedRectangle(cornerRadius: 20)
                .fill(isOn ? Color.purple : Color.gray.opacity(0.3))
                .frame(width: 60, height: 30)
                .animation(.easeInOut(duration: 0.2), value: isOn)

            // The sliding circle
            Circle()
                .fill(Color.white)
                .frame(width: 24, height: 24)
                .offset(x: isOn ? 15 : -15) // Move circle left or right
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                .animation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0), value: isOn)
        }
        .onTapGesture {
            isOn.toggle() // Toggle state
        }
    }
}



struct AddBookToLibraryView: View {
    @Binding var isPresenting: Bool
    @EnvironmentObject var userData: UserData
    @State var selectedBook: Book? = nil
    @State var setStatus = false
    @EnvironmentObject var notificationCoordinator: NotificationCoordinator

    var body: some View {
        ZStack {
            SelectBook(isPresenting: .constant(true), selected: $selectedBook, saveChanges: { book in
                setStatus = true
            })
            
            if setStatus {
                AddToLibraryView(isPresenting: $setStatus, media: selectedBook!, saveChanges: { book, status in
                    
                    if let currentStatus = userData.user.getStatus(bookid: book.id) {
                        userData.user.addBook(book: book, status: status)
                        
                        notificationCoordinator.sendMarkBookStatusNotification(book: book, status: status)
                    } else {
                        userData.user.addBook(book: book, status: status)
                        
                        notificationCoordinator.sendAddedToLibraryNotification()
                    }
                    isPresenting = false


                })
            }
        }
        .padding()
    }
}

struct SearchLibraryView: View {
    @Binding var isPresenting: Bool
    @EnvironmentObject var userData: UserData
    @State var selectedBook: Book? = nil
    @State var setStatus = false
    @State var showBook = false
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        ZStack {
        
            SelectBook(isPresenting: .constant(true), selected: $selectedBook, saveChanges: { book in
                selectedBook = book
                showBook = true
                
            })
            
            if showBook {
                if let book: Book = selectedBook {
                    ContentView(book: .constant(book), isPresenting: $showBook, showToolbar: .constant(true))
                }
            }
        }
        .padding()
        .background(backgroundColor)

    }
}
struct Tag: View {
    
    var tag : String
    @State var selected: Bool = false
    var body: some View {
        
                Text(tag)
                    .foregroundColor(.black)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .font(.system(size: 14))
                    .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 0.5) // Add stroke for border

                        )
    }
}

struct Tag2: View {
    
    var tag : String
    @Binding var selected: Bool
    var body: some View {
        
                Text(tag)
                    .foregroundColor(.black)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .font(.system(size: 14))
                    .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 0.5) // Add stroke for border
                                .background(selected ? Color(.black).opacity(0.2) : .white)

                        )
    }
}
extension Color {
    var saturation: Double {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        // Get the RGBA components of the color
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // Find the minimum and maximum of the RGB components
        let minComponent = min(r, g, b)
        let maxComponent = max(r, g, b)
        
        // Calculate the saturation
        if maxComponent == 0 {
            return 0 // Return 0 if the color is black
        } else {
            return Double(1 - minComponent / maxComponent)
        }
    }
    

}
extension Color {
    var brightness: Double {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        // Get the RGBA components of the color
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // Calculate brightness using the formula: (0.2126 * red) + (0.7152 * green) + (0.0722 * blue)
        return Double((0.2126 * r) + (0.7152 * g) + (0.0722 * b))
    }
}


struct PurchasePopup: View {
    @EnvironmentObject var userData: UserData
    @Binding var isPresenting: Bool
    @Binding var media: Book
    @State var backgroundColor = Color(hex: "#FDFAEF")

    
    var body: some View {
        
        NavigationView{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(backgroundColor)
                .frame(width: 350, height: 400)
                .overlay(
                    VStack {
                        Text("Buy e-book")
                            .font(.system(size: 14, weight: .medium))
                            .padding(.bottom)
                        
                        Text(media.title)
                            .font(.system(size: 19, weight: .medium))
                            .padding(.bottom)
                        
                        Text("$\(String(format: "%.2f", media.price))")
                            .font(.system(size: 17, weight: .medium))
                            .padding(.bottom)
                        
                        Text("Sphere e-books contain exclusive content including annotation, community comments, and audio")
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                        
                        HStack {
                            Image(systemName: "book.pages.fill")
                            Image(systemName: "headphones")
                        }
                        .padding(.top, 20)
                        .font(.system(size: 30))
                        Spacer()
                        Button(action: {
                            userData.user.currentReads.books.insert(media, at: 0)
                            userData.user.library.append(media)
                            isPresenting = false
                        }) {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                                .frame(width: 300, height: 40)
                                .overlay(
                                    Text("Buy Now $\(String(format: "%.2f", media.price))")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                    
                                   
                                    
                                )
                        }
                        /*
                        NavigationLink(destination: EReaderView(media: $media, currentPageIndex: media.currentPage ?? 0), showEReader: $showEReader){
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                                .frame(width: 300, height: 40)
                                .overlay(
                                    Text("Unlock & Read")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                    
                                    
                                    
                                )
                        }
                         */
                    }
                        .background(backgroundColor)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 60)
                    
                    
                )
            
        }
    }

}


     

struct ReviewStars: View {
    var rating : Float
    var size = 12.0
    var backgroundColor = Color(hex: "#fffef8")
    
    var body: some View {
        
        HStack {
            

            ForEach(0..<Int(rating)) { _ in
                Image(systemName: "star.fill")
                    .padding(.trailing, -9)
                    .foregroundColor(.orange)
                    .font(.system(size: size))
            }
            
            if rating - Float(Int(rating)) > 0 {
               
                    // The star image
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                        .font(.system(size: size))
                        .overlay(
                            HStack{
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Image(systemName: "square.fill")
                                        .font(.system(size: size/1.8))
                                    Image(systemName: "square.fill")
                                        .font(.system(size: size/1.8))
                                }
                                .foregroundColor(Color(hex: "#fffef8"))
                            }

                    )
                        .padding(.trailing, -6)
               
            }
        
            
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

struct MoreInfo: View {
    @Binding var isPresenting : Bool
    @Binding var media: Book
    @State var backgroundColor = Color(hex: "#FDFAEF")
    
    
    var body: some View {
        VStack {
            Text(media.title)
                .font(.system(size: 15, weight: .medium))
                .padding(.top)
            ScrollView {
                VStack(alignment: .leading) {
                    
                    
                    /*media.cover
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 100)
                     .padding(.top)
                     
                     */
                    
                    Text(media.title)
                        .font(.system(size:18, weight: .medium))
                        .padding(.bottom, 0.5)
                        .padding(.top, 20)
                    
                    
                    
                    Text(media.synopsis)
                        .multilineTextAlignment(.leading)
                        .font(.system(size:15))
                        .lineSpacing(4)
                        .padding(.vertical, 20)
                    
                    
                    
                    Spacer()
                    
                    
                    
                    
                    
                }
                .padding(.vertical)
                
                HStack(alignment:.center) {
                    Button(action: {}){
                        
                        
                        VStack {
                            Text("CATEGORY")
                                .multilineTextAlignment(.center)
                                .font(.system(size:10.5, weight:.medium))
                                .opacity(0.5)
                                .padding(.bottom, 2)
                            
                            Text("\(media.genre.rawValue)")
                                .padding(.leading, -2)
                                .font(.system(size:13.5, weight:.medium))
                            
                                .multilineTextAlignment(.center)
                            //.textCase(.uppercase)
                            
                        }
                        .foregroundColor(.black)
                        //.opacity(0.6)
                    }
                    
                    Spacer()
                    Divider()
                        .padding(.horizontal, 2)
                    Spacer()
                    
                    VStack {
                        Text("PUBLISHED")
                            .multilineTextAlignment(.center)
                            .font(.system(size:10.5, weight:.medium))
                            .opacity(0.5)
                            .padding(.bottom, 2)
                        Text("\(media.year)")
                        //Text("\(media.readers)")
                        //.opacity(0.8)
                        
                        //.opacity(0.6)
                    }
                    
                    
                    Spacer()
                    
                    Divider()
                        .padding(.horizontal, 2)
                    
                    
                    Spacer()
                    
                    VStack {
                        Text("PAGES")
                            .multilineTextAlignment(.center)
                            .font(.system(size:10.5, weight:.medium))
                            .opacity(0.5)
                            .padding(.bottom, 2)
                        
                        Text("322")
                        //ReviewStars(num: 4.5)
                        
                        
                    }
                    Spacer()
                    
                    
                    
                    
                }
                .padding(.horizontal, 20)
                .padding(.top)
                .font(.system(size:13.5, weight:.medium))
                .padding(.bottom, 3)
                .padding(.bottom, 3)
                
                HStack(alignment:.center) {
                    Button(action: {}){
                        
                        
                        VStack {
                            Text("AUTHOR")
                                .multilineTextAlignment(.center)
                                .font(.system(size:10.5, weight:.medium))
                                .opacity(0.5)
                                .padding(.bottom, 2)
                            
                            Text("\(media.author.name)")
                                .padding(.leading, -2)
                                .font(.system(size:13.5, weight:.medium))
                            
                                .multilineTextAlignment(.center)
                            //.textCase(.uppercase)
                            
                        }
                        .foregroundColor(.black)
                        //.opacity(0.6)
                    }
                    
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
                        Text("\(media.readers)")
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
                    Spacer()
                    
                    
                    
                    
                }
                .padding(.horizontal, 20)
                .padding(.top)
                .font(.system(size:13.5, weight:.medium))
                .padding(.bottom, 3)
                .padding(.bottom, 3)
            }
        }
        .background(backgroundColor)
        .padding(.horizontal)
        
        
    }
}
struct ChapterDropdown : View {
    @State var selectedChapter : String
    var body: some View {
        
        
       
            HStack {
                Menu(selectedChapter) {
                    Text("Chapter 1")
                    Text("Chapter 2")
                    Text("Chapter 3")
                }
                .font(.system(size: 12.5, weight: .medium))
                .cornerRadius(10)
                .foregroundColor(.black)
                .padding(.trailing, -8)

                Image("down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25)
                    .opacity(0.7)


            }
                //.stroke(Color.black, lineWidth: 2)
        
    }
}

