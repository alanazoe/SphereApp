//
//  App.swift
//  sphere
//
//  Created by Alana Greenaway on 5/26/24.
//

import SwiftUI

var openNotes: Bool = false
var chosenBook: Book? = nil

struct AppController: View {
    @State var showLibrary = true
    @State var showExplore = false
    @State var showReader = false
    @State var showFeed = false
    @State var showProfile = false
    @State var showToolbar = true
    @StateObject var exploreViewModel = ExploreViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var navigation: Nav
    @State var spherestudent = false
    @EnvironmentObject var allBooks: Library
    @State var showAddToListPopup: Bool = false
    @EnvironmentObject var notificationCoordinator: NotificationCoordinator
    @State var showSidebar = false

/*
    @StateObject var libraryViewModel = LibraryViewModel()
    @StateObject var exploreViewModel = ExploreViewModel()
    @StateObject var feedViewModel = FeedViewModel()
    @StateObject var profileViewModel = ProfileViewModel()
    */
    var body: some View {
        if spherestudent {
           
           
            
            ZStack {
                
                if navigation.showingLibrary() {
                    StudentLibraryView()
                } else if navigation.showingReader() {
                    /*ReaderView(book: navigation.getSelectedBook() ?? Book(), showToolbar: $showToolbar)*/
                } else if navigation.showingProfile() {
                    StudentDashboard(showToolbar: $showToolbar)
                }
                
                if showToolbar && horizontalSizeClass == .compact{
                    VStack(){
                        Spacer()
                        SphereStudentToolbar()
                    }
                } else if showToolbar && horizontalSizeClass != .compact {
                    VStack(){
                        Spacer()
                        SphereStudentToolbar()
                        
                    }
                }
                
            }
        } else {
            
            ZStack {
                
                if navigation.showingLibrary() {
                    LibraryView(showToolbar: $showToolbar, showSidebar: $showSidebar)
                        .onAppear {
                            showToolbar = true
                        }
                        .onDisappear{
                            showSidebar = false
                        }
                } else if navigation.showingExplore() {
                    ExploreView(viewModel: exploreViewModel, showToolbar: $showToolbar)
                } else if navigation.showingReader() {
                    EBookView(book: navigation.getSelectedBook() ?? Book())

                   // ReaderView(book: navigation.getSelectedBook() ?? Book(), showToolbar: $showToolbar)
                } else if navigation.showingFeed() {
                    HotView()
                } else if navigation.showingProfile() {
                    MyProfileView(showToolbar: $showToolbar)
                }
                
                if showToolbar && horizontalSizeClass == .compact{
                    VStack(){
                        Spacer()
                        if notificationCoordinator.showPopup {
                            AnyView(notificationCoordinator.notification)
                              
                        }
                        ToolbarView()
                            .offset(x: showSidebar ? -UIScreen.main.bounds.width * 0.82 : 0)
                            .animation(.easeInOut(duration: 0.3), value: showSidebar) // Smooth animation
                            .shadow(radius: 8)

                    }
                } else if showToolbar && horizontalSizeClass != .compact && !navigation.showingReader() {
                    VStack(){
                        Spacer()
                        iPadToolbarView()
                        
                    }
                }
                
            }
            
            
        }
    }
    

}

struct BlankView: View {
    var body: some View {
        VStack {
            
        }
    }
}

class NotificationCoordinator: ObservableObject {
    @Published var showPopup: Bool
    @Published var notification: any View
    @Published var changeButtonTriggered: Bool

    init(showPopup: Bool = false, notification: any View = BlankView(), changeButtonTriggered: Bool = false) {
        self.showPopup = showPopup
        self.notification = notification
        self.changeButtonTriggered = changeButtonTriggered
    }
    
    func sendAddToListNotification(book: Book, list: List) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            self.showPopup = true
            
        }
        
        self.notification = NotificationPopup(image: Image(book.cover), message: AnyView(HStack {
            BookTitleText(text: book.title, size: 15)
            Text("added to \(list.title)")

        }))

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.showPopup = false
        }
    }
    
    func sendMarkBookStatusNotification(book: Book, status: StatusType) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            self.showPopup = true
        }
        self.notification = NotificationPopup(image: Image(book.cover),
            message: AnyView(HStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 23, height: 23)
                .foregroundColor(status.color)

                .padding(.trailing, 4)
            //BookTitleText(text: book.title, size: 13)
            Text("Marked as \(status.displayName)")
                .font(Font(UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(0.1))))

            })
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.showPopup = false
        }
    }
    
    func sendAddedToLibraryNotification() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            self.showPopup = true
        }
        self.notification = NotificationPopup(image: Image(""),
            message: AnyView(HStack {

            Text("Added to library")
                .font(Font(UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(0.1))))

            })
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.showPopup = false
        }
    }
    
    
}


