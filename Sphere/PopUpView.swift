//
//  PopUpView.swift
//  media discussion
//
//  Created by Alana Greenaway on 1/31/24.
//

import SwiftUI

struct PopUpView: View {
    @State var title: String

    var body: some View {
        VStack {
            Text("Media Title")
                .font(.headline)
                .padding()
            Divider()
            Button("Add to List") {
                //user.currentReads += book
            }
            .foregroundColor(.black)
            Divider()
            Button("Mark as Read") {
                // Add action for Mark as Read
            }
            .foregroundColor(.black)

            Divider()

            Button("Rate") {
                // Add action for Rate
            }
            .foregroundColor(.black)

            
        }
        .frame(width: 200, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct ProfilePopup: View {
    @Binding var isPresentingProfilePopup : Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @EnvironmentObject var userData : UserData
    @State var selectedList: List = List()
    @State var showList: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 50, height: 4)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .padding(.top)

                HStack(alignment: .center){
                    
                    ScrollView{
                        HStack{
                            Text("Lists")
                                .font(.system(size: 17, weight: .medium))
                                .padding()
                            
                            Spacer()
                        }
                        VStack {
                            
                            
                            ListGrid(showList: $showList, selectedList: $selectedList, lists: [userData.user.currentReads, userData.user.pastReads, userData.user.readingList] + userData.user.lists)
                            Spacer()
                        }
                        .background(backgroundColor)
                        
                   
                    }
                }
            }
            .background(backgroundColor)
        }
        .navigationBarHidden(true)
    }
}

/*

#Preview {
    let title = "Media Title"
    @State var isPresentingProfilePopup = false
    //return PopUpView(title: title)
    return ProfilePopup(isPresentingProfilePopup: $isPresentingProfilePopup)
}*/
