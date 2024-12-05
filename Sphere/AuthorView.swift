//
//  AuthorView.swift
//  sphere
//
//  Created by Alana Greenaway on 5/26/24.
//

import SwiftUI


        
    

struct AuthorView: View {
    @Binding var author : Author
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
    @Binding var showToolbar: Bool
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
    
    var body: some View {
        ZStack {
                ScrollView {
                    VStack {
                        /*
                        VStack(alignment: .center) {
                            
                            AuthorThumbnail(image: author.photo, size: 115)
                                .padding(.horizontal)
                                .padding(.top, 20)
                                .padding(.bottom)

                            
                            Spacer()
                            
                            
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.top, 40)
                        
                        
                        
                        
                        HStack {
                            VStack(alignment: .center){
                                
                                Text(author.name)
                                    .font(.system(size: 17, weight: .medium))
                                    .padding(.bottom, 4)
                            
                                Text(author.bio)
                                    .font(.system(size: 14, weight: .regular))
                                    .multilineTextAlignment(.leading)
                                    

                            }
                            .padding(.horizontal)
                            
                            
                        }
                        .padding(.bottom)
                        .padding(.horizontal)
                        */
                        VStack(alignment: .leading) {
                            AuthorThumbnail(image: author.photo, size: 130)
                                .padding(.top)
                                .padding(.trailing, 3)


                                /*
                                    Image(author.photo)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit) // Changed to .fill to ensure the image covers the area
                                        .frame(height: 80)
                                        .clipped() // This ensures the image is clipped to the frame bounds
                                        .cornerRadius(2) // Apply corner radius directly to the image
                                        .shadow(radius: 0.5)
                                        .padding(.top)
                                        .padding(.trailing, 3)
                                    
                                */
                            
                        VStack {
                            
                                                            
                                        VStack(alignment: .leading) {

                                                
                                            Text(author.name)
                                                        .font(.system(size: 16, weight: .medium))
                                                        .padding(.top, 2)
                                                    
                                                
                                                
                                                Text(author.bio)
                                                    .font(.system(size: 15))
                                                    .lineLimit(7)
                                                    .lineSpacing(2.5)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.vertical)
                                            
                                                
                                           
                                            
                                            
                                            
                                        }
                                       
                                    }
                        .padding(.top)

                                }
                        .padding(.horizontal)
                        .padding(.top, 40)
                        
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
                        
                        
                        
                        
                    }
                    
                    
                    .background(backgroundColor)
                    .sheet(isPresented: $isPresentingNotes) {
                        ActivityPreview(media: selectedBookNotes, isPresenting: $isPresentingNotes, showProfile: $showProfile, selectedProfile: $selectedProfile)
                            .presentationDetents([.fraction(0.95)])
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
            
            .background(backgroundColor)
                .navigationBarHidden(true)
                
                
                if showBook {
                    ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: $showToolbar)
                    
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
                    
                    PostView(post: $selectedPost, isPresenting: $showPost, showToolbar: $showToolbar)
                }
                                
                
            }
        
        .background(backgroundColor)

            
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


