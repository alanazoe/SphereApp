//
//  MarkupView.swift
//  sphere
//
//  Created by Alana Greenaway on 6/20/24.
// marking up text

import SwiftUI
import SwiftUI
import PencilKit

import SwiftUI
import PencilKit

struct MarkupView: View {
    @Binding var isPresenting: Bool
    @Binding var canvasView: CustomCanvasView
    @State private var toolPicker = PKToolPicker()
    @State private var backgroundColor = UIColor(Color(.clear))

    var body: some View {
        if isPresenting {
            ZStack {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                CanvasView(canvasView: $canvasView, backgroundColor: backgroundColor)
                    .onAppear {
                        toolPicker.setVisible(true, forFirstResponder: canvasView)
                        toolPicker.addObserver(canvasView)
                        canvasView.becomeFirstResponder()
                    }
                    .onDisappear {
                        toolPicker.setVisible(false, forFirstResponder: canvasView)
                        toolPicker.removeObserver(canvasView)
                    }
            }
        }
    }
}

// warm gray #EFEBE0
struct MarkupToolbar: View {
    @Binding var editFormat: Bool
    @Binding var markPage: Bool
    @Binding var sharePage: Bool
    
    var body: some View {
        HStack(spacing: 30){
            Button(action: {
                editFormat.toggle()
            }){
                Image(systemName: "textformat")
                    .padding(8)
                    .background(
                        
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(editFormat ? Color(hex: "#EFEBE0") : Color(.clear))
                    )
            }
            Button(action: {
                markPage.toggle()
            }){
                Image(systemName: "pencil.and.scribble")
                    .padding(8)
                    .background(
                        
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(markPage ? Color(hex: "#EFEBE0") : Color(.clear))
                    )
            }
            // blue ink, red ink, black ink, purple ink
           
            /*Circle()
                .frame(width: 16, height: 16)
                .foregroundColor(.blue)
            HStack {
                Image(systemName: "arrow.uturn.backward")
                Image(systemName: "arrow.uturn.forward")
            }
             */
            Spacer()
           // ShareButton(sharePage: $sharePage)

                

            
        }
        .padding()
    }
}

/*
#Preview {
    MarkupView()
}
*/
