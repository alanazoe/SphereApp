//
//  StudentDashboard.swift
//  sphere
//
//  Created by Alana Greenaway on 7/6/24.
//

import SwiftUI

struct StudentDashboard: View {
    @EnvironmentObject var student: Student
    @Binding var showToolbar: Bool
    @State var backgroundColor = Color(hex: "#FDFAEF")
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
            VStack(alignment: .leading) {
                ZStack {
                    HStack {
                        Text("Sphere Student")
                        
                            .padding()
                            .font(.system(size: 20, weight: .medium))
                            .opacity(1) // Fade out when showSearchBar is true
                        Spacer()
                        
                      
                        
                    }
                    .padding(.horizontal, 5)
                    HStack {
                       
                        Spacer()
                        
                        Circle()
                            .frame(width: 60)
                            .foregroundColor(.pink)
                            .padding()
                        
                        
                    }
                    .padding(.horizontal, 5)
                }
                let courses = student.getAllCourses()
                ScrollView() {
                    VStack(alignment: .leading) {
                        
                            HStack {
                                Text("Readings")
                                    .font(.system(size: 17, weight: .medium))
                                    .padding(.vertical)
                                Spacer()
                            }
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(courses) { course in
                                ForEach(course.getAllAssignments()) { assignment in
                                    VStack(alignment: .leading, spacing: 10) {
                                        Image(assignment.getBook().cover)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 180)
                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                            .padding(.bottom)
                                        
                                        Text(" \(assignment.getDueDateString())")
                                            .font(.system(size: 14, weight: .medium))
                                            .padding(.bottom, 3)
                                        
                                       
                                        Text(course.getName())
                                            .font(.system(size: 14, weight: .medium))
                                        
                                        Text(assignment.getBook().title)
                                            .font(.system(size: 16, weight: .medium))
                                        
                                        HStack {
                                            Text(assignment.getPageRangeString())
                                                .padding(.trailing)
                                                .foregroundColor(.blue)
                                            
                                            Text("\(assignment.getQuestionCount()) questions")
                                        }
                                        .font(.system(size: 14))
                                        .padding(.vertical)
                                        
                                        Button(action: {
                                            // navigation.chooseBook(book: book)
                                            // navigation.goToReader()
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(height: 38)
                                                .foregroundColor(.black)
                                                .overlay(
                                                    Text("Read")
                                                        .font(.system(size: 15, weight: .medium))
                                                        .foregroundColor(.white)
                                                )
                                        }
                                    }
                                    .padding()
                                   // .background(Color(Color(hex: "#291F00").opacity(0.05)))
                                    //.cornerRadius(10)
                                    .padding(.horizontal)
                                    
                                }
                            }
                        }
                        .padding()
                    }
                    .padding()
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    .padding(.top, 40)

            }
                

        }
        .background(backgroundColor)
    }
}



struct AdminDashboard: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}
