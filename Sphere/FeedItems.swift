//
//  FeedItems.swift
//  sphere
//
//  Created by Alana Greenaway on 9/19/24.
//

import SwiftUI

struct UserRead: View {
    
    @State var isLiked : Bool = false
    @State var post = Note()
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @Binding var showPostActions : Bool
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @EnvironmentObject var userData: UserData
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        HStack(alignment: .top){
                
                Button(action: { showBook = true }){
                    Image(post.book.cover)
                        .resizable()
                        .aspectRatio(contentMode: .fit) // Changed to .fill to ensure the image covers the area
                        .frame(height: UIScreen.main.bounds.height * 0.2 )

                    //.frame(height: iPadOrientation ? UIScreen.main.bounds.height * 0.1 : 80 )
                        .clipped() // This ensures the image is clipped to the frame bounds
                        .cornerRadius(5) // Apply corner radius directly to the image
                        .shadow(radius: 0.5)
                        .padding(.top)
                        .padding(.trailing)
                        //.padding(.trailing, 3)
                    
                
            }
        VStack {
            

            HStack {
                Button(action: {
                    showProfile = true
                    selectedProfile = post.user
                }){
                    ProfileThumbnail(image: post.user.photo, size: 30)
                    
                    Text("\(post.user.name)")
                        .font(.system(size: 15, weight: .medium))
                        .padding(.trailing, -1)
                    Text("read")
                        .font(.system(size: 15, weight: .medium))
                        .padding(7)
                        .lineLimit(1)
                        .foregroundColor(.black)
                        .background(
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color(hex: "#FDFAEF"))
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color(.green).opacity(0.1))
                            }
                        )
                        //.padding(.trailing, -3)

                    Text(post.book.title)
                        .font(.system(size: 15, weight: .medium))
                        .underline(true, color: .black)
                    
                }
                Spacer()
                Text(timeSince(from: post.timestamp))
                    .padding(.vertical, 2)
                    .font(.system(size: 11))
                    .opacity(0.7)
                
                
                
            }
            .padding(.top)
            
            Button(action: {
                selectedBook = post.book
                showBook = true
                
                
            }){
                
                                            
                        VStack(alignment: .leading) {
                            let read = userData.user.read(book: post.book)
                           /* HStack {
                                Text("\(post.book.title)")
                                    .font(.system(size: 11.5))
                                    .underline(true, color: .black)
                                //.opacity(0.5)
                                    .padding(.bottom, 2)
                                    .padding(.top, 2)
                                Spacer()
                            }*/
                                
                          
                                    Text("SYNOPSIS")
                                        .font(.system(size: 12))
                                        .padding(.vertical, 2)
                                        .opacity(0.7)
                                        .padding(.top)
                                        .padding(.bottom, 3)
                                    
                             
                                
                                
                            Text(post.book.synopsis)
                                    .font(.system(size: 15))
                                    .lineLimit(7)
                                    .lineSpacing(4)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom)
                                  
                            
                                
                            
                            HStack {
                               
                                Spacer()
                                
                                Text("\(post.likes) likes")
                                    .font(.system(size: 13))
                                    .opacity(0.7)
                                    .padding(.trailing)
                                if post.comments.count > 0 {
                                    
                                    Text("\(post.comments.count) comments")
                                        .font(.system(size: 13))
                                        .opacity(0.7)
                                        .padding(.trailing)
                                }
                                
                                
                                if !isLiked {
                                    Button(action: {
                                        isLiked.toggle()
                                        post.likes += 1
                                        
                                    }){
                                        Image(systemName: "heart")
                                            .font(.system(size: 19))
                                            //.foregroundColor(.black)
                                    }
                                } else {
                                    Button(action: {
                                        isLiked.toggle()
                                        post.likes -= 1
                                        
                                    }){
                                        Image(systemName: "heart.fill")
                                            .font(.system(size: 19))
                                            .foregroundColor(.pink)
                                    }
                                }
                                
                            }
                            .offset(y: 5)
                            
                        }
                        .onTapGesture {
                            selectedBook = post.book
                            showBook = true
                        }
                        .onLongPressGesture(minimumDuration: 1){
                            //selectedPost = post
                            showPostActions = true
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal, 4)

                
            }
            //.foregroundColor(.black)
            .padding()
            //.padding(.vertical)
            //.background(backgroundColor)
            
            
            
            
            
        }
        
        func timeSince(from date: Date) -> String {
            let calendar = Calendar.current
            let now = Date()
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
            
            if let year = components.year, year > 0 {
                return "\(year) y"
            } else if let month = components.month, month > 0 {
                return "\(month) mon"
            } else if let day = components.day, day > 0 {
                return "\(day) d"
            } else if let hour = components.hour, hour > 0 {
                return "\(hour) h"
            } else if let minute = components.minute, minute > 0 {
                return "\(minute) min"
            } else {
                return "Just now"
            }
        }
        
        
    
}

struct UserRecommends: View {
    
    @State var isLiked : Bool = false
    @State var post = Note()
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @Binding var showPostActions : Bool
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @EnvironmentObject var userData: UserData
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        HStack(alignment: .top){
                
                Button(action: { showBook = true }){
                    Image(post.book.cover)
                        .resizable()
                        .aspectRatio(contentMode: .fit) // Changed to .fill to ensure the image covers the area
                        .frame(height: UIScreen.main.bounds.height * 0.2 )

                    //.frame(height: iPadOrientation ? UIScreen.main.bounds.height * 0.1 : 80 )
                        .clipped() // This ensures the image is clipped to the frame bounds
                        .cornerRadius(5) // Apply corner radius directly to the image
                        .shadow(radius: 0.5)
                        .padding(.top)
                        .padding(.trailing)
                        //.padding(.trailing, 3)
                    
                
            }
        VStack {
            

            HStack {
                Button(action: {
                    showProfile = true
                    selectedProfile = post.user
                }){
                    ProfileThumbnail(image: post.user.photo, size: 30)
                    
                    Text("\(post.user.name)")
                        .font(.system(size: 15, weight: .medium))
                        .padding(.trailing, -1)
                    Text("recommends")
                        .font(.system(size: 15))
                        .padding(.trailing, -3)
                    Text(post.book.title)
                        .font(.system(size: 15, weight: .medium))
                        .underline(true, color: .black)
                    
                }
                Spacer()
                Text(timeSince(from: post.timestamp))
                    .padding(.vertical, 2)
                    .font(.system(size: 11))
                    .opacity(0.7)
                
                
                
            }
            .padding(.top)
            
            Button(action: {
                selectedBook = post.book
                showBook = true
                
                
            }){
                
                                            
                        VStack(alignment: .leading) {
                            let read = userData.user.read(book: post.book)
                           /* HStack {
                                Text("\(post.book.title)")
                                    .font(.system(size: 11.5))
                                    .underline(true, color: .black)
                                //.opacity(0.5)
                                    .padding(.bottom, 2)
                                    .padding(.top, 2)
                                Spacer()
                            }*/
                                
                          
                                    Text("SYNOPSIS")
                                        .font(.system(size: 12))
                                        .padding(.vertical, 2)
                                        .opacity(0.7)
                                        .padding(.top)
                                        .padding(.bottom, 3)
                                    
                             
                                
                                
                            Text(post.book.synopsis)
                                    .font(.system(size: 15))
                                    .lineLimit(7)
                                    .lineSpacing(4)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom)
                                  
                            
                                
                            
                            HStack {
                               
                                Spacer()
                                
                                Text("\(post.likes) likes")
                                    .font(.system(size: 13))
                                    .opacity(0.7)
                                    .padding(.trailing)
                                if post.comments.count > 0 {
                                    
                                    Text("\(post.comments.count) comments")
                                        .font(.system(size: 13))
                                        .opacity(0.7)
                                        .padding(.trailing)
                                }
                                
                                
                                if !isLiked {
                                    Button(action: {
                                        isLiked.toggle()
                                        post.likes += 1
                                        
                                    }){
                                        Image(systemName: "heart")
                                            .font(.system(size: 19))
                                            //.foregroundColor(.black)
                                    }
                                } else {
                                    Button(action: {
                                        isLiked.toggle()
                                        post.likes -= 1
                                        
                                    }){
                                        Image(systemName: "heart.fill")
                                            .font(.system(size: 19))
                                            .foregroundColor(.pink)
                                    }
                                }
                                
                            }
                            .offset(y: 5)
                            
                        }
                        .onTapGesture {
                            selectedBook = post.book
                            showBook = true
                        }
                        .onLongPressGesture(minimumDuration: 1){
                            //selectedPost = post
                            showPostActions = true
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal, 4)

                
            }
            //.foregroundColor(.black)
            .padding()
            //.padding(.vertical)
            //.background(backgroundColor)
            
            
            
            
            
        }
        
        func timeSince(from date: Date) -> String {
            let calendar = Calendar.current
            let now = Date()
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
            
            if let year = components.year, year > 0 {
                return "\(year) y"
            } else if let month = components.month, month > 0 {
                return "\(month) mon"
            } else if let day = components.day, day > 0 {
                return "\(day) d"
            } else if let hour = components.hour, hour > 0 {
                return "\(hour) h"
            } else if let minute = components.minute, minute > 0 {
                return "\(minute) min"
            } else {
                return "Just now"
            }
        }
        
        
    
}

struct UserSharedList: View {
    @State var isLiked : Bool = false
    @State var list = List()
    //@Binding var showBook : Bool
    //@Binding var selectedBook : Book
    @Binding var showList : Bool
    @Binding var selectedList : List
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @EnvironmentObject var userData: UserData
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var sphereUsers: SphereUsers
    
    var body: some View {
        VStack {
            if let user = sphereUsers.getUserById(userId: list.user){
                HStack {
                    Button(action: {
                        showProfile = true
                        selectedProfile = user
                    }){
                        ProfileThumbnail(image: user.photo, size: 30)
                        
                        Text("\(user.name)")
                            .font(.system(size: 15, weight: .medium))
                            .padding(.trailing, -1)
                        Text("created a list")
                            .font(.system(size: 15))
                            .padding(.trailing, -3)
                        
                    }
                    Spacer()
                }
                .padding(.leading)
            }
            
            ListPreview(list: list, showList: $showList, selectedList: $selectedList)
        }
        .padding(.vertical)
    }
}

struct UserRated: View {
    
    @State var isLiked : Bool = false
    @State var rating = Rating()
    @Binding var showBook : Bool
    @Binding var selectedBook : Book
    @Binding var showPostActions : Bool
    @Binding var showProfile: Bool
    @Binding var selectedProfile: User
    @EnvironmentObject var userData: UserData
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let iPadOrientation = horizontalSizeClass != .compact
        
        HStack(alignment: .top){
                
                Button(action: { showBook = true }){
                    Image(rating.book.cover)
                        .resizable()
                        .aspectRatio(contentMode: .fit) // Changed to .fill to ensure the image covers the area
                        .frame(height: UIScreen.main.bounds.height * 0.2 )

                    //.frame(height: iPadOrientation ? UIScreen.main.bounds.height * 0.1 : 80 )
                        .clipped() // This ensures the image is clipped to the frame bounds
                        .cornerRadius(5) // Apply corner radius directly to the image
                        .shadow(radius: 0.5)
                        .padding(.top)
                        .padding(.trailing)
                        //.padding(.trailing, 3)
                    
                
            }
        VStack {
            

            HStack {
                Button(action: {
                    showProfile = true
                    selectedProfile = rating.user
                }){
                    ProfileThumbnail(image: rating.user.photo, size: 30)
                    
                    Text("\(rating.user.name)")
                        .font(.system(size: 15, weight: .medium))
                        .padding(.trailing, -1)
                    Text("rated")
                        .font(.system(size: 15))
                        .padding(.trailing, -3)
                    Text(rating.book.title)
                        .font(.system(size: 15, weight: .medium))
                        .underline(true, color: .black)
                    
                }
                Spacer()
               // Text(timeSince(from: rating.timestamp))
                  //  .padding(.vertical, 2)
                  //  .font(.system(size: 11))
                  //  .opacity(0.7)
                
                
                
            }
            .padding(.top)
            
            Button(action: {
                selectedBook = rating.book
                showBook = true
                
                
            }){
                
                                            
                        VStack(alignment: .leading) {
                            let read = userData.user.read(book: rating.book)
                           /* HStack {
                                Text("\(post.book.title)")
                                    .font(.system(size: 11.5))
                                    .underline(true, color: .black)
                                //.opacity(0.5)
                                    .padding(.bottom, 2)
                                    .padding(.top, 2)
                                Spacer()
                            }*/
                                
                          
                                    Text("SYNOPSIS")
                                        .font(.system(size: 12))
                                        .padding(.vertical, 2)
                                        .opacity(0.7)
                                        .padding(.top)
                                        .padding(.bottom, 3)
                                    
                             
                                
                                
                            Text(rating.book.synopsis)
                                    .font(.system(size: 15))
                                    .lineLimit(7)
                                    .lineSpacing(4)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom)
                                  
                            
                                
                            
                            HStack {
                               
                                Spacer()
                                
                                Text("\(rating.likes) likes")
                                    .font(.system(size: 13))
                                    .opacity(0.7)
                                    .padding(.trailing)
                                
                                if rating.comments.count > 0 {
                                    
                                    Text("\(rating.comments.count) comments")
                                        .font(.system(size: 13))
                                        .opacity(0.7)
                                        .padding(.trailing)
                                }
                                
                                
                                if !isLiked {
                                    Button(action: {
                                        isLiked.toggle()
                                        rating.likes += 1
                                        
                                    }){
                                        Image(systemName: "heart")
                                            .font(.system(size: 19))
                                            //.foregroundColor(.black)
                                    }
                                } else {
                                    Button(action: {
                                        isLiked.toggle()
                                        rating.likes -= 1
                                        
                                    }){
                                        Image(systemName: "heart.fill")
                                            .font(.system(size: 19))
                                            .foregroundColor(.pink)
                                    }
                                }
                                
                            }
                            .offset(y: 5)
                            
                        }
                        .onTapGesture {
                            selectedBook = rating.book
                            showBook = true
                        }
                        .onLongPressGesture(minimumDuration: 1){
                            //selectedPost = post
                            showPostActions = true
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal, 4)

                
            }
            //.foregroundColor(.black)
            .padding()
            //.padding(.vertical)
            //.background(backgroundColor)
            
            
            
            
            
        }
        
        func timeSince(from date: Date) -> String {
            let calendar = Calendar.current
            let now = Date()
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
            
            if let year = components.year, year > 0 {
                return "\(year) y"
            } else if let month = components.month, month > 0 {
                return "\(month) mon"
            } else if let day = components.day, day > 0 {
                return "\(day) d"
            } else if let hour = components.hour, hour > 0 {
                return "\(hour) h"
            } else if let minute = components.minute, minute > 0 {
                return "\(minute) min"
            } else {
                return "Just now"
            }
        }
        
        
    
}
