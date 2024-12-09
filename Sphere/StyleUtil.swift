//
//  StyleUtil.swift
//  Sphere
//
//  Created by Alana Greenaway on 12/5/24.
//

import SwiftUI

struct BookTitleText: View {
    var text: String
    var size: CGFloat = 20
    @EnvironmentObject var lightModeController: LightModeController
    var foregroundColor: Color? = nil
    var body: some View {
        Text(text)
            .font(.custom("Baskerville", size: size).weight(.medium))
            .scaleEffect(x: 1.0, y: 1.15)
            .foregroundColor(foregroundColor != nil ? foregroundColor : lightModeController.getForegroundColor())
    }
}


struct BodyText: View {
    var text: String
    var size: CGFloat
    var weight = 0.05
    @EnvironmentObject var lightModeController: LightModeController

    var body: some View {
        Text(text)
            .font(Font(UIFont.systemFont(ofSize: size, weight: UIFont.Weight(weight))))
            .foregroundColor(lightModeController.getForegroundColor())


    }
    
}
