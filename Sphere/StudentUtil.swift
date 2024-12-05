//
//  StudentUtil.swift
//  sphere
//
//  Created by Alana Greenaway on 7/6/24.
//

import Foundation


class School: Identifiable, Hashable, ObservableObject  {
    var id: UUID
    var name: String
    var email: String
    var courses: [UUID: Course]
    var teachers: [UUID: Teacher]
    var students: [UUID: Student]
    
    init(id: UUID = UUID(), name: String, email: String, courses: [UUID : Course] = [:], teachers: [UUID : Teacher] = [:], students: [UUID : Student] = [:]) {
        self.id = id
        self.name = name
        self.email = email
        self.courses = courses
        self.teachers = teachers
        self.students = students
    }
    
    func addStudent(student: Student){
        students[student.id] = student
    }
    
    func addTeacher(teacher: Teacher){
        teachers[teacher.id] = teacher
    }
    
    func addCourse(course: Course){
        courses[course.id] = course
    }
    
    static func ==(lhs: School, rhs: School) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    

}

class Course: Identifiable, Hashable, ObservableObject  {
    var id: UUID
    var name: String
    var admin: [UUID: Teacher]
    var students: [UUID: Student]
    var password: String
    var books: [UUID: Book]
    var assignments: [UUID: Assignment]
    
    init(id: UUID = UUID(), name: String, admin: [UUID: Teacher] = [:], students: [UUID: Student] = [:], password: String, books: [UUID: Book], assignments: [UUID: Assignment] = [:]) {
        self.id = id
        self.name = name
        self.admin = admin
        self.students = students
        self.password = password
        self.books = books
        self.assignments = assignments
    }
    
    static func ==(lhs: Course, rhs: Course) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func getName() -> String {
        return name
    }
    
    func addStudent(student: Student){
        students[student.id] = student
    }
    
    func addTeacher(teacher: Teacher){
        admin[teacher.id] = teacher
    }

    func addBook(book: Book){
        books[book.id] = book
    }
    
    func getAllAssignments() -> [Assignment]{
        return assignments.flatMap { $0.value }
    }
    
    
}
class Assignment: Identifiable, Hashable, ObservableObject  {
    var id: UUID
    var creationDate: Date
    var dueDate: Date
    var book: Book
    var questions: [Question]
    var pages: (Int, Int)
    
    init(id: UUID, creationDate: Date, dueDate: Date, book: Book, questions: [Question], pages: (Int, Int)) {
        self.id = id
        self.creationDate = creationDate
        self.dueDate = dueDate
        self.book = book
        self.questions = questions
        self.pages = pages
    }
    
    static func ==(lhs: Assignment, rhs: Assignment) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func getPageRangeString() -> String {
        return "page \(pages.0) -  \(pages.1)"
    }
    func getBook() -> Book {
        return self.book
    }
    
    func getQuestionCount() -> Int {
        return questions.count
    }
    
    func getNumQuestionsCompleted(userId: UUID) -> Int {
        var num = 0
        for q in questions {
            if q.checkCompleted(userId: userId){
                num += 1
            }
        }
        
        return num
    }
    
    func completed(userId: UUID) -> Bool {
        return getNumQuestionsCompleted(userId: userId) == questions.count
    }
    
    func getDueDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMMM d"
        return formatter.string(from: self.dueDate)
    }
    
    
}

class Question: Identifiable, Hashable, ObservableObject  {
    var id: UUID
    var question: String
    var responses: [UUID: String]
    
    init(id: UUID, question: String, responses: [UUID: String]) {
        self.id = id
        self.question = question
        self.responses = responses
    }
    
    static func ==(lhs: Question, rhs: Question) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    func checkCompleted(userId: UUID) -> Bool {
        return responses[userId] != nil
    }

    func submit(userId: UUID, response: String){
        responses[userId] = response
    }
    
    func getUserResponse(userId: UUID) -> String {
        return responses[userId] ?? ""
    }
}

class Response: Identifiable, Hashable, ObservableObject  {
    var id: UUID
    var questionid: UUID
    var response: String
    var grade: Float?
    
    init(id: UUID = UUID(), questionid: UUID, response: String, grade: Float? = nil) {
        self.id = id
        self.questionid = questionid
        self.response = response
        self.grade = grade
    }
    
    static func ==(lhs: Response, rhs: Response) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    func isGraded() -> Bool {
        return grade != nil
    }
    
}

class Teacher: User {
    var email: String
    var courses: [UUID: Course]
    
    init(email: String, courses: [UUID: Course]) {
        self.email = email
        self.courses = courses
    }
    
    
    func isAdmin(courseid: UUID) -> Bool{
        return courses[courseid] != nil
    }
}

class Student: User {
    @Published var grades: [UUID: Float]
    @Published var courses: [UUID: Course]
    @Published var email: String
    
    init(name: String, grades: [UUID : Float], courses: [UUID: Course], email: String) {
        self.grades = grades
        self.courses = courses
        self.email = email
        super.init(name: name)

    }
    
    func getAllCourses() -> [Course]{
        return courses.flatMap { $0.value }

    }
}
