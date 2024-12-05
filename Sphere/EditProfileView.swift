//
//  EditProfileView.swift
//  sphere
//
//  Created by Alana Greenaway on 5/23/24.
//


import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var completion: (UIImage?) -> Void
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, completion: completion)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        var completion: (UIImage?) -> Void
        
        init(_ parent: PhotoPicker, completion: @escaping (UIImage?) -> Void) {
            self.parent = parent
            self.completion = completion
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else {
                completion(nil)
                return
            }
            
            provider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.parent.selectedImage = image
                        self.completion(image)
                    } else {
                        self.completion(nil)
                    }
                }
            }
        }
    }
}

struct CustomSectionView<Content: View>: View {
    let header: String
    let content: Content
    var backgroundColor: Color

    init(header: String, backgroundColor: Color = Color.white, @ViewBuilder content: () -> Content) {
        self.header = header
        self.content = content()
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.headline)
                .padding([.leading, .top], 8)
            VStack {
                content
            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(8)
            .shadow(radius: 1)
        }
        .padding(.horizontal)
    }
}

struct EditProfileView: View {
    @Binding var isPresenting: Bool
    @ObservedObject var user: User
    @State private var name: String
    @State private var handle: String
    @State private var location: String
    @State private var instagram: String
    @State private var bio: String
    @State private var pinnedBooks: [Book]
    @State private var pinnedPosts: [Note]
    @State private var pinnedReviews: [Review]
    @State private var pinnedLists: [List]
    @State private var selectingBooks = false
    @State private var selectingPosts = false
    @State private var showingPhotoPicker = false
    @State private var profileImage: UIImage?
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var secondaryColor = Color(hex: "#ECE8DA")
    @State var email = ""
    @State var phone = ""
    @State var birthday = ""
    
    init(isPresenting: Binding<Bool>, user: User) {
        self._isPresenting = isPresenting
        self.user = user
        _name = State(initialValue: user.name)
        _handle = State(initialValue: user.handle)
        _location = State(initialValue: user.location)
        _instagram = State(initialValue: user.instagram)
        _bio = State(initialValue: user.bio)
        _pinnedBooks = State(initialValue: user.profileDisplay.pinnedBooks)
        _pinnedPosts = State(initialValue: user.profileDisplay.pinnedPosts)
        _pinnedReviews = State(initialValue: user.profileDisplay.pinnedReviews)
        _pinnedLists = State(initialValue: user.profileDisplay.pinnedLists)
        _profileImage = State(initialValue: loadImage(from: user.photo))
        UITableView.appearance().backgroundColor = .clear

    }

    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Button(action: {
                        isPresenting = false
                    }) {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                        
                    }
                    Spacer()
                    Text("Edit Profile")
                        .font(.system(size: 15, weight: .medium))
                    Spacer()
                    Button(action: {
                        saveChanges()
                        isPresenting = false
                    }) {
                       
                                Text("Save")
                                    .font(.system(size: 16, weight: .medium))
                                
                                    .foregroundColor(.black)
                            
                        
                    }
                }
                .padding(.horizontal, 23)
                ScrollView{
                    VStack(alignment: .leading) {
                        Section(/*header: Text("PROFILE PICTURE").font(.system(size: 13)).foregroundColor(Color(.black).opacity(0.7))*/) {
                            HStack {
                                Spacer()
                                VStack(alignment:.center) {
                                    if let profileImage = profileImage {
                                        Image(uiImage: profileImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
                                    } else if let img = UIImage(named: user.photo){    Image(uiImage: img)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
                                    } else {
                                        Image(systemName: "person.crop.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
                                    }
                                    Button(action: {
                                        showingPhotoPicker = true
                                    }) {
                                        Text("Edit")
                                            .font(.system(size: 16, weight: .medium))
                                    }
                                    .padding(.top)
                                    .padding(.bottom)
                                    .sheet(isPresented: $showingPhotoPicker) {
                                        PhotoPicker(selectedImage: $profileImage){ image in
                                            profileImage = image
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.top, 40)
                        }
                        .background(backgroundColor)
                        
                        Section(header: Text("BASIC INFO").font(.system(size: 13)).foregroundColor(Color(.black).opacity(0.7))) {
                            VStack(alignment:.leading, spacing: 10){
                                TextField("Name", text: $name)
                                Divider()
                                TextField("Handle", text: $handle)
                                Divider()
                                TextField("Location", text: $location)
                                Divider()
                                TextField("Instagram", text: $instagram)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 6)
                            .font(.system(size: 17))
                            .background(secondaryColor)
                            .cornerRadius(15)

                        }
                        //.padding(.top)
                        
                        Section(header: Text("BIOGRAPHY").font(.system(size: 14)).foregroundColor(Color(.black).opacity(0.7)).padding(.top).padding(.top)) {
                            CustomTextEditor(text: $bio)
                                .padding(.horizontal, 6)
                                .font(.system(size: 17))
                                .frame(width: UIScreen.main.bounds.width - 48, height: 150)
                                .background(secondaryColor)
                                .cornerRadius(15)

                        }
                            
                            
                            // Section to edit pinned books
                        Section(header: Text("PINNED BOOKS").font(.system(size: 13)).foregroundColor(Color(.black).opacity(0.7)).padding(.top).padding(.top, 4)) {
                                VStack {
                                    if pinnedBooks.count > 0{
                                        ScrollView(.horizontal){
                                            HStack{
                                                ForEach(pinnedBooks.indices, id: \.self) { index in
                                                    let book = pinnedBooks[index]
                                                    Image(book.cover)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: UIScreen.main.bounds.width / 7)
                                                        .clipped()
                                                        .cornerRadius(5)
                                                    
                                                    
                                                    
                                                }
                                            }
                                            
                                        }
                                        .scrollIndicators(.hidden)
                                        .padding(.bottom)
                                        .padding(.horizontal)
                                    }
                                    Button(action: {
                                        selectingBooks = true
                                    }) {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "plus")
                                                .font(.system(size: 18, weight: .medium))
                                                .foregroundColor(Color(hex: "#A8A28D"))
                                            Spacer()
                                        }
                                    }
                                }
                                
                                .padding(.vertical)
                                .padding(.horizontal)
                                .background(secondaryColor)
                                .cornerRadius(15)
                                
                            }
                            //.padding(.top)
                            
                            Section(header: Text("PINNED POSTS").font(.system(size: 13)).foregroundColor(Color(.black).opacity(0.7)).padding(.top).padding(.top, 4)) {
                                
                                Button(action: {
                                    selectingPosts = true
                                }) {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "plus")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(Color(hex: "#A8A28D"))
                                        Spacer()
                                    }
                                }
                                .padding(.vertical)
                                .padding(.horizontal)
                                .background(secondaryColor)
                                .cornerRadius(15)
                            }
                            
                            Section(header: Text("PINNED REVIEWS").font(.system(size: 13)).foregroundColor(Color(.black).opacity(0.7)).padding(.top).padding(.top, 4)) {
                                // Your code to edit pinned reviews
                                Button(action: {
                                }) {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "plus")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(Color(hex: "#A8A28D"))
                                        Spacer()
                                    }
                                }
                                .padding(.vertical)
                                .padding(.horizontal)
                                .background(secondaryColor)
                                .cornerRadius(15)
                            }
                            
                            Section(header: Text("PINNED LISTS").font(.system(size: 13)).foregroundColor(Color(.black).opacity(0.7)).padding(.top).padding(.top, 4)) {
                                // Your code to edit pinned lists
                                Button(action: {
                                }) {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "plus")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(Color(hex: "#A8A28D"))
                                        Spacer()
                                    }
                                }
                                .padding(.vertical)
                                .padding(.horizontal)
                                .background(secondaryColor)
                                .cornerRadius(15)
                            }
                        
                        Section(header: Text("PERSONAL INFO").font(.system(size: 13)).foregroundColor(Color(.black).opacity(0.7)).padding(.top).padding(.top, 4)) {
                            VStack(alignment:.leading, spacing: 10){
                                TextField("E-Mail", text: $email)
                                Divider()
                                TextField("Phone", text: $phone)
                                Divider()
                                TextField("Birthday", text: $birthday)
                                Divider()
                                Button("Password & Security"){
                                    
                                }
                                Divider()
                                Button("Content Filters"){
                                    
                                }
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 6)
                            .font(.system(size: 17))
                            .background(secondaryColor)
                            .cornerRadius(15)

                        }
                            
                        
                        
                    }
                    .padding(.top)
                    .padding(.horizontal, 23)
                    //.scrollContentBackground(.hidden)
                    .background(backgroundColor)
                }
            }
            .background(backgroundColor)
            .sheet(isPresented: $selectingBooks) {
                SelectBooks(isPresenting: $selectingBooks, user: user, selected: $pinnedBooks)
                    .presentationDetents([.fraction(0.95)])
            }
            .sheet(isPresented: $selectingPosts) {
                SelectPosts(isPresenting: $selectingPosts, user: user)
                    .presentationDetents([.fraction(0.95)])
            }
        }
    }

    private func saveChanges() {
        user.name = name
        user.handle = handle
        user.location = location
        user.instagram = instagram
        user.bio = bio
        user.profileDisplay.pinnedBooks = pinnedBooks
        user.profileDisplay.pinnedPosts = pinnedPosts
        user.profileDisplay.pinnedReviews = pinnedReviews
        user.profileDisplay.pinnedLists = pinnedLists
        if let profileImage = profileImage {
            user.photo = saveImageToDocuments(image: profileImage)
            self.profileImage = loadImage(from: user.photo) // Update the profileImage state
        }
    }

    private func saveImageToDocuments(image: UIImage) -> String {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return "" }
        let filename = UUID().uuidString + ".jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        try? data.write(to: url)
        return url.path // Return the local path
    }

    private func loadImage(from path: String) -> UIImage? {
        guard !path.isEmpty else { return nil }
        let fullPath = getDocumentsDirectory().appendingPathComponent(path).path
        return UIImage(contentsOfFile: fullPath)
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}



struct SelectBook: View {
    @Binding var isPresenting: Bool
    @Binding var selected: Book?
    @State var isSelected: Bool = false
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var userData: UserData
    var saveChanges: (Book) -> Void

    var body: some View {
        let userLibrary = userData.user.currentReads.books + userData.user.pastReads.books + userData.user.readingList.books

        VStack {
            SelectBookBar(database: userLibrary, selectedBook: $selected)
                .onChange(of: selected) { newSelectedBook in
                    if let newSelectedBook = newSelectedBook {
                        isSelected = true
                        saveChanges(newSelectedBook)
                        isPresenting.toggle()
                    }
                }

        
        }
        .padding()
        .background(backgroundColor)
    }
}

struct SelectBooks: View {
    @Binding var isPresenting: Bool
    @ObservedObject var user: User
    @Binding var selected: [Book]
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        var userLibrary = userData.user.currentReads.books + userData.user.pastReads.books + userData.user.readingList.books

        
        VStack {
            HStack {
                Text("PINNED")
                    .font(.system(size: 13.5))
                    .opacity(0.7)
                Spacer()
                Text("\(selected.count) / 8")
                    .font(.system(size: 13.5))
                    .opacity(0.7)
            }
            .padding(.horizontal)
            .padding(.top)
            
            
        
            if selected.count == 0{
                HStack {
                    Text("No Books Pinned Yet")
                        .font(.system(size: 14))
                    Spacer()
                }
                .padding()
                
            }
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(selected.indices, id: \.self) { index in
                        let book = selected[index]
                        Image(book.cover)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 5)
                            .clipped()
                            .cornerRadius(5)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color(.black).opacity(0.25))
                                        .overlay(
                                            Image(systemName: "xmark")
                                                .font(.system(size: 18, weight: .medium))
                                                .foregroundColor(.white)
                                        )
                                

                            )
                            .onTapGesture {
                                selected.remove(at: index)
                            }
                        
                        
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            .padding(.bottom)
            .padding(.horizontal)
            Divider()
                .padding(.vertical, 2)
        
        
        SearchSelectBooksBar(database: userLibrary, selectedBooks: $selected)
        
        Button("Done"){
            saveChanges()
            isPresenting.toggle()
        }
        }
        .background(backgroundColor)
    }
    private func saveChanges() {
        user.profileDisplay.pinnedBooks = selected
       
    }
}

struct SingleSelectionGrid: View {
    @Binding var searchText : String
    @State private var showPopover = false
    @EnvironmentObject var library: Library
    @State var books: [Book]
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var selectedBook: Book?
    @State var inExplore = false


    @State var isTapped = false

    var body: some View {
        var filteredBooks: [Book] {
            if searchText.isEmpty {
                return books
            } else {
                return books.filter { book in
                    book.title.localizedCaseInsensitiveContains(searchText) || book.author.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
        if !books.isEmpty {
            let columns = splitBooksList(books: filteredBooks, into: 3)
        
            GeometryReader { geometry in
                ScrollView{
                    VStack {
                        
                        HStack(alignment: .top, spacing: 10) { // Adjust spacing as necessary
                            ForEach(0..<3) { columnIndex in
                                LazyVStack(spacing: 20) {
                                    ForEach(columns[columnIndex], id: \.self) { book in
                                        
                                        VStack(alignment: .leading) {
                                            Image(book.cover)                   .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: geometry.size.width / 3.4 /*(UIScreen.main.bounds.width) / 4.2*/)
                                                .clipped() // This will clip the overflow
                                                .cornerRadius(5)
                                                .onTapGesture {
                                                    selectedBook = book
                                                }
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    }
                                    
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                }
                .background(backgroundColor)
                }
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
struct SelectionGrid: View {
    @Binding var searchText : String
    @State private var showPopover = false
    @EnvironmentObject var library: Library
    @State var books : [Book]
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var selectedBooks : [Book]
    @State var inExplore = false
        //Color(.white)


    @State var isTapped = false

    var body: some View {
        var filteredBooks: [Book] {
            if searchText.isEmpty {
                return books
            } else {
                return books.filter { book in
                    book.title.localizedCaseInsensitiveContains(searchText) || book.author.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
        if !books.isEmpty {
            let columns = splitBooksList(books: filteredBooks, into: 3)
        

                VStack {
                
                HStack(alignment: .top, spacing: 10) { // Adjust spacing as necessary
                    ForEach(0..<3) { columnIndex in
                        LazyVStack(spacing: 20) {
                            ForEach(columns[columnIndex], id: \.self) { book in
                                
                                VStack(alignment: .leading) {
                                    Image(book.cover)                   .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: (UIScreen.main.bounds.width) / 4.2)
                                        .clipped() // This will clip the overflow
                                        .cornerRadius(5)
                                        .onTapGesture {
                                            if selectedBooks.count < 8 {
                                                selectedBooks.append(book)
                                            }
                                        }
                                        
                                    
                                    
                                    
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

struct SelectLists: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

struct PostSelectionGrid: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

struct SelectPosts: View {
    @Binding var isPresenting: Bool
    @ObservedObject var user: User
    @State var backgroundColor = Color(hex: "#FDFAEF")
    
    var body: some View {
        VStack {
        VStack{
            
                HStack {
                    Text("PINNED")
                        .font(.system(size: 13.5))
                        .opacity(0.7)
                    Spacer()
                }
                .padding(.leading)
                .padding(.top)
            
            if user.profileDisplay.pinnedPosts.count == 0{
                HStack {
                    Text("No Posts Pinned Yet")
                        .font(.system(size: 14))
                    Spacer()
                }
                .padding()

                
            }
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(user.profileDisplay.pinnedPosts) { post in
                        
                        HStack(alignment: .top){
                            
                            Button(action: {}){
                                Image(post.book.cover)
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
                                
                                
                                Button(action: {
                                    
                                }){
                                    
                                    
                                    VStack(alignment: .leading) {
                                        
                                        
                                        Text(post.title)
                                            .font(.system(size: 15, weight: .medium))
                                            .padding(.top, 2)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                        
                                        
                                        
                                        Text(post.description)
                                            .font(.system(size: 14))
                                            .lineLimit(4)
                                            .lineSpacing(2.5)
                                            .padding(.vertical)
                                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                        
                                        
                                    }
                                    .frame(width: 200, height: 150)
                                    .onTapGesture {
                                        user.profileDisplay.pinnedPosts.append(post)
                                        
                                    }
                                    
                                }
                            }
                            
                            
                            
                        }
                        .foregroundColor(.black)
                        .padding()
                        .background(backgroundColor)
                        /*
                         .onTapGesture {
                         user.profileDisplay.pinnedPosts.remove(at: index)
                         }*/
                        
                        
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            /*
            Button("Done"){
                isPresenting.toggle()
            }*/
        }
        ScrollView {
            var allPosts = user.getAllPosts()
            ForEach(allPosts) { post in
                
                
                
                HStack(alignment: .top){
                    
                    Button(action: {}){
                        Image(post.book.cover)
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
                            Button(action: {
                                
                            }){
                                ProfileThumbnail(image: post.user.photo, size: 25)
                                
                                Text("\(post.user.name)")
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.trailing, -1)
                            }
                            Spacer()
                            
                            
                            
                        }
                        .padding(.top)
                        
                        
                        Button(action: {
                            
                            
                            
                        }){
                            
                            
                            VStack(alignment: .leading) {
                                
                                
                                Text(post.title)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 2)
                                
                                
                                
                                Text(post.description)
                                    .font(.system(size: 15))
                                    .lineLimit(7)
                                    .lineSpacing(2.5)
                                    .padding(.vertical)
                                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                
                                var formattedDate: String {
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "MMMM d" // For full month name and day
                                        // dateFormatter.dateFormat = "MMM d" // For abbreviated month name and day
                                        return dateFormatter.string(from: post.timestamp)
                                    }
                                
                                HStack {
                                    Text("\(formattedDate)")
                                        .padding(.vertical, 2)
                                        .font(.system(size: 13))
                                        .opacity(0.7)
                                    Spacer()
                                    
                                    Text("\(post.likes) likes")
                                        .font(.system(size: 13))
                                        .opacity(0.7)
                                        .padding(.trailing)
                                    
                                    Text("\(post.comments.count) comments")
                                        .font(.system(size: 13))
                                        .opacity(0.7)
                                        .padding(.trailing)
                                    
                                    
                                    
                                    
                                }
                                .offset(y: 5)
                                
                                
                                
                            }
                            .onTapGesture {
                                user.profileDisplay.pinnedPosts.append(post)
                                
                            }
                            
                        }
                    }
                    
                    
                    
                }
                .foregroundColor(.black)
                .padding()
                .background(backgroundColor)
                
                
                
                
                
                
                
            }
        }
    

        Button("Close"){
            isPresenting.toggle()
        }
        }
            .background(backgroundColor)
    }
}


struct SelectReviews: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}/*


                        #Preview{
                            EditProfileView(isPresenting: .constant(true), user:  User(id: UUID(), handle: "alanazoe", name: "Alana", photo: "me", bio: "chronically reading", location: "ny", followers: 432, following: 385, currentReads: List(id: UUID(), title: "Current Reads", books: []), pastReads: List(id: UUID(), title: "Past Reads", books: []), readingList: List(id: UUID(), title: "My List", books: []), lists: [], library: [], ratings: [], reviews: [:], feed: []))
                            
                        }
*/
