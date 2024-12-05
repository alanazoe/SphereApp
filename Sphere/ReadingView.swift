//
//  ReadingView.swift
//  sphere
//
//  Created by Alana Greenaway on 5/5/24.
//

import Foundation
import SwiftUI

struct ReadingView: View {
    @State var media: Book = Book()
    @EnvironmentObject var userData: UserData
    @State var create = false
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var foregroundColor = Color(hex: "#000000")
    @State var showEReader : Bool = false

    var body: some View {
        
        NavigationView{
            ZStack{
                
                EReaderView(media: $userData.user.currentReads.books[0], currentPageIndex: media.currentPage ?? 0, showEReader: $showEReader)
                
            }
            .background(backgroundColor)


        }
        .background(backgroundColor)

        .navigationBarHidden(true)
    }
}
