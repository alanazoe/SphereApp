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
    @State var currentPosition: Double = 2

    var body: some View {
        VStack{
            VStack {
                
    
                
                ReadAlongView(currentPosition: $currentPosition)
            }
            .onTapGesture {
                barVisible.toggle()
            }
            if barVisible {
                PlayPauseBar(book: book, currentPosition: $currentPosition)
                    .transition(.move(edge: .bottom)) // Sliding effect
                    .animation(.easeInOut, value: barVisible)
            }
        }
        .padding(.horizontal)
        
        .background(lightModeController.getBackgroundColor())
    }
}



struct ReadAlongView: View {
    
    @State var textArray: [String] = []
    @Binding var currentPosition: Double

    @State var audioTextArray: [AudioText] = [
        AudioText(lowerBound: 1, upperBound: 3, text: "We talked for a few minutes on the sunny porch."),
        AudioText(lowerBound: 3.1, upperBound: 5, text: "\"I've got a nice place here,\" he said, his eyes flashing about restlessly."),
        AudioText(lowerBound: 5.1, upperBound: 7, text: "Turning me around by one arm he moved a broad flat hand along the front vista, including in its sweep a sunken Italian garden, a half acre of deep pungent roses and a snub-nosed motor boat that bumped the tide off shore."),
        AudioText(lowerBound: 7.1, upperBound: 9, text: "\"It belonged to Demaine the oil man.\" He turned me around again, politely and abruptly. \"We'll go inside.\""),
        AudioText(lowerBound: 9.1, upperBound: 11, text: "We walked through a high hallway into a bright rosy-colored space, fragilely bound into the house by French windows at either end. The windows were ajar and gleaming white against the fresh grass outside that seemed to grow a little way into the house. A breeze blew through the room, blew curtains in at one end and out the other like pale flags, twisting them up toward the frosted wedding cake of the ceiling--and then rippled over the wine-colored rug, making a shadow on it as wind does on the sea."),
        AudioText(lowerBound: 11.1, upperBound: 13, text: "The only completely stationary object in the room was an enormous couch on which two young women were buoyed up as though upon an anchored balloon. They were both in white and their dresses were rippling and fluttering as if they had just been blown back in after a short flight around the house. I must have stood for a few moments listening to the whip and snap of the curtains and the groan of a picture on the wall. Then there was a boom as Tom Buchanan shut the rear windows and the caught wind died out about the room and the curtains and the rugs and the two young women ballooned slowly to the floor."),
        AudioText(lowerBound: 13.1, upperBound: 15, text: "The younger of the two was a stranger to me. She was extended full length at her end of the divan, completely motionless and with her chin raised a little as if she were balancing something on it which was quite likely to fall. If she saw me out of the corner of her eyes she gave no hint of it--indeed, I was almost surprised into murmuring an apology for having disturbed her by coming in."),
        AudioText(lowerBound: 15.1, upperBound: 17, text: "The other girl, Daisy, made an attempt to rise--she leaned slightly forward with a conscientious expression--then she laughed, an absurd, charming little laugh, and I laughed too and came forward into the room.")
    ]
    /*[
        AudioText(lowerBound: 1, upperBound: 3, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        AudioText(lowerBound: 3.1, upperBound: 5, text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        AudioText(lowerBound: 5.1, upperBound: 7, text: "Suspendisse potenti. Vivamus bibendum feugiat nunc, nec vehicula ligula congue eget. Curabitur vehicula tempor sem, in sagittis elit blandit id. Fusce eu metus nec lorem auctor interdum at sit amet libero."),
        AudioText(lowerBound: 7.1, upperBound: 9, text: "Phasellus sit amet nibh in nulla pharetra aliquam. Etiam tincidunt velit in arcu scelerisque, a vehicula risus luctus. Integer nec urna et justo auctor convallis. Aenean consequat felis at lectus malesuada, in accumsan odio sagittis."),
        AudioText(lowerBound: 9.1, upperBound: 11, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        AudioText(lowerBound: 11.1, upperBound: 13, text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        AudioText(lowerBound: 13.1, upperBound: 15, text: "Suspendisse potenti. Vivamus bibendum feugiat nunc, nec vehicula ligula congue eget. Curabitur vehicula tempor sem, in sagittis elit blandit id. Fusce eu metus nec lorem auctor interdum at sit amet libero."),
        AudioText(lowerBound: 15.1, upperBound: 17, text: "Phasellus sit amet nibh in nulla pharetra aliquam. Etiam tincidunt velit in arcu scelerisque, a vehicula risus luctus. Integer nec urna et justo auctor convallis. Aenean consequat felis at lectus malesuada, in accumsan odio sagittis.")
    ]*/
    



    @State var selectedIndex = 0
    
    var body: some View {
        ScrollViewReader { proxy in
            
            ScrollView {
                VStack(alignment: .leading, spacing: 60) {
                    ForEach(Array(audioTextArray.enumerated()), id: \.element) { index, audioTextObject in
                        ReadAlongText(
                            text: audioTextObject.text,
                            audioTextObject: audioTextObject,
                            currentPosition: $currentPosition
                        )
                        .id(index)
                        
                        
                    }
                }
                .padding(.top, 40)
                .padding(.horizontal)
                .onChange(of: currentPosition){
                    selectedIndex = getSelectedIndex()
                    withAnimation {
                        proxy.scrollTo(selectedIndex, anchor: .center)
                    }
                }
            }
            .scrollIndicators(.hidden)

        }

    }
    

    private func getSelectedIndex() -> Int {
        for (index, audioTextObject) in audioTextArray.enumerated() {
            if audioTextObject.isCurrentlyReading(currentSecond: currentPosition) {
                return index
            }
        }
        return 0
    }

}
class AudioText: Identifiable, Hashable {
    
    var id: UUID
    var lowerBound: Double
    var upperBound: Double
    var text: String
    
    init(lowerBound: Double, upperBound: Double, text: String) {
        self.id = UUID()
        self.lowerBound = lowerBound
        self.upperBound = upperBound
        self.text = text
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: AudioText, rhs: AudioText) -> Bool {
        lhs.id == rhs.id
    }
    
    /// Determines if the current second is within the bounds of this AudioText
    func isCurrentlyReading(currentSecond: Double) -> Bool {
        return currentSecond >= lowerBound && currentSecond <= upperBound
    }
    
    func getStartSecond() -> Double {
        return lowerBound
    }
}

// returns paragraph index that is selected
/*
 textMap is an integer (second) mapped to a paragraph index
 */
func getCurrentParagraph(second: Int, textMap: [Int: Int]) -> Int? {
    
    return textMap[second]
    
}
struct ReadAlongText: View {
    var text: String
    var size: CGFloat = 19
    @State var audioTextObject: AudioText
    @Binding var currentPosition: Double
    @EnvironmentObject var lightModeController: LightModeController
    @State var currentlyReading = false

    var body: some View {
        HStack {
            Text(text)
                .font(.custom("Georgia", size: size).weight(.regular))
                .scaleEffect(x: 1.0, y: 1.0)
                .lineSpacing(6)
                .foregroundColor(currentlyReading ? lightModeController.getForegroundColor() : lightModeController.getForegroundColor().opacity(0.5))
                .onAppear {
                    currentlyReading = audioTextObject.isCurrentlyReading(currentSecond: currentPosition)
                }
                .onChange(of: currentPosition){ val in
                    currentlyReading = audioTextObject.isCurrentlyReading(currentSecond: currentPosition)
                }
        }
        .scaleEffect(x: !currentlyReading ? 0.92 : 1.0, y: !currentlyReading ? 0.92 : 1.0)
        .offset(x: !currentlyReading ? -14 : 0)
        .animation(
            .easeInOut(duration: 0.3), // Customize duration here
            value: currentlyReading
        )
        .onTapGesture {
            currentPosition = audioTextObject.getStartSecond()
        }
    }
}

struct PlayPauseBar: View {
    @State var book: Book
    @EnvironmentObject var lightModeController: LightModeController
    @Binding var currentPosition: Double
    @State var totalSeconds: Double = 17
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                
                VStack(alignment: .leading) {
                    BookTitleText(text: book.title, size: 13.5)
                    BodyText(text: book.author.name, size: 13.5)
                    AudioProgressBar(currentSecond: $currentPosition, totalSeconds: $totalSeconds)
                        .padding(.vertical, 7)
                    
                    // .background(lightModeController.getButtonColor())
                    
                }
                HStack(spacing: 30){
                    Spacer()
                    Button(action: {
                        currentPosition = max(currentPosition - 15, 0)

                    }){
                        Image(systemName: "gobackward.15")
                            .font(.system(size: 28))
                    }
                    PlayPauseButton(currentSecond: $currentPosition, totalSeconds: totalSeconds)
                    Button(action: {
                        currentPosition = min(currentPosition + 15, totalSeconds)

                    }){
                        Image(systemName: "goforward.15")
                            .font(.system(size: 28))
                    }
                    
                    Spacer()
                    
                }
                .foregroundColor(lightModeController.getForegroundColor())

            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newSecond = calculateScrubPosition(geometry: geometry, dragLocationX: value.location.x)
                        currentPosition = newSecond
                    }
            )
        }
        .frame(height: 110)
            .padding()
            .foregroundColor(lightModeController.getForegroundColor())
        
        

    }
    private func calculateScrubPosition(geometry: GeometryProxy, dragLocationX: CGFloat) -> Double {
        // Normalize drag location to a 0-1 scale relative to the progress bar width
        let normalizedPosition = min(max(dragLocationX / geometry.size.width, 0), 1)
        
        // Map normalized position to the total seconds
        return normalizedPosition * totalSeconds
    }
}

struct PlayPauseButton: View {
    @EnvironmentObject var playPauseController: PlayPauseController
    @Binding var currentSecond: Double
    @EnvironmentObject var lightModeController: LightModeController
    var totalSeconds: Double
    @State var timer: Timer? = nil
    var body: some View {
        VStack {
            Button(action: {
                playPauseController.toggle()
                if playPauseController.isPlaying() {
                    startTimer()
                } else {
                    stopTimer()
                }
            }) {
                Image(systemName: playPauseController.isPlaying() ? "pause.fill" : "play.fill")
            }
        }
        .font(.system(size: 38))
        .foregroundColor(lightModeController.getButtonColor())
        
    }

    private func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
            if currentSecond < totalSeconds {
                currentSecond += 0.001
            }
        }
        playPauseController.setTimer(timer: timer)
    }

    private func stopTimer() {
        timer = playPauseController.getTimer()
        timer?.invalidate()
        timer = nil
    }
}
