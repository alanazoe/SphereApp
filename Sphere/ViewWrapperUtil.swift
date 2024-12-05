//
//  ViewWrapperUtil.swift
//  Sphere
//
//  Created by Alana Greenaway on 11/27/24.
//

import SwiftUI

struct AnimateView<Content: View>: View {
    let content: Content
    @State private var contentOffset: CGFloat = UIScreen.main.bounds.width
    @State private var showingView = false
    @Binding var showView: Bool
    @EnvironmentObject var navigation: Nav

    init(showView: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._showView = showView
        self.content = content()
    }

    var body: some View {
        ZStack {
            if showingView {
                content
                    .offset(x: contentOffset)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            contentOffset = 0
                        }
                    }
                    .onDisappear {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            contentOffset = UIScreen.main.bounds.width
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.width > 0 {
                                    self.contentOffset = gesture.translation.width
                                }
                            }
                            .onEnded { _ in
                                if self.contentOffset > UIScreen.main.bounds.width / 2.2 {
                                    self.contentOffset = UIScreen.main.bounds.width
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                        showView = false
                                    }
                                } else {
                                    self.contentOffset = 0
                                }
                            }
                    )
                    .animation(.easeOut, value: contentOffset)
            }
        }
        .onChange(of: showView) { newValue in
            handleViewToggle(newValue)
        }
    }

    private func handleViewToggle(_ newValue: Bool) {
        if newValue {
            showingView = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                navigation.hideToolbar()
            }
        } else {
            withAnimation(.easeInOut(duration: 0.15)) {
                contentOffset = UIScreen.main.bounds.width
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                showingView = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                navigation.showToolbarTrue()
            }
        }
    }
}
