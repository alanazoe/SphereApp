//
//  CreateView.swift
//  sphere
//
//  Created by Alana Greenaway on 4/5/24.
//

import SwiftUI

struct CreateView: View {
    @Binding var create : Bool
    @State var isPresentingCreatePost = false
    @EnvironmentObject var userData: UserData
    @State var isPresentingSearch =  false
    @State var backgroundColor = Color(hex: "#FDFAEF")
    //@Binding var book : Book
    
    var body: some View {

            ZStack{
                Rectangle()
                    .ignoresSafeArea()
                    .opacity(0.2)
                    .onTapGesture {
                        create.toggle()
                    }
                if !isPresentingSearch {
                    VStack{
                        Spacer()
                        HStack {
                            Button(action: {
                                isPresentingSearch.toggle()
                            }){
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(height: 140)
                                    .foregroundColor(.white)
                                    .overlay(
                                        VStack{
                                            Image(systemName: "magnifyingglass")
                                                .font(.system(size: 25))
                                            Text("Add Book to Library")
                                                .font(.system(size: 13, weight:.medium))
                                                .padding(.top)
                                                .padding(.horizontal)
                                        }
                                            .foregroundColor(.black)
                                        
                                    )
                            }
                            
                            Button(action: {isPresentingCreatePost = true}){
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(height: 140)
                                    .foregroundColor(.white)
                                    .overlay(
                                        VStack{
                                            Image(systemName: "square.and.pencil")
                                                .font(.system(size: 25))
                                            Text("Write Discussion Post")
                                                .font(.system(size: 13, weight:.medium))
                                                .padding(.top)
                                        }
                                            .foregroundColor(.black)
                                        
                                    )
                            }
                            
                            
                            
                            Button(action: {}){
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(height: 140)
                                    .foregroundColor(.white)
                                    .overlay(
                                        VStack{
                                            Image(systemName: "star")
                                                .font(.system(size: 25))
                                            Text("Review Book")
                                                .font(.system(size: 13, weight:.medium))
                                                .padding(.top)
                                                .padding(.horizontal)
                                        }
                                            .foregroundColor(.black)
                                        
                                    )
                            }
                            
                            
                            Button(action: {}){
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(height: 140)
                                    .foregroundColor(.white)
                                    .overlay(
                                        VStack{
                                            Image(systemName: "qrcode")
                                                .font(.system(size: 25))
                                            Text("Scan Book for Details")
                                                .font(.system(size: 13, weight:.medium))
                                                .padding(.top)
                                                .padding(.horizontal)
                                        }
                                            .foregroundColor(.black)
                                        
                                    )
                            }
                            
                        }
                        .padding(.horizontal)
                        .background(backgroundColor)
                        .padding(.bottom, 40)
                        
                        // scans isbn and pulls up content page
                        
                    }
                    
                
                }
                
                if isPresentingSearch {
                    
                    //SearchView(searchMode: .all, isPresenting: $isPresentingSearch)
                }
                
                if isPresentingCreatePost {
                  //  CreatePost(isPresenting: $isPresentingCreatePost)

                }
                
            }
       
        
    }
}

/*
#Preview {
    
    CreateView()
}
*/
