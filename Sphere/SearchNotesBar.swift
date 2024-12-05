//
//  SearchNotesBar.swift
//  sphere
//
//  Created by Alana Greenaway on 6/19/24.
//

// search notes
// search characters/terms etc

import SwiftUI

struct SearchNotesBar2: View {
    @Binding var isPresenting: Bool
    @State var book: Book
    @State var searchText = ""
    @State  var searched = false
    @State var placeholder = "Search notes..."
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks : Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    //@Binding var showEReader : Bool
    @Binding var showToolbar: Bool
    @EnvironmentObject var userData: UserData
    var body: some View {
        
        
        VStack(alignment: .leading) {
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
                            if searchText == "" || isTextFieldFocused {
                                Button("Cancel") {
                                    // Close keyboard
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    // Empty search text
                                    searchText = ""
                                    isTextFieldFocused = false
                                    isPresenting =  false

                                }
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                                .padding(.trailing)
                            }
                        }
                    )
                    .background(Color(.black).opacity(0.05))
                    .cornerRadius(10)
                    .padding(3)
                    .padding(searchText != "" ? .leading : .horizontal)

                
                
            }
           
            
   
            if searchText != "" && !isGenre  {
                Spacer()

                ListNotesSearchResults(user: userData.user, searchText: $searchText, book: book, searched: $searched, showToolbar: $showToolbar)
                
            }
            

            
        
            
    }
    }
}

struct SearchNotesBar: View {
    @Binding var isPresenting: Bool
    @State var book: Book
    @State var searchText = ""
    @State  var searched = false
    @State var placeholder = "Search notes..."
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks : Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    //@Binding var showEReader : Bool
    @Binding var showToolbar: Bool
    @EnvironmentObject var userData: UserData
    @Binding var showCharacters: Bool
    @Binding var showQuotes: Bool
    var body: some View {
        
        
        VStack(alignment: .leading) {
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
                            if searchText == "" || isTextFieldFocused {
                                Button("Cancel") {
                                    // Close keyboard
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    // Empty search text
                                    searchText = ""
                                    isTextFieldFocused = false
                                    isPresenting =  false

                                }
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                                .padding(.trailing)
                            }
                        }
                    )
                    .background(Color(.black).opacity(0.05))
                    .cornerRadius(10)
                    .padding(3)
                    .padding(searchText != "" ? .leading : .horizontal)

                
                
            }
            HStack(spacing: 35){
                
                HStack {
                    Button(action: {
                        showCharacters.toggle()
                    }){
                        HStack {
                            Image(systemName: "person.crop.square")
                            Text("Characters")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(showCharacters ? Color(hex: "#ECE8DA") : Color(.clear))
                            
                        )
                        
                    }
                }
                    
                Button(action: {
                    showQuotes.toggle()
                }){
                    HStack {
                        Image(systemName: "text.quote")
                        Text("Quotes")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(showQuotes ? Color(hex: "#ECE8DA") : Color(.clear))
                        
                    )
                }

                HStack {
                    Image(systemName: "character.book.closed")
                    Text("Terms")
                }
                    

                HStack {
                    Image(systemName: "photo")
                    Text("Photos")
                }
                    


                
            }
            .font(.system(size: 13.5))
            .padding(.vertical)
            .padding(.leading, 2)

            .padding(.horizontal)
            
            Spacer()
            
            if searchText == "" && isTextFieldFocused && !isGenre {
                VStack {
                   // ListSearchSuggestions(searchText: $searchText, searched: $searched, isGenre: $isGenre)
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
                
                ListNotesSearchResults(user: userData.user, searchText: $searchText, book: book, searched: $searched, showToolbar: $showToolbar)
                
            }
            
            if searchText != "" && isGenre && searched  {
                
                //ListGenreSearchResults(searchText: $searchText, books: allBooks.library, searched: $searched)
                
            }
            
        
            
    }
    }
}

struct SearchDiscussionBar: View {
    @Binding var isPresenting: Bool
    @State var book: Book
    @State var searchText = ""
    @State  var searched = false
    @State var placeholder = "Search notes..."
    @State var isTextFieldFocused = false
    @EnvironmentObject var allBooks : Library
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var isGenre = false
    //@Binding var showEReader : Bool
    @Binding var showToolbar: Bool
    @EnvironmentObject var userData: UserData
    @Binding var showCharacters: Bool
    @Binding var showQuotes: Bool
    var body: some View {
        
        
        VStack(alignment: .leading) {
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
                            if searchText == "" || isTextFieldFocused {
                                Button("Cancel") {
                                    // Close keyboard
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    // Empty search text
                                    searchText = ""
                                    isTextFieldFocused = false
                                    isPresenting =  false

                                }
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                                .padding(.trailing)
                            }
                        }
                    )
                    .background(Color(.black).opacity(0.05))
                    .cornerRadius(10)
                    .padding(3)
                    .padding(searchText != "" ? .leading : .horizontal)

                
                
            }
            
            
            Spacer()
            
            if searchText == "" && isTextFieldFocused && !isGenre {
                VStack {
                   // ListSearchSuggestions(searchText: $searchText, searched: $searched, isGenre: $isGenre)
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
                
                ListDiscussionSearchResults(user: userData.user, searchText: $searchText, book: book, searched: $searched, showToolbar: $showToolbar)
                
            }
            
            if searchText != "" && isGenre && searched  {
                
                //ListGenreSearchResults(searchText: $searchText, books: allBooks.library, searched: $searched)
                
            }
            
        
            
    }
    }
}

struct ListDiscussionSearchResults: View {
    @State var user: User
    @Binding var searchText : String// Consider this as user input that changes
    @State var book: Book // Your books array
    @State var showBook = true
    @State var showNote = true
    @State var selectedNote = Note()
    @State var selectedBook = Book()
    @Binding var searched : Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var showEReader = false
    // Computed property to filter books based on searchText
    @Binding var showToolbar: Bool
    @State var selectedProfile = User()
    private var filteredNotes: [Note] {
        if searchText.isEmpty {
            return book.discussion.posts
        } else {
            return book.discussion.posts.filter { note in
                note.title.localizedCaseInsensitiveContains(searchText) || note.getAllText().localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        

            
        ScrollView {
            
            if filteredNotes.count < 1 {
                Text("no results for \(searchText)")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .padding(.top, 2)
                    .padding(.bottom)
            }
            HStack(alignment: .top) {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(filteredNotes.enumerated()), id: \.offset) { index, note in
                        
                        NotePreview(note: note, showNote: $showNote, selectedNote: $selectedNote, showBook: $showBook, selectedBook: $selectedBook, showPostActions: .constant(false), showProfile: .constant(false), selectedProfile: $selectedProfile)
                        //Divider()
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        
        .background(backgroundColor)
    }
}

struct ListNotesSearchResults: View {
    @State var user: User
    @Binding var searchText : String// Consider this as user input that changes
    @State var book: Book // Your books array
    @State var showBook = true
    @State var showNote = true
    @State var selectedNote = Note()
    @State var selectedBook = Book()
    @Binding var searched : Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var showEReader = false
    // Computed property to filter books based on searchText
    @Binding var showToolbar: Bool
    @State var selectedProfile = User()
    private var filteredNotes: [Note] {
        if searchText.isEmpty {
            return user.getNotesByBookID(bookid: book.id)
        } else {
            return user.getAllNotes().filter { note in
                note.title.localizedCaseInsensitiveContains(searchText) || note.getAllText().localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        

            
        ScrollView {
            
            if filteredNotes.count < 1 {
                Text("no results for \(searchText)")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .padding(.top, 2)
                    .padding(.bottom)
            }
            HStack(alignment: .top) {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(filteredNotes.enumerated()), id: \.offset) { index, note in
                        
                        NotePreview(note: note, showNote: $showNote, selectedNote: $selectedNote, showBook: $showBook, selectedBook: $selectedBook, showPostActions: .constant(false), showProfile: .constant(false), selectedProfile: $selectedProfile)
                        //Divider()
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        
        .background(backgroundColor)
    }
}
