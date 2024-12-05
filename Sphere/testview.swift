//
//  testview.swift
//  sphere
//
//  Created by Alana Greenaway on 5/26/24.
//

import SwiftUI

struct TestView: View {
    
    var names: [String] = []
    
    var body: some View {
        ScrollView{
            VStack {
                Text("Hello, World!")
                
                ForEach(Array(names.enumerated()), id: \.offset) { index, name in
                    Text(name)
                        .font(.custom(name, size: 20))
                        .padding()
                }
            }
        }
    }
    
    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                names.append(fontName)
                    
            }
        }
    }
}

#Preview {
    TestView()
}
