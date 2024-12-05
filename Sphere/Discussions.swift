//
//  Discussions.swift
//  sphere
//
//  Created by Alana Greenaway on 5/17/24.
//

import SwiftUI

struct Discussions: View {
    @EnvironmentObject var userData: UserData
    @State var showDisc = false
    @Binding var showToolbar: Bool
    @State var showEReader = false
    @State var selectedBook = Book()
    @State var create = false
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var body: some View {
        
        ZStack {
            NavigationView {
                ScrollView {
                    
                    VStack(alignment:.leading) {
                        Text("Discussions")
                            .font(.system(size: 18, weight: .medium))
                            .padding(.horizontal)
                            .padding(.vertical)

                        ForEach(userData.user.currentReads.books, id: \.self) { book in
                            // Perform actions with each book
                            DiscussionCell(book: book, showDisc: $showDisc, selectedBook: $selectedBook)
                        }
                        
                    }
                    .padding(.top)
                    //.background(backgroundColor)

                }
                .background(backgroundColor)

            }
            .navigationBarHidden(true)

            
            if showDisc {
              
                    // DiscussionView(isPresenting: $showDisc, posts: selectedBook.discussion.posts, book: $selectedBook, user: user1, showEReader: $showEReader, showToolbar: $showToolbar)
                    
            }

        }


    }
}

struct DiscussionCell: View {
    var book: Book = Book()
    @Binding var showDisc: Bool
    @Binding var selectedBook: Book
    
    var body: some View {
        Button(action: {
            selectedBook = book
            showDisc = true
        
        }){
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    Text("x new posts")
                        .font(.system(size: 10))
                        .foregroundColor(.black)
                    
                    
                }
                
                Spacer()
                
                Image(book.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                    .shadow(radius: 0.5)
                
                
            }
            .padding(.horizontal)
            .padding(.vertical, 30)
            
        }
        
    }
}

