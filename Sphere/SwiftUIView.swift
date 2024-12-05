//
//  SwiftUIView.swift
//  sphere
//
//  Created by Alana Greenaway on 5/29/24.
//

import SwiftUI

struct FontListView: View {
    var body: some View {
        VStack {
            // Charter-Roman
            // Georgia HoeflerText-Regular
            // TimesNewRomanPSMT
            // Baskerville
            // Georgia-Italic
            ScrollView {
                ForEach(UIFont.familyNames, id: \.self) { familyName in
                    Section(header: Text(familyName)) {
                        ForEach(UIFont.fontNames(forFamilyName: familyName), id: \.self) { fontName in
                            Text(fontName).font(.custom(fontName, size: 14))
                        }
                    }
                }
            }
             
            
        }
    }
}

#Preview {
        FontListView()

}
