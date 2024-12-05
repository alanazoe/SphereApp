//
//  DynamicDisplayUtil.swift
//  Sphere
//
//  Created by Alana Greenaway on 11/16/24.
//

import Foundation
import SwiftUI


func calculateWidth(refWidth: CGFloat) -> CGFloat {
    var screenWidth = UIScreen.main.bounds.width
    var proportion = refWidth / 834
    return proportion * screenWidth
    
}

func calculateHeight(refHeight: CGFloat) -> CGFloat {
    var screenHeight = UIScreen.main.bounds.height
    var proportion = refHeight / 1194
    return  proportion * screenHeight
    
}


struct ScreenView: View {
    var body: some View {
        VStack {
            Text("\(UIScreen.main.bounds.width)")
        }
    }
}
