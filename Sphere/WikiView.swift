//
//  WikiView.swift
//  sphere
//
//  Created by Alana Greenaway on 6/6/24.
//

import SwiftUI

struct WikiView: View {
    var book: Book
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Sphere pages are collaborative Wiki sites. Spoilers may be ahead!")
                    .font(.headline)
                    .padding()
                    
                              
                Group {
                    Text("Synopois")
                        .font(.title2)
                        .padding(.bottom, 4)
                    Button("add synopsis"){
                        
                    }
                    Text("here users collaborate to write their own synopsis ")
                        .font(.body)
                }
                .padding()
                
                Group {
                    Text("Characters")
                        .font(.title2)
                        .padding(.bottom, 4)
                    
                    Button("add character"){
                        
                    }
                    Text("here users collaborate to add characters")
                }
                .padding()
                
                Group {
                    Text("Themes")
                        .font(.title2)
                        .padding(.bottom, 4)
                    
                    Button("add themes"){
                        
                    }
                }
                .padding()
                
                Group {
                    Text("Quotes")
                        .font(.title2)
                        .padding(.bottom, 4)
                    
                    Button("add quote"){
                        
                    }
                }
                .padding()
                
                Group {
                    Text("Discussion")
                        .font(.title2)
                        .padding(.bottom, 4)
                    
                //book.discussion
                }
                .padding()
            }
        }
        .navigationBarTitle(book.title, displayMode: .inline)
    }
}

