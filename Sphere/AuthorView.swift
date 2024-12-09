//
//  AuthorView.swift
//  sphere
//
//  Created by Alana Greenaway on 5/26/24.
//

import SwiftUI

struct AuthorFollowButton: View {
    @EnvironmentObject var lightModeController: LightModeController
    var body: some View {
       
            Button(action: {

            }){
                HStack {
                    BodyText(text: "Follow", size: 16, weight: 0.2)
                        .foregroundColor(lightModeController.getForegroundColor())
               
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 13)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(lightModeController.getForegroundColor().opacity(0.4), lineWidth: 0.6)
                        .fill(lightModeController.isDarkMode() ? lightModeController.getForegroundColor().opacity(0.05) : Color(hex: "#fffffc").opacity(0.7))
                    //.shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                    
                    
                )
            }
           
    }
}

struct AuthorView: View {
    @Binding var author : Author
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
    @Binding var isPresenting: Bool
    @State var xoffset = 0.0
    @State var contentViewModel = ContentViewModel(book: Book())
    @State var showReader = false
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        ZStack {
            VStack {
                Image(author.photo)
                    .resizable()
                    .scaledToFill() // Ensures the image fills the space while maintaining aspect ratio

                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.40)
                    .clipped()
                    

                    .overlay(
                      VStack() {
                          HStack {
                              Image(systemName: "chevron.left")
                                  .onTapGesture {
                                      isPresenting.toggle()
                                  }
                              Spacer()
                          }
                          .padding(.top, 20)
                          
                          Spacer()
                          HStack {
                              BookTitleText(text: author.name, size: 28, foregroundColor: .white)
                                  .shadow(radius: 5)
                              Spacer()
                          }
                      }
                          .padding()
                          .foregroundColor(.white)
                    )
                Spacer()
            }
            .ignoresSafeArea()


                ScrollView {
                        

                        VStack {
                                 
                            VStack(alignment: .leading) {
                                HStack(alignment: .top) {
                                    BodyText(text: "11.2M readers", size: 14.5, weight: 0.2)
                                    Spacer()
                                    AuthorFollowButton()
                                }
                                    .padding(.top, 5)
                                                    
                               /* BodyText(text: author.bio, size: 16.5)
                                           .lineLimit(7)
                                           .padding(.vertical)
                                */
                                /*
                                HStack {
                                    VStack(alignment: .leading){
                                        
                                        BodyText(text: "You read", size: 16.5)
                                        BodyText(text: "5 books", size: 14.5)
                                    }
                                    Spacer()

                                }
                                */
                                VStack(alignment: .leading){
                                    BodyText(text: "Top Rated", size: 20, weight: 0.3)
                                        
                                    ForEach(author.books) { book in
                                    MiniBookPreview2(book: book, showBook: $showBook, selectedBook: $selectedBook)
                                    }
                                }
                                .padding(.top)
                                .padding(.top)

                                            
                                        }
                                       
                                    
                                    

                                }
                                .padding(.horizontal)
                                .background(lightModeController.getBackgroundColor())
                                //.padding(.top, 40)
                        /*
                        VStack {
                            VStack {
                                HStack{
                                    Text("\(author.name.uppercased()) BOOKS")
                                        .font(.system(size: 12))
                                        .opacity(0.7)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.top)
                              
                                ThreeGrid(books: author.books, showBook: $showBook, selectedBook: $selectedBook, viewModel: $contentViewModel)
                                        .padding(.top)
                                
                            }
                            .padding(.vertical)
                            
                            var reviews = author.getReviews()
                            if reviews.count > 0 {
                                HStack{
                                    Text("POPULAR REVIEWS")
                                        .font(.system(size: 12))
                                        .opacity(0.7)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.top)
                                ReviewPreview(review: reviews[0], showBook: $showBook, selectedBook: $selectedBook, showReview: $showReview, selectedReview: $selectedReview, showProfile: $showProfile, selectedProfile: $selectedProfile)
                                if reviews.count > 1 {
                                    
                                    ReviewPreview(review: reviews[1], showBook: $showBook, selectedBook: $selectedBook, showReview: $showReview, selectedReview: $selectedReview, showProfile: $showProfile, selectedProfile: $selectedProfile)
                                }
                                if reviews.count > 2{
                                    ReviewPreview(review: reviews[2], showBook: $showBook, selectedBook: $selectedBook, showReview: $showReview, selectedReview: $selectedReview, showProfile: $showProfile, selectedProfile: $selectedProfile)
                                }
                             
                                VStack {
                                    Divider()
                                        .padding(.horizontal)
                                        .padding(.horizontal, 4)
                                    
                                    Button(action: {
                                        
                                    }){
                                        HStack {
                                            Text("All Reviews")
                                                .font(.system(size: 15, weight: .medium))
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                            
                                            Text("\(reviews.count)")
                                                .font(.system(size: 15, weight: .medium))
                                            
                                            Image(systemName: "arrow.right")
                                                .font(.system(size: 12))
                                            
                                        }
                                        .foregroundColor(.black)
                                        .padding(.horizontal)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 4)
                                    }
                                    
                                    Divider()
                                        .padding(.horizontal)
                                        .padding(.horizontal, 4)
                                    
                                }
                                .padding(.vertical)
                                 
                            }
                            
                            
                            Spacer()
                            
                            
                        }
                        .padding(.bottom, 100)
                        .background(backgroundColor)
                        */
                        
                    
                    .padding(.top, UIScreen.main.bounds.height * 0.35)
                    .sheet(isPresented: $isPresentingNotes) {
                        ActivityPreview(media: selectedBookNotes, isPresenting: $isPresentingNotes, showProfile: $showProfile, selectedProfile: $selectedProfile)
                            .presentationDetents([.fraction(0.95)])
                    }
                }
            
           /* .offset(x: xoffset)
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
                
                
                if showBook {
                    ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: .constant(false))
                    
                }
                /*
                if showList {
                    ListView(isPresenting: $showList, list: $selectedList, user: user)
                }
                
                if showProfile {
                    ProfileView(user: selectedProfile, showToolbar: $showToolbar, isPresenting: $showProfile)
                }
                 */
            /*
                if showAllBooks{
                    AllBooks(isPresenting: $showAllBooks, user: user)
                }
                
                if showAllLists{
                    AllLists(isPresenting: $showAllLists, user: user)
                    
                }
             */
                if showPost {
                    Rectangle()
                        .ignoresSafeArea()
                        .opacity(0.2)
                    
                   // PostView(post: $selectedPost, isPresenting: $showPost, showToolbar: $showToolbar)
                }
                 
            if showBook {
                ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: .constant(true))
            }
                
            }
        
        .background(lightModeController.getBackgroundColor())
        .foregroundColor(lightModeController.getForegroundColor())

            
        }
    
        
    }

struct DiscussionSearchButton: View {
    var body: some View {
        Button(action: {}){
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
                .font(.system(size: 16, weight: .medium))

        }
    }
}


