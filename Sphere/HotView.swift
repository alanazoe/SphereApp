//
//  HotView.swift
//  Sphere
//
//  Created by Alana Greenaway on 10/28/24.
//

import SwiftUI

struct HotView: View {
    @EnvironmentObject var lightModeController: LightModeController
    @State var books: [Book] = [
        Book(id: UUID(), title: "Beach Read", author: Author(name: "Emily Henry", photo: "a6", bio: "Emily henry is the #1 new york times and #1 sunday times bestselling author of funny story, happy place, book lovers, people we meet on vacation, and beach read. she lives and writes in the american midwest."), synopsis: "Augustus Everett is an acclaimed author of literary fiction. January Andrews writes bestselling romance. When she pens a happily ever after, he kills off his entire cast. They’re polar opposites. In fact, the only thing they have in common is that for the next three months, they’re living in neighboring beach houses, broke, and bogged down with writer’s block. Until, one hazy evening, one thing leads to another and they strike a deal designed to force them out of their creative ruts: Augustus will spend the summer writing somethF'ing happy, and January will pen the next Great American Novel. She’ll take him on field trips worthy of any rom-com montage, and he’ll take her to interview surviving members of a backwoods death cult (obviously). Everyone will finish a book and no-one will fall in love. Really.", readers: 5000, cover: "b58", genre: .romance, rating: 4.5, year: "2020", length: "384", discussion: Discussion(id: UUID(), posts: []), reviews: [:], price: 15.99),
        
        Book(id: UUID(), title: "People We Meet on Vacation", author: Author(name: "Emily Henry", photo: "a6", bio: "Emily henry is the #1 new york times and #1 sunday times bestselling author of funny story, happy place, book lovers, people we meet on vacation, and beach read. she lives and writes in the american midwest."), synopsis: "Two best friends who take a vacation together every summer and what happens when one trip changes everything.", readers: 6000, cover: "b59", genre: .romance, rating: 4.4, year: "2021", length: "384", discussion: Discussion(id: UUID(), posts: []), reviews: [:], price: 16.99),
        
        Book(id: UUID(), title: "Book Lovers", author: Author(name: "Emily Henry", photo: "a6", bio: "Emily henry is the #1 new york times and #1 sunday times bestselling author of funny story, happy place, book lovers, people we meet on vacation, and beach read. she lives and writes in the american midwest."), synopsis: "A cutthroat literary agent and a brooding editor find themselves in a small town where they have to face their pasts.", readers: 7000, cover: "b60", genre: .romance, rating: 4.6, year: "2022", length: "384", discussion: Discussion(id: UUID(), posts: []), reviews: [:], price: 17.99),
        
        Book(id: UUID(), title: "Happy Place", author: Author(name: "Emily Henry", photo: "a6", bio: "Emily henry is the #1 new york times and #1 sunday times bestselling author of funny story, happy place, book lovers, people we meet on vacation, and beach read. she lives and writes in the american midwest."), synopsis: "A couple who broke up months ago make a pact to pretend to still be together for their annual weeklong vacation with their best friends.", readers: 8000, cover: "b61", genre: .romance, rating: 4.7, year: "2023", length: "400", discussion: Discussion(id: UUID(), posts: []), reviews: [:], price: 18.99),
        

        
        Book(id: UUID(), title: "Hello Girls", author: Author(name: "Emily Henry & Brittany Cavallaro", bio: ""), synopsis: "Two girls escape their oppressive lives and take a road trip to find freedom and adventure.", readers: 3100, cover: "b65", genre: .youngAdult, rating: 4.0, year: "2019", length: "400", discussion: Discussion(id: UUID(), posts: []), reviews: [:], price: 14.99),
        
        Book(id: UUID(), title: "Funny Story", author: Author(name: "Emily Henry", photo: "a6", bio: "Emily henry is the #1 new york times and #1 sunday times bestselling author of funny story, happy place, book lovers, people we meet on vacation, and beach read. she lives and writes in the american midwest."), synopsis: "Following a breakup, Daphne and her ex's former partner, Miles, fake a relationship on social media, leading to unexpected results.", readers: 2800, cover: "b64", genre: .romance, rating: 4.5, year: "2024", length: "400", discussion: Discussion(id: UUID(), posts: []), reviews: [:], price: 19.99),
        Book(id: UUID(), title: "A Million Junes", author: Author(name: "Emily Henry", photo: "a6", bio: "Emily henry is the #1 new york times and #1 sunday times bestselling author of funny story, happy place, book lovers, people we meet on vacation, and beach read. she lives and writes in the american midwest."), synopsis: "June O'Donnell and Saul Angert unravel the dark history between their families as they navigate their own unexpected relationship.", readers: 3500, cover: "b62", genre: .youngAdult, rating: 4.2, year: "2017", length: "400", discussion: Discussion(id: UUID(), posts: []), reviews: [:], price: 14.99),
        
        Book(id: UUID(), title: "When the Sky Fell on Splendor", author: Author(name: "Emily Henry", photo: "a6", bio: "Emily henry is the #1 new york times and #1 sunday times bestselling author of funny story, happy place, book lovers, people we meet on vacation, and beach read. she lives and writes in the american midwest."), synopsis: "A group of friends in a small town encounter a mysterious event that changes their lives forever.", readers: 3200, cover: "b63", genre: .youngAdult, rating: 4.0, year: "2019", length: "400", discussion: Discussion(id: UUID(), posts: []), reviews: [:], price: 14.99),
        
    ]
    @State var selected = 0
    @State var showBook = false
    @State var selectedBook = Book()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact

        ZStack() {
            
 
            VStack {
                GeometryReader { geo in
                    
                    ScrollView {
                        VStack(alignment: .leading) {  // Adjust spacing as needed
                            
                            
                            // Vertical list of book previews
                            ForEach(Array(books.enumerated()), id: \.element.id) { index, book in
                                HotCell(book: book, index: index+1)
                                    .padding(.horizontal)
                                    .frame(height: geo.size.height + geo.safeAreaInsets.top)
                                //Or LazyVStack spacing
                                    .padding(.bottom, geo.safeAreaInsets.bottom)
                                    .onTapGesture{
                                        showBook = true
                                        selectedBook = book
                                    }
                                
                            }
                        }
                    }
                    .scrollTargetBehavior(.paging)
                    .ignoresSafeArea(.container, edges: [.top, .bottom])
                }

            }
            VStack {
                HStack {
                    
                    if iPadOrientation {
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
                    }
                    Spacer()
                    HStack{
                        
                        HStack {
                            /*
                             Button(action: {
                             selected = 0
                             }){
                             Text("Trending")
                             .font(.system(size: 16))
                             
                             .padding(5)
                             .padding(.horizontal, 6)
                             .background(
                             RoundedRectangle(cornerRadius: 40)
                             .stroke(Color.black.opacity(0.4), lineWidth: 0.6)
                             .fill(selected == 0 ? Color(.gray).opacity(0.2) : Color(.gray).opacity(0.05))
                             
                             )
                             }
                             
                             
                             
                             Button(action:{
                             selected = 1
                             
                             }){
                             Text("Recommended For You")
                             .font(.system(size: 16))
                             .padding(5)
                             .padding(.horizontal, 6)
                             .background(
                             RoundedRectangle(cornerRadius: 40)
                             .stroke(Color.black.opacity(0.4), lineWidth: 0.6)
                             .fill(selected == 1 ? Color(.gray).opacity(0.2) : Color(.gray).opacity(0.05))
                             )
                             
                             }
                             */
                            GenreDropDown()
                            /*
                            Button(action: {
                                x
                            }){
                                HStack{
                                    Text("All genres")
                                        .font(.system(size: 16))
                                    Image("down")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25)
                                        .opacity(0.7)
                                        .padding(.leading, -4)
                                }
                                .padding(3)
                                .padding(.horizontal, 6)
                                /*.background(
                                 RoundedRectangle(cornerRadius: 40)
                                 .stroke(Color.black.opacity(0.4), lineWidth: 0.6)
                                 .fill(selected == 0 ? Color(.gray).opacity(0.1) : Color(.gray).opacity(0.05))
                                 )*/
                            } */
                            
                        }
                        .padding(2)
                        
                        
                    }
                }
                
                .padding(.horizontal, iPadOrientation ? 5 : 0)
                .padding(.top)
                .padding(.horizontal)
                .background(lightModeController.getBackgroundColor())
             Spacer()
            }
           

        }
        .sheet(isPresented: $showBook){
            ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: .constant(true), fullscreen: false)

        }
        .background(lightModeController.getBackgroundColor())
        .foregroundColor(lightModeController.getForegroundColor())
    }
}

struct HotArticleView: View {
    @EnvironmentObject var lightModeController: LightModeController
    @State var articles: [Article] = [
        Article(title: "Scenes From Day of the Dead Celebrations in San Luis Potosi, Mexico", publication: Publication(id: UUID(), logo: "vogue"), cover: "art1"),
        Article(title: "This New, Laid-Back Design Hotel in the Swiss Alps Is a Year-Round Delight", publication: Publication(id: UUID(), logo: "vogue"), cover: "art2"),
        Article(title: "26 Must-Have Designer Bags for 2024, According to ELLE Editors", publication: Publication(id: UUID(), logo: "elle"), cover: "art3"),
        Article(title: "This Off-Grid House in Lebanon Is Straight Out of Lord of the Rings", publication: Publication(id: UUID(), logo: "ad"), cover: "art4"),
        Article(title: "This Is the World’s Most Glamorous Tiny Home (and Only 79 Were Made)", publication: Publication(id: UUID(), logo: "ad"), cover: "art5"),
    ]
    @State var selected = 0
    @State var showArticle = false
    @State var selectedArticle = Article()
    var body: some View {
        ZStack() {
            
 
            VStack {
                GeometryReader { geo in
                    
                    ScrollView {
                        VStack() {  // Adjust spacing as needed
                            
                            
                            // Vertical list of book previews
                            ForEach(Array(articles.enumerated()), id: \.element.id) { index, article in
                                ArticlePreview(article: article, width: UIScreen.main.bounds.width * 0.85, showArticle: $showArticle, selectedArticle: $selectedArticle)
                                    .frame(height: UIScreen.main.bounds.height)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.paging)
                    .ignoresSafeArea(.container, edges: [.top, .bottom])
                    .frame(width: UIScreen.main.bounds.width)
                }

            }
            VStack {
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
                    HStack{
                        
                        HStack {
                            /*
                             Button(action: {
                             selected = 0
                             }){
                             Text("Trending")
                             .font(.system(size: 16))
                             
                             .padding(5)
                             .padding(.horizontal, 6)
                             .background(
                             RoundedRectangle(cornerRadius: 40)
                             .stroke(Color.black.opacity(0.4), lineWidth: 0.6)
                             .fill(selected == 0 ? Color(.gray).opacity(0.2) : Color(.gray).opacity(0.05))
                             
                             )
                             }
                             
                             
                             
                             Button(action:{
                             selected = 1
                             
                             }){
                             Text("Recommended For You")
                             .font(.system(size: 16))
                             .padding(5)
                             .padding(.horizontal, 6)
                             .background(
                             RoundedRectangle(cornerRadius: 40)
                             .stroke(Color.black.opacity(0.4), lineWidth: 0.6)
                             .fill(selected == 1 ? Color(.gray).opacity(0.2) : Color(.gray).opacity(0.05))
                             )
                             
                             }
                             */
                            GenreDropDown()
                            /*
                            Button(action: {
                                x
                            }){
                                HStack{
                                    Text("All genres")
                                        .font(.system(size: 16))
                                    Image("down")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25)
                                        .opacity(0.7)
                                        .padding(.leading, -4)
                                }
                                .padding(3)
                                .padding(.horizontal, 6)
                                /*.background(
                                 RoundedRectangle(cornerRadius: 40)
                                 .stroke(Color.black.opacity(0.4), lineWidth: 0.6)
                                 .fill(selected == 0 ? Color(.gray).opacity(0.1) : Color(.gray).opacity(0.05))
                                 )*/
                            } */
                            
                        }
                        .padding(2)
                        
                        
                    }
                }
                
                .padding(.horizontal, 5)
                .padding(.top)
                .padding(.horizontal)
                .background(lightModeController.getBackgroundColor())
                .overlay(
                    HStack(alignment:.bottom) {
                        Spacer()
                        Button(action: {
                            selected = 0
                        }){
                            Text("Trending")
                                .font(.system(size: 17, weight: selected == 0 ? .medium : .regular))
                                .frame(width: 150, alignment: .trailing)
                            
                        }
                        
                        Divider()
                            .frame(height: 18)
                        
                        Button(action:{
                            selected = 1
                            
                        }){
                            Text("For You")
                                .font(.system(size: 17, weight: selected == 1 ? .medium : .regular))
                                .frame(width: 150, alignment: .leading)

                            
                        }
                        Spacer()
                        
                        
                    }
                )
                Spacer()
            }
           

        }
        .sheet(isPresented: $showArticle){
            ArticleView(isPresenting: $showArticle, article: $selectedArticle)

        }
        .background(lightModeController.getBackgroundColor())
        .foregroundColor(lightModeController.getForegroundColor())
    }
}

struct HotCell: View {
    @EnvironmentObject var userData: UserData
    @State var book: Book
    @State var showAuthor: Bool = false
    @State var fullscreen = false
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
    @State var isPresentingBuy: Bool = false
    @State var index: Int = 0

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact

            
        VStack {
            
                HStack {
                    if lightModeController.isDarkMode(){
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
                
                VStack{
                Image(book.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iPadOrientation ? 370 : 240)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 0.5)
                    .padding(.top, iPadOrientation ? 40 : 30)
                
                    .padding(.bottom, iPadOrientation ? 0 : 20)

                    .padding(.top, 40)
                Spacer()
                
                
                    VStack(alignment: .leading) {
                        HStack{
                            Text(book.title)
                            //Baskerville-SemiBold
                                .font(.custom("EBGaramondRoman-SemiBold", size: 20))
                                //.font(.system(size:18, weight: .medium))
                                .padding(.top, 20)
                            //.frame(width: 250)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom)
                                .padding(.trailing, 4)
                            Spacer()
                            
                            HStack(alignment:.center) {
                                
                                if iPadOrientation {
                                    Button(action: { }){
                                        
                                        
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
                                            
                                        }) {
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 12))
                                                .foregroundColor(.orange)
                                                .opacity(1)
                                                .padding(.leading, -5)
                                            if book.rating != 0 {
                                                Text("\(String(format: "%.1f", book.rating))")
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
                                
                                
                                if book.readers >= 1000 {
                                Divider()
                                    .padding(.horizontal, 2)
                                
                                
                           
                                    VStack {
                                        Text("READERS")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size:10.5, weight:.medium))
                                            .opacity(0.5)
                                            .padding(.bottom, 2)
                                        Text(formatLargeNumber(book.readers))
                                        
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
                            .frame(height: 45)

                            .padding(.top)
                            .font(.system(size:13.5, weight:.medium))
                            .padding(.bottom, 3)
                            .padding(.bottom, 3)
                        }
                        
                        VStack(alignment: .leading) {
                            
                            
                                Text(book.synopsis)
                                    .multilineTextAlignment(.leading)
                                    .font(Font(UIFont.systemFont(ofSize: 16.8, weight: UIFont.Weight(0.05))))
                                    .lineLimit(5)
                                    .lineSpacing(5)
                                    .padding(.top, 20)
                                    .padding(.bottom)
                                
                            
                        
                            HStack(alignment: .center){
                                
                                GenreTag(book: book, showGenre: $showGenre, selectedGenre: $selectedGenre)
                                // if book is already in library
                                
                                
                                Spacer()
                                if !iPadOrientation {
                                    Button(action: { }){
                                        
                                        
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
                                }
                            
                        
                                    
                            }
                            .padding(.top, 10)
                            .padding(.bottom)
                            
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
 
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                //.padding(.horizontal)
                .background(lightModeController.getBackgroundColor())
                
                
            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.03)
            .padding(.bottom, 80)
        //.frame(height: UIScreen.main.bounds.height)
            
        
                
                .sheet(isPresented: $isPresentingBuy){
                    PurchasePopup(isPresenting: $isPresentingBuy, media: $book)
                        .presentationDetents([.fraction(0.6)])
                }
                
                .foregroundColor(lightModeController.getForegroundColor())
                .background(lightModeController.getBackgroundColor())
                
                
                
        
        
                
        
                
            
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


struct DropDownMenu: View {
    let options: [String]
    @EnvironmentObject var lightModeController: LightModeController
    var menuWidth: CGFloat = 140
    var buttonHeight: CGFloat = 40
    var maxItemDisplayed: Int = 3
    
    @Binding var selectedOptionIndex: Int
    @Binding var showDropdown: Bool
    
    @State private var scrollPosition: Int?
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                // Selected item button
                Button(action: {
                    withAnimation {
                        showDropdown.toggle()
                    }
                }, label: {
                    HStack {
                        Text(options[selectedOptionIndex])
                            .font(.system(size: 14))
                        Spacer()
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(showDropdown ? -180 : 0))
                    }
                })
                .padding(.horizontal, 20)
                .frame(width: menuWidth, height: buttonHeight, alignment: .leading)
                
                // Selection menu
                if showDropdown {
                    let scrollViewHeight: CGFloat = options.count > maxItemDisplayed
                        ? (buttonHeight * CGFloat(maxItemDisplayed))
                        : (buttonHeight * CGFloat(options.count))
                    
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(0..<options.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation {
                                        selectedOptionIndex = index
                                        showDropdown.toggle()
                                    }
                                }, label: {
                                    HStack {
                                        Text(options[index])
                                            .font(.system(size: 14))
                                        Spacer()
                                        if index == selectedOptionIndex {
                                            Image(systemName: "checkmark.circle.fill")
                                        }
                                    }
                                })
                                .padding(.horizontal, 20)
                                .frame(width: menuWidth, height: buttonHeight, alignment: .leading)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $scrollPosition)
                    .scrollDisabled(options.count <= maxItemDisplayed)
                    .frame(height: scrollViewHeight)
                    .onAppear {
                        scrollPosition = selectedOptionIndex
                    }
                }
            }
            .foregroundStyle(lightModeController.isDarkMode() ? Color(.white) : Color(.black))
            .background(lightModeController.isDarkMode() ? Color(hex: "202024") : Color(hex: "#ECE8DA").opacity(0.5))
            .cornerRadius(50)
        }
        .frame(width: menuWidth, height: buttonHeight, alignment: .top)
        .zIndex(100)
    }
}

struct  GenreDropDown: View {

    let genres = ["All Genres", "Romance", "Mystery", "Thriller"]
    @State  private  var selectedOptionIndex =  0
    @State  private  var showDropdown =  false

    var body: some  View {
        DropDownMenu(options: genres, selectedOptionIndex: $selectedOptionIndex, showDropdown: $showDropdown)
    }
}
