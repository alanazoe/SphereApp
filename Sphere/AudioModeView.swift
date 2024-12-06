//
//  AudioModeView.swift
//  Sphere
//
//  Created by Alana Greenaway on 12/6/24.
//

import SwiftUI

struct AudioModeView: View {
    var book: Book
    @EnvironmentObject var lightModeController: LightModeController
    @State var barVisible = false

    var body: some View {
        VStack{
            VStack {
                
    
                
                ReadAlongView()
            }
            .onTapGesture {
                barVisible.toggle()
            }
            if barVisible {
                PlayPauseBar(book: book)
            }
        }
        .padding(.horizontal)
        
        .background(lightModeController.getBackgroundColor())
    }
}

struct ReadAlongView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 40) {
                ReadAlongText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .padding(.bottom, 20)
                ReadAlongText(text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", currentlyReading: true)
                    .padding(.bottom, 20)
                
                ReadAlongText(text: "Suspendisse potenti. Vivamus bibendum feugiat nunc, nec vehicula ligula congue eget. Curabitur vehicula tempor sem, in sagittis elit blandit id. Fusce eu metus nec lorem auctor interdum at sit amet libero.")
                    .padding(.bottom, 20)
                
                ReadAlongText(text: "Phasellus sit amet nibh in nulla pharetra aliquam. Etiam tincidunt velit in arcu scelerisque, a vehicula risus luctus. Integer nec urna et justo auctor convallis. Aenean consequat felis at lectus malesuada, in accumsan odio sagittis.")
            }
            .padding(.top, 40)
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)

    }
}

struct ReadAlongText: View {
    var text: String
    var size: CGFloat = 19
    var currentlyReading = false
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        Text(text)
            .font(.custom("Georgia", size: currentlyReading ? size : size - 1.0).weight(.regular))
            .scaleEffect(x: 1.0, y: 1.0)
            .lineSpacing(6)
            .foregroundColor(currentlyReading ? lightModeController.getForegroundColor() : lightModeController.getForegroundColor().opacity(0.5))
    }
}

struct PlayPauseBar: View {
    @State var book: Book
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                BookTitleText(text: book.title, size: 13.5)
                    .padding(.top, 6)
                BodyText(text: book.author.name, size: 13.5)
                
                ProgressBar()
                    .padding(.vertical, 7)
                    // .background(lightModeController.getButtonColor())
            }
            HStack(spacing: 30){
                Spacer()
                Image(systemName: "gobackward.15")
                    .font(.system(size: 28))
                
                PlayPauseButton()
                
                Image(systemName: "goforward.15")
                    .font(.system(size: 28))
                
                Spacer()
                
            }
        }
        .padding()
    }
}

struct PlayPauseButton: View {
    @State var playing = false
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        VStack {
            Button(action: {
                playing.toggle()
            }){
                if playing {
                    
                    Image(systemName: "pause.fill")
                } else {
                    Image(systemName: "play.fill")
                }
            }
        }
        .font(.system(size: 38))
        .foregroundColor(lightModeController.getButtonColor())

    }
}

