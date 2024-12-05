//
//  GenreView.swift
//  sphere
//
//  Created by Alana Greenaway on 3/10/24.
//

import SwiftUI

struct GenreView: View {
    @State var backgroundColor = Color(hex: "#FDFAEF")

    var book : Book
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                
                VStack(alignment: .leading){
                    
                    HStack(){
                        
                        Text(book.genre.rawValue)
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                        
                    }
                    Text("Top in \(book.genre.rawValue)")
                    Text("\(book.genre.rawValue) Suggested For You")
                    
                }
                .background(backgroundColor)
                .padding(.horizontal)
                .padding(.top, 80)
                .frame(width: UIScreen.main.bounds.width)
            }
            .overlay(
                VStack {
                    HStack() {
                        
                        Image(systemName: "arrow.left")
                            .font(.system(size: 16, weight: .medium))
                        Spacer()
                       
                        
                   
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    //.background(Color(hex: "#F1EEE9"))
                   // .shadow(radius: 15)
                    Spacer()
                    
                }
                .padding(.vertical)
            )

        }
        .navigationBarHidden(true)
    }
}
