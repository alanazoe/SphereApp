//
//  ReactionLibraryView.swift
//  sphere
//
//  Created by Alana Greenaway on 9/18/24.
//

import SwiftUI

struct ReactionLibraryView: View {
    // Assuming that the image names are fetched or known
    let images = ["r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10"]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
        
    ]
    @Binding var isPresenting: Bool
    @Binding var selectedImage: String?
    @EnvironmentObject var lightModeController: LightModeController

    
    var body: some View {
        
        VStack {
            HStack {
                Text("Add reaction meme")
                    .font(.system(size: 17, weight: .medium))
                    .padding(.trailing, -4)
                
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 11))
                    .opacity(0.7)
                    .onTapGesture {
                        isPresenting.toggle()
                    }
                Spacer()
            }
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                        //.frame(width: 100, height: 100) // You can adjust the size as needed
                            .clipShape(RoundedRectangle(cornerRadius: 5)) // Optional styling
                            .onTapGesture {
                                selectedImage = imageName
                            }
                    }
                }
            }
            .scrollIndicators(.hidden )
        }
        .padding()
        .background(lightModeController.getBackgroundColor())
    }
}

