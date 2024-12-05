//
//  NotificationViews.swift
//  Sphere
//
//  Created by Alana Greenaway on 12/3/24.
//

import SwiftUI
import UIKit

struct NotificationPopup: View {
    @EnvironmentObject var notificationCoordinator: NotificationCoordinator

    var image: Image
    var message: AnyView
    @State var scale = 0.8
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {

            HStack {
               
           
                
                    


                message

                
                Spacer()
                Button(action: {
                    notificationCoordinator.changeButtonTriggered.toggle()
                }){
                    Text("Change")
                        .font(Font(UIFont.systemFont(ofSize: 15.5, weight:.medium)))
                        .foregroundColor(.blue)

                }
                
            }
           
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.vertical, 16)
            .background(VisualEffectBlur(blurStyle: .systemChromeMaterialDark).edgesIgnoringSafeArea(.all))

            .cornerRadius(10)
            .shadow(radius: 4)
            .padding(.bottom, 50)
            .scaleEffect(scale)
            .onAppear {
                triggerHapticFeedback()
                withAnimation(.easeInOut(duration: 0.1)) {
                    scale = 1
                }
            }
     
        .padding()
        
    }
}

func triggerHapticFeedback() {
    let generator = UIImpactFeedbackGenerator(style: .light) // You can use .medium or .heavy for different intensities
    generator.prepare()
    generator.impactOccurred()
}
