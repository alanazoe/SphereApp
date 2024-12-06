//
//  EReaderView.swift
//  media discussion
//
//  Created by Alana Greenaway on 2/16/24.
//

import SwiftUI
//import UIKit

struct ShareQuotePreview: View {
    @Binding var isPresenting: Bool
    @Binding var quote: String
    @EnvironmentObject var lightModeController: LightModeController
    @State var book: Book
    @EnvironmentObject var userData: UserData
    @State var text: String = ""
    @State var foregroundColor = Color(.black)
    @State var backgroundColor = Color(hex: "F0E2C8")

    var body: some View {
        VStack{
            Text("Share Quote")
                .font(.system(size: 14, weight: .medium))
            HStack{
                Spacer()
            }
            VStack {
                Text("\(quote)")
                    .font(.custom("Baskerville", size: 18))
                    .lineSpacing(5)
                    .foregroundColor(foregroundColor)
                    .padding()
                HStack {
                    Text("— \(book.title)")
                        .font(.custom("Baskerville-SemiBold", size: 16))

                    Text(", page \(book.ebook.getCurrentPage()+1)")
                        .font(.custom("Baskerville", size: 16))
                        .padding(.leading, -4)

            }
                .foregroundColor(foregroundColor)


                
            }
                .frame(width: 300, height: 300)
                //.background(backgroundColor)
                .cornerRadius(10.0)
                .padding(.top, 40)
            HStack {
                Button(action: {
                    foregroundColor = Color(hex: "#386B33")
                }){
                    Circle()
                        .foregroundColor(Color(hex: "#386B33"))
                }
                .frame(width: 50)
                Button(action: {
                    
                    foregroundColor = Color(hex: "#631117")

                }){
                    Circle()
                        .foregroundColor(Color(hex: "#631117"))
                }
                .frame(width: 50)

                Button(action: {
                    
                    foregroundColor = Color(hex: "#291F76")

                }){
                    Circle()
                        .foregroundColor(Color(hex: "#291F76"))
                }
                .frame(width: 50)

                Button(action: {
                    foregroundColor = Color(hex: "#DB4022")

                }){
                    Circle()
                        .foregroundColor(Color(hex: "#DB4022"))
                }
                .frame(width: 50)

                Button(action: {
                    foregroundColor = Color(.black)

                }){
                    Circle()
                        .foregroundColor(Color(.black))
                }
                .frame(width: 50)

                Button(action: {
                    swapForegroundBackground()
                }){
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
                
                
            }
            .padding(.top)

            
            CustomTextEditor(text: $text, backgroundColor: UIColor(lightModeController.getBackgroundColor()), placeholder: "Share your thoughts on this quote...")
                .padding(.horizontal, 6)
                .font(.system(size: 17))
                .frame(width: 650, height: 300)
                //.background(secondaryColor)
                .cornerRadius(10)
                .padding(.top, 40)
            
            Spacer()

            Button(action: {
                shareQuote()
                isPresenting = false
            }){
                Text("Share")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .background(Color(.black))
                    .cornerRadius(10)
                    .padding(.top)
            }
            Spacer()
                     
        }
        .padding(.vertical)
        .background(lightModeController.getBackgroundColor())
        .foregroundColor(lightModeController.getForegroundColor())


    }
    func shareQuote(){
        let newQuote = Quote2(id: UUID(), user: userData.user, quote: quote, description: text, likes: 0, comments: [], timestamp: Date(), book: book)
        
        let item = FeedItem(id: UUID(), type: .quote, quote: newQuote)
        userData.sendToFeed(item: item)
    }
    func swapForegroundBackground(){
        var temp = foregroundColor
        foregroundColor = backgroundColor
        backgroundColor = temp
    }
}
struct ShareQuote: View {
    @State var quote: String
    @State var book: Book
    @State var description: String = ""
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "arrow.left")
            Text("Share Quote")
                .font(.system(size: 20, weight: .medium))
                .padding(.bottom)

            Text("\"\(quote)\"")
                .font(.system(size: 18))
                .lineSpacing(5)
                .padding(.top)
                .padding()
                .background(Color(hex: "#291F00").opacity(0.05))
                .cornerRadius(10.0)
                .padding()
            Spacer()
            CustomTextEditor(text: $description)
                .font(.system(size: 18, weight: .medium))
                .background(backgroundColor)
                .padding(.vertical)

            Button(action: {}){
                Text("Share")
            }
            
        }
        .padding()
        .padding(.vertical)
        .padding(.top, 30)
        .background(backgroundColor)
    }
    
    func shareQuote(){
        let newQuote = Quote2(id: UUID(), user: userData.user, quote: quote, description: "", likes: 0, comments: [], timestamp: Date(), book: book)
        
        let item = FeedItem(id: UUID(), type: .quote, quote: newQuote)
        userData.sendToFeed(item: item)
    }

}


import SwiftUI
struct EReaderView: View {
    @EnvironmentObject var userData: UserData
    @Binding var media: Book
    @State var currentPageIndex: Int = 0
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var foregroundColor = Color(hex: "#000000")
    @State private var bookPages: [String] = []
    @State var isVisible = false
    @State var fontSize: Double = 15.0
    @State private var isPresentingFormatPopup = false
    @State private var isLoading = true
    @State var isShareQuotePresented = false
    @State var sharedQuote = ""
    @State var createQuotePost = false
    @State private var bookContent: String = ""
    
    @State var xoffset = 0.0
    @Binding var showEReader: Bool
    
    
    private let preferredPageLength = 1300
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ScrollView {
                    if isLoading {
                        ProgressView("Loading book...")
                    } else {
                        Text(bookContent)
                            .font(.system(size: fontSize))
                            .padding()
                    }
                }
                .onAppear {
                    loadBookContent(fileName: "cleanedfile")
                }
                .padding(.horizontal)
                .overlay(
                    VStack {
                        if isVisible {
                            VStack {
                                HStack {
                                    Button(action: { showEReader = false }) {
                                        Image(systemName: "arrow.left")
                                            .font(.system(size: 18 + fontSize, weight: .medium))
                                    }
                                    .transaction { $0.disablesAnimations = true }
                                    Spacer()
                                    Text(media.title)
                                        .font(.system(size: 14 + fontSize, weight: .medium))
                                        .frame(width: 190)
                                        .lineLimit(1)
                                        .padding(.trailing, -30)
                                    Spacer()
                                    Image(systemName: "headphones")
                                        .font(.system(size: 13))
                                        .padding(.trailing, 10)
                                    Button(action: { isPresentingFormatPopup = true }) {
                                        Text("Aa")
                                            .font(.system(size: 13 + fontSize, weight: .medium))
                                    }
                                }
                                .foregroundColor(foregroundColor)
                                .padding()
                                .padding(.horizontal)
                                .background(backgroundColor)
                                Spacer()
                            }
                            .padding(.top, 100)
                        } else {
                            VStack {
                                HStack {
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .padding(.horizontal)
                                .background(backgroundColor)
                                Spacer()
                            }
                        }
                    }
                        .animation(.linear(duration: 0.3))
                )
                .background(backgroundColor)
                
                VStack {
                    Spacer()
                   // CommentButton(num: 3200)
                    ProgressBar(totalPages: 1, currentPage: 1)
                        .padding(.bottom, 100)
                }
                .padding()
                if createQuotePost {
                    ShareQuote(quote: sharedQuote, book: media)
                }
            }
            /*
            .sheet(isPresented: $isShareQuotePresented) {
                ShareQuotePreview(isPresenting: $isShareQuotePresented, quote: sharedQuote, isShareQuotePresented: $createQuotePost, book: media)
                    .presentationDetents([.fraction(0.6)])
                    .background(backgroundColor)
            }*/
            .sheet(isPresented: $isPresentingFormatPopup) {
               /* FormatPopup(isPresenting: $isPresentingFormatPopup, backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, fontSize: $fontSize)
                    .presentationDetents([.fraction(0.6)])*/
            }
        }
        .navigationBarHidden(true)
    }

      private func loadBookContent(fileName: String) {
          DispatchQueue.global(qos: .userInitiated).async {
              if let bookContent = readTextFromFile(fileName) {
                  DispatchQueue.main.async {
                      self.bookContent = bookContent
                      self.isLoading = false
                  }
              } else {
                  DispatchQueue.main.async {
                      self.isLoading = false
                      print("Failed to load book content")
                  }
              }
          }
      }

      private func readTextFromFile(_ fileName: String) -> String? {
          guard let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") else {
              print("File not found")
              return nil
          }
          do {
              return try String(contentsOfFile: filePath, encoding: .utf8)
          } catch {
              print("Error reading the file: \(error)")
              return nil
          }
      }
}

/*
 
 {
     @EnvironmentObject var userData: UserData
     //@Binding var user: User
     @Binding var media: Book
     @State var currentPageIndex : Int
     @State var backgroundColor = Color(hex: "#FDFAEF")
         //hex: "#F1EFE9")
     @State private var bookPages: [String] = []
     @State var isVisible = false
     @State var fontSize = 0.0
     @State private var isPresentingFormatPopup = false
     @State var foregroundColor = Color(hex: "#000000")
     
     private let preferredPageLength = 1300 // Number of characters per page
     @State var showBook = true
     @Binding var showEReader : Bool
     @State var xoffset = 0.0
     @State private var isLoading = true  // Loading state
     @State var isShareQuotePresented: Bool = false
     @State var sharedQuote: String = ""
     @State var createQuotePost = false
     var body: some View {
         ZStack {
             NavigationView {
                 VStack {
                     ZStack {
                         
                         
                         
                         
                         
                         // Text("\(bookPages.count)")
                         
                         if !bookPages.isEmpty {
                             // Display current page
                             CustomTextViewRepresentable(text: $bookPages[currentPageIndex], fontSize: 18, foregroundColor: UIColor(foregroundColor), lineSpacing: 7, onShare: { quote in
                                 sharedQuote = quote
                                 if sharedQuote != "" {
                                     isShareQuotePresented = true
                                 }
                             })
                             .padding()

                                 .onChange(of: currentPageIndex) { _ in
                                     // Update progress bar when page changes
                                     updateProgressBar()
                                 }
                                 .padding(.top, 100)
                                 .padding(.horizontal)
                             
                         }
                         
                         
                         
                         HStack(){
                             Rectangle()
                                 .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height)
                                 .foregroundColor(.white)
                                 .opacity(0.01)
                                 .onTapGesture {
                                     previousPage()
                                     isVisible = false
                                     
                                 }
                             
                             
                             Rectangle()
                                 .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height)
                                 .foregroundColor(.white)
                                 .opacity(0.01)
                                 .onTapGesture {
                                     isVisible.toggle()
                                 }
                             
                             Rectangle()
                                 .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height)
                                 .foregroundColor(.white)
                                 .opacity(0.01)
                                 .onTapGesture {
                                     nextPage()
                                     isVisible = false
                                     
                                 }
                             
                             
                         }
                         
                         
                         
                         
                     }
                     
                     CommentButton(num: 3200)
                     
                     ProgressBar(totalPages: bookPages.count, currentPage: currentPageIndex + 1)
                         .padding(.bottom, 100)
                 }
                 .sheet(isPresented: $isShareQuotePresented){
                     ShareQuotePreview(isPresenting: $isShareQuotePresented, quote: sharedQuote, isShareQuotePresented: $createQuotePost, book: media)
                         .presentationDetents([.fraction(0.6)])
                         .background(backgroundColor )

                 }
                 .sheet(isPresented: $isPresentingFormatPopup){
                     FormatPopup(isPresenting: $isPresentingFormatPopup, backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, fontSize: $fontSize)
                         .presentationDetents([.fraction(0.6)])
                 }
                 .onAppear{
                     loadBookContentIncrementally(fileName: "cleanedfile", frameWidth: UIScreen.main.bounds.width * 0.97, fontSize: 18)
                     
                     updateProgressBar()
                     isVisible = true // Set boolean to true when view appears
                     
                     // Use a timer to set boolean to false after 3 seconds
                     Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
                         isVisible = false
                     }
                     
                 }
                 .gesture(
                     DragGesture()
                         .onEnded { gesture in
                             if gesture.translation.width > 20 { // Swipe right
                                 previousPage()
                                 isVisible = false
                                 
                             } else if gesture.translation.width < -20 { // Swipe left
                                 nextPage()
                                 isVisible = false
                                 
                             }
                         }
                 )
                 .padding(.horizontal)
                 .overlay(
                     VStack{
                         if isVisible {
                             VStack {
                                 
                                 HStack() {
                                     
                                     Button(action: { showEReader = false}){
                                         
                                         Image(systemName: "arrow.left")
                                             .font(.system(size: 18  + fontSize, weight: .medium))
                                     }
                                     .transaction({ transaction in
                                         transaction.disablesAnimations = true
                                     })
                                     Spacer()
                                     
                                     Text(media.title)
                                         .font(.system(size: 14 + fontSize, weight: .medium))
                                         .frame(width: 190)
                                         .lineLimit(1)
                                         .padding(.trailing, -30)
                                     
                                     Spacer()
                                     
                                     Image(systemName: "headphones")
                                         .font(.system(size: 13))
                                         .padding(.trailing, 10)
                                     
                                     Button(action: {isPresentingFormatPopup = true}){
                                         Text("Aa")
                                             .font(.system(size: 13 + fontSize, weight:.medium))
                                     }
                                     /*
                                      Image(systemName: "ellipsis")
                                      .font(.system(size: 16, weight: .medium))
                                      */
                                     
                                     
                                     
                                 }
                                 .foregroundColor(foregroundColor)
                                 .padding()
                                 .padding(.horizontal)
                                 .background(backgroundColor)
                                 Spacer()
                             }
                             .padding(.top, 100)
                         } else {
                             
                             VStack {
                                 
                                 HStack() {
                                     
                                     
                                     Spacer()
                                     
                                     
                                     
                                     
                                 }
                                 .foregroundColor(.black)
                                 .padding(.horizontal)
                                 .background(backgroundColor)
                                 Spacer()
                             }
                             
                             
                         }
                     }
                         .animation(.linear(duration: 0.3))
                 )
                 .background(backgroundColor)
                 
                 .background(backgroundColor)
                 
                 
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
                                 showEReader = false
                             }
                         } else {
                             self.xoffset = 0
                             
                         }
                     }
             )
             .animation(.easeOut, value: xoffset) // Animate the return movement
             
             if createQuotePost {
                 ShareQuote(quote: sharedQuote, book: media)
             }
             
             
         }
             

             
     }
     
     func loadBookContentIncrementally(fileName: String, frameWidth: CGFloat, fontSize: CGFloat) {
         DispatchQueue.global(qos: .userInitiated).async {
             if let bookContent = self.readTextFromFile(fileName) {
                 
                 let allPages = self.splitStringIntoPages(bookContent, frameWidth: frameWidth, font: UIFont(descriptor: UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).addingAttributes([UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.regular]]), size: 15.5))
                 // Load only the first few pages initially
                 let initialLoadCount = allPages.count
                 DispatchQueue.main.async {
                     self.bookPages.append(contentsOf: allPages[0..<initialLoadCount])
                     self.isLoading = false
                 }
                 // Load the rest in the background
                 if allPages.count > initialLoadCount {
                     DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Delay further loading to keep UI smooth
                         self.bookPages.append(contentsOf: allPages[initialLoadCount...])
                     }
                 }
             } else {
                 DispatchQueue.main.async {
                     self.isLoading = false
                     print("Failed to load book content")
                 }
             }
         }
     }


     
     // Read text from file
     private func readTextFromFile(_ fileName: String) -> String? {
         guard let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") else {
             print("File not found")
             return nil
         }
         do {
             let contents = try String(contentsOfFile: filePath, encoding: .utf8)
             print("File read successfully!")
             return contents
         } catch {
             print("Error reading the file: \(error)")
             return nil
         }
     }
     

     func splitStringIntoPages(_ text: String, frameWidth: CGFloat, font: UIFont) -> [String] {
         var pages = [String]()
         var currentPage = ""
         var currentPageHeight: CGFloat = 0
         var currentIndex = text.startIndex

         while currentIndex < text.endIndex {
             // Find the next break, making sure we don't start with a newline
             let nextBreakIndex = findNextBreak(after: currentIndex, in: text)
             
             // Skip initial new lines for new pages
             var effectiveStartIndex = currentIndex
             if text[effectiveStartIndex] == "\n" && currentPage.isEmpty {
                 effectiveStartIndex = text.index(after: effectiveStartIndex)
             }

             let chunk = String(text[effectiveStartIndex..<nextBreakIndex])
             let chunkSize = measureText(chunk, width: frameWidth, font: font)
             let pageHeight = UIScreen.main.bounds.height * 0.6
             
             if currentPageHeight + chunkSize.height > pageHeight {
                 // If adding this chunk exceeds page height, finalize the current page and start a new one
                 if !currentPage.isEmpty {
                     pages.append(currentPage)
                     currentPage = ""
                     currentPageHeight = 0
                 }
                 // Handle the case where the first character of the new page is a newline
                 if chunk.first == "\n" {
                     currentPage = String(chunk.dropFirst())
                 } else {
                     currentPage = chunk
                 }
                 currentPageHeight = measureText(currentPage, width: frameWidth, font: font).height
             } else {
                 // Add chunk to the current page
                 currentPage += chunk
                 currentPageHeight += chunkSize.height
             }

             currentIndex = nextBreakIndex

             // Ensure the last page is added if not empty
             if currentIndex >= text.endIndex && !currentPage.isEmpty {
                 pages.append(currentPage)
             }
         }

         return pages
     }



     func findNextBreak(after index: String.Index, in text: String) -> String.Index {
         let remainingText = text[index...]
         var potentialBreakIndex = remainingText.index(index, offsetBy: 100, limitedBy: text.endIndex) ?? text.endIndex
         if let spaceIndex = remainingText[..<potentialBreakIndex].lastIndex(of: " ") {
             return text.index(after: spaceIndex)
         }
         return potentialBreakIndex
     }


     func measureText(_ text: String, width: CGFloat, font: UIFont) -> CGSize {
         let attributes: [NSAttributedString.Key: Any] = [
             .font: font,
             .paragraphStyle: NSParagraphStyle.default.mutableCopy()
         ]
         let attributedText = NSAttributedString(string: text, attributes: attributes)
         let size = attributedText.boundingRect(with: CGSize(width: width, height: CGFloat.infinity),
                                                options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                context: nil).size
         return size
     }




     
     // Find the extended end index to avoid cutting words
     private func findExtendedEndIndex(from index: String.Index, in text: String) -> String.Index {
         if let spaceIndex = text[index...].firstIndex(of: " ") {
             return spaceIndex
         } else {
             return index
         }
     }



     
     private func nextPage() {
         // Move to the next page
         if currentPageIndex < bookPages.count - 1 {
             currentPageIndex += 1
         }
     }
     
     private func previousPage() {
         // Move to the previous page
         if currentPageIndex > 0 {
             currentPageIndex -= 1
         }
     }
     
     private func updateProgressBar() {
         if currentPageIndex > 0{
             
             if var book = findBookById(books: userData.user.currentReads.books, id: media.id){
                 book.currentPage = currentPageIndex
                 book.totalPages = bookPages.count
                 
                 // move to front of the list
                 if let index = userData.user.currentReads.books.firstIndex(of: book) {
                     userData.user.currentReads.books.remove(at: index)
                     userData.user.currentReads.books.insert(book, at: 0)
                 }
                 
             }
             
         }
         // Update progress bar based on current page
         // Implementation omitted for brevity
     }
     
     func findBookById(books: [Book], id: UUID) -> Book? {
         return books.first { $0.id == id }
     }
 }
 */

struct FormatPopup: View {
    @Binding var isPresenting : Bool
    @EnvironmentObject var lightModeController: LightModeController
    @Binding var fontSize : Double
    var body: some View {
        VStack {
            ZStack {
                Text("Format Settings")
                    .font(.system(size: 14, weight: .medium))
                    .padding(.top)
                HStack{
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 14))
                        .padding(.trailing)
                        .onTapGesture {
                            isPresenting.toggle()
                        }
                }
            }
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    VStack (alignment: .leading){
                        Text("Light Mode")
                            .font(.system(size: 14, weight: .medium))
                        Button(action: {
                            lightModeController.switchMode()
                        }){
                            Image(systemName: "sun.max.circle.fill")
                                .font(.system(size: 30))

                            /*RoundedRectangle(cornerRadius: 10)
                                .frame(width: 130, height: 70)
                                .foregroundColor(.white)
                                .overlay(
                                    Text("Loreum Lorepsom")
                                        .font(.system(size: 13 + fontSize))
                                        .foregroundColor(.black)
                                )*/
                        }
                        .frame(width: 50, height: 50)

                    }
                    .padding()
                    
                    VStack(alignment: .leading){
                        
                        Text("Dark Mode")
                            .font(.system(size: 14, weight: .medium))
                        Button(action: {
                            lightModeController.switchMode()

                            
                        }){
                            Image(systemName: "moon.circle.fill")
                                .font(.system(size: 30))

                            /*RoundedRectangle(cornerRadius: 10)
                                .frame(width: 130, height: 70)
                                .foregroundColor(.black)
                                .overlay(
                                    Text("Loreum Lorepsom")
                                        .font(.system(size: 13 + fontSize))
                                        .foregroundColor(.white)
                                )*/
                        }
                        .frame(width: 50, height: 50)

                    }
                    .padding()
                    
                    
                }
                
                VStack (alignment: .leading){
                    
                    Text("Font Size")
                        .font(.system(size: 14, weight: .medium))
                    
                    HStack {
                        Button(action: { if fontSize > -2 {
                            fontSize -= 1}
                        }){
                            Circle()
                                .frame(width: 40)
                                .foregroundColor(lightModeController.getForegroundColor())

                                .overlay(
                            Text("-")
                                .foregroundColor(lightModeController.getBackgroundColor())
                            )
                            
                        }
                        .frame(width: 50, height: 50)
                        
                        
                        Button(action: { if fontSize < 2 { fontSize += 1} }){
                            Circle()
                                .frame(width: 40)
                                .foregroundColor(lightModeController.getForegroundColor())
                                .overlay (
                                    Text("+")
                                        .foregroundColor(lightModeController.getBackgroundColor())
                                )
                        }
                        .frame(width: 50, height: 50)
                        
                    }
                    .padding()
                    
                }
                .padding()
                
                
            }
            .padding()
        }
        .frame(width: 300)
        .foregroundColor(lightModeController.getForegroundColor())
        .background(lightModeController.getBackgroundColor())

    }

}


class PlayPauseController: ObservableObject {
    var id: UUID
    @Published var playing: Bool
    @Published var book: Book
    private var timer: Timer?
    
    init(playing: Bool = false, book: Book = Book()) {
        self.id = UUID()
        self.playing = playing
        self.book = book
        self.timer = nil
    }
    
    func isPlaying() -> Bool {
        return playing
    }
    
    func toggle() {
        playing.toggle()
    }
    
    func getTimer() -> Timer? {
        return timer
    }
    
    func setTimer(timer: Timer?) {
        self.timer = timer
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

struct AudioProgressBar: View {
    @Binding var currentSecond: Double // Use Double for smoother scrubbing
    @Binding var totalSeconds: Double
    @State private var height: Double = 3
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .leading) {
                    // Background track
                    Rectangle()
                        .foregroundColor(lightModeController.getForegroundColor().opacity(0.1))
                        .frame(width: geometry.size.width, height: height)
                        .cornerRadius(4)
                    
                    // Progress track
                    Rectangle()
                        .foregroundColor(lightModeController.getForegroundColor())
                        .frame(width: calculateProgressWidth(geometry: geometry), height: height)
                        .cornerRadius(4)
                        .opacity(0.7)
                    
                    // Invisible draggable layer
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                    
                }
                .frame(height: height)
                HStack {
                    Text(formatSecondsToTime(currentSecond))
                    Spacer()
                    
                    Text(formatSecondsToTime(totalSeconds))
                }
                .font(.system(size: 11))

            }
        }
        .frame(height: height + 15)
    }
    
    // Calculate the progress bar width
    private func calculateProgressWidth(geometry: GeometryProxy) -> CGFloat {
        let progress = currentSecond / totalSeconds
        return CGFloat(progress) * geometry.size.width
    }


}

func formatSecondsToTime(_ seconds: Double) -> String {
    let totalSeconds = Int(seconds.rounded()) // Round to the nearest whole number
    let minutes = totalSeconds / 60
    let remainingSeconds = totalSeconds % 60
    return String(format: "%02d:%02d", minutes, remainingSeconds)
}

struct ProgressBar: View {
    var totalPages: Int = 100
    var currentPage: Int = 10
    @State var height: Double = 3
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(lightModeController.getForegroundColor().opacity(0.1))
                    .frame(width: geometry.size.width, height: height)
                    .cornerRadius(4)
                
                Rectangle()
                    .foregroundColor(lightModeController.getForegroundColor())
                    .frame(width: calculateProgressWidth(geometry: geometry), height: height)
                    .cornerRadius(4)
                    .opacity(0.7)
                    .animation(.linear(duration: 0.3)) // Add animation

            }
            .frame(height: height)
        }
        .frame(height: height)
    
        

    }
    
    private func calculateProgressWidth(geometry: GeometryProxy) -> CGFloat {
        let totalWidth = geometry.size.width
        let progressWidth = totalWidth / CGFloat(totalPages) * CGFloat(currentPage)
        return progressWidth
    }
}

struct TransitionView: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}
