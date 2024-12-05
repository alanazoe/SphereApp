//
//  MessageView.swift
//  sphere
//
//  Created by Alana Greenaway on 7/30/24.
//

import SwiftUI

class SphereUsers: ObservableObject {
    @Published var users: [UUID: User]
    
    init(users: [UUID : User] = [:]) {
        self.users = users
    }
    
    func getUserById(userId: UUID) -> User? {
        return users[userId]
    }
    func getUsersById(userIds: [UUID]) -> [User] {
        var theusers: [User] = []
        for userId in userIds {
            
            if let user = self.getUserById(userId: userId) {
                theusers.append(user)
            }
        }
        return theusers
    }
    
    func createUser(user: User){
        users[user.id] = user
    }
    
}

class Message: Identifiable, Hashable {
    var id: UUID
    var sender: UUID
    var recipients: [UUID]
    var msg: String
    var attachment: Attachment?
    var seen: Bool
    var timestamp: Date
    
    init(id: UUID = UUID(), sender: UUID, recipients: [UUID] = [], msg: String, attachment: Attachment? = nil, seen: Bool = false, timestamp: Date = Date()) {
        self.id = id
        self.sender = sender
        self.recipients = recipients
        self.msg = msg
        self.attachment = attachment
        self.seen = seen
        self.timestamp = timestamp
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
    
    func addRecipient(userId: UUID){
        recipients.append(userId)
    }
    
    func getTimestampString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM d"
        return formatter.string(from: self.timestamp)
    }
    
    func hasAttachment() -> Bool {
        return attachment != nil
    }
    
    func getAttachment() -> Attachment? {
        return attachment
    }
    
    func timeSinceString() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        // Calculate the difference in various components
        let components = calendar.dateComponents([.day, .hour, .minute], from: timestamp, to: now)
        
        if let days = components.day, days > 0 {
            // Calculate weeks and days
            let weeks = days / 7
            if weeks > 0 {
                return "\(weeks)w"
            } else {
                return "\(days)d"
            }
        }
        
        if let hours = components.hour, hours > 0 {
            return "\(hours)h"
        }
        
        if let minutes = components.minute, minutes > 0 {
            return "\(minutes)min"
        }
        
        return "Now"
    }
    
    func view(){
        seen = true
    }
    
    func wasSeen() -> Bool {
        return seen
    }


    
}

enum AttachmentType {
    case book
    case note
    case review
    case quote
}

class Attachment: Identifiable, Hashable {
    var id: UUID
    var link: String
    var type: AttachmentType
    var book: Book?
    var note: Note?
    var review: Review?
    var quote: Quote?
    
    init(id: UUID = UUID(), link: String = "", type: AttachmentType, book: Book? = nil, note: Note? = nil, review: Review? = nil, quote: Quote? = nil) {
        self.id = id
        self.link = link
        self.type = type
        self.book = book
        self.note = note
        self.review = review
        self.quote = quote
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Attachment, rhs: Attachment) -> Bool {
        lhs.id == rhs.id
    }
    
    func getAttachmentType() -> AttachmentType {
        return type
    }
    
    func getBook() -> Book? {
        return book
    }
    
    func getNote() -> Note? {
        return note
    }
    
    func getReview() -> Review? {
        return review
    }
    
    func getQuote() -> Quote? {
        return quote
    }
    
}

class Conversation: Identifiable, Hashable {
    var id: UUID
    var participants: [UUID]
    var messages: [UUID: Message]
    var recent: Message
    var order: [UUID]
    
    init(id: UUID = UUID(), participants: [UUID] = [], messages: [UUID: Message] = [:], recent: Message = Message(sender: UUID(), msg: ""), order: [UUID] = []) {
        self.id = id
        self.participants = participants
        self.messages = messages
        self.recent = recent
        self.order = order
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Conversation, rhs: Conversation) -> Bool {
        lhs.id == rhs.id
    }
    
    func getAllMessages() -> [Message]{
        var allMessages: [Message] = []
        
        for mid in order {
            if let msg = messages[mid]{
                allMessages.append(msg)
            } else {
                //remove id
            }
        }
        return allMessages
    }
    
    func viewMessages(){
        for message in messages {
            message.value.view()
        }
        
        recent.view()
    }
    
    func addUser(userId: UUID) {
        participants.append(userId)
    }
    
    func getAllUsers() -> [UUID] {
        return participants
    }
    
    func addMessage(msg: Message){
        messages[msg.id] = msg
        order.append(msg.id)
        recent = msg

    }
    
}

struct ConvosView: View {
    @EnvironmentObject var userData: UserData
    @State var searchText = ""
    @State  var searched = false
    @State var isTextFieldFocused = false
    @State var xoffset = 0.0
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @State var showConvo = false
    @State var selectedConvo = Conversation()
    @State var showSearch = true
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                /*
                HStack(){
                    Spacer()
                    
                   
                    .padding(.trailing)
                    Button(action: {
                        // new message
                    }){
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                    }
                }*/
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        if showSearch {
                            HStack(){
                                
                                TextField("Search messages", text: $searchText)
                                    .onTapGesture {
                                        // When the TextField is tapped, set isTextFieldFocused to true
                                        isTextFieldFocused = true
                                    }
                                    .font(.system(size: 16.5))
                                    .foregroundColor(.black)
                                    .padding(10)
                                //.padding(.vertical, 2)
                                    .padding(.leading, 30)
                                    .onSubmit {
                                        searched = true
                                        isTextFieldFocused = false
                                    }
                                    .onChange(of: searchText){
                                        searched = false
                                        
                                    }
                                    .overlay(
                                        HStack {
                                            Image(systemName: "magnifyingglass")
                                                .foregroundColor(.black)
                                                .padding(.leading, 10)
                                            Spacer()
                                        }
                                    )
                                    .background(Color(.black).opacity(0.05))
                                    .cornerRadius(10)
                                
                                
                                
                                
                                if searchText != "" || isTextFieldFocused {
                                    Button("Cancel") {
                                        // Close keyboard
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        // Empty search text
                                        searchText = ""
                                        isTextFieldFocused = false
                                        
                                    }
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                                    .padding(.trailing)
                                }
                                Button(action: {
                                    // new message
                                }){
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 22))
                                        .foregroundColor(.black)
                                        .padding()
                                }
                            }
                            .padding(.bottom)
                        }
                    Text("Messages")
                        .font(.system(size: 18, weight: .medium))
                    
                    ForEach(userData.user.getAllConversations()){ convo in
                        Button(action: {
                            showConvo = true
                            selectedConvo = convo
                        }){
                            ConvoPreview(convo: convo)
                        }
                        
                    }
                }
                }
                
                Spacer()
                
            }
            .padding()



            if showConvo {
                ConversationView(convo: selectedConvo, isPresenting: $showConvo)
            }
        }
        .padding()
        .background(backgroundColor)
    }
}


struct ConversationView: View {
    @State var convo: Conversation
    @EnvironmentObject var sphereUsers: SphereUsers
    @State var newMessage: String = ""
    @EnvironmentObject var userData: UserData
    @State var backgroundColor = Color(hex: "#FDFAEF")
    @Binding var isPresenting: Bool
    @State var showBook = false
    @State var selectedBook = Book()
    
    var body: some View {
        let recip = sphereUsers.getUsersById(userIds: convo.recent.recipients)
        
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        isPresenting.toggle()
                    }){
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    ForEach(recip){ user in
                        Text(user.name)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                ScrollViewReader { scrollView in
                    ScrollView {
                        VStack {
                            ForEach(convo.getAllMessages()){ msg in
                                if msg.hasAttachment() {
                                    Button(action: {
                                        if let attach = msg.getAttachment(), let book = attach.getBook() {
                                            showBook = true
                                            selectedBook = book
                                        }
                                    }) {
                                        MessageView(msg: msg)
                                    }
                                } else {
                                    MessageView(msg: msg)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .onChange(of: convo.getAllMessages().count) { _ in
                            scrollView.scrollTo(convo.getAllMessages().last?.id, anchor: .bottom)
                        }
                    }
                }
                
                HStack {
                    TextField("Say something...", text: $newMessage)
                        .font(.system(size: 16.5))
                        .padding(10)
                        .background(Color(.black).opacity(0.05))
                        .cornerRadius(10)
                        .onSubmit {
                            sendMessage(convo: convo, msg: newMessage)
                            newMessage = ""
                        }
                    
                    Button(action: {
                        if !newMessage.isEmpty {
                            sendMessage(convo: convo, msg: newMessage)
                            newMessage = ""
                        }
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(backgroundColor)
            .onAppear {
                convo.viewMessages()
            }
            
            if showBook {
                ContentView(book: $selectedBook, isPresenting: $showBook, showToolbar: .constant(true))
            }
        }
    }
    
    func sendMessage(convo: Conversation, msg: String) {
        guard !msg.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newMessage = Message(sender: userData.user.id, msg: msg)
        convo.addMessage(msg: newMessage)
    }
}

struct MessageView: View {
    @State var msg: Message
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var sphereUsers: SphereUsers

    var body: some View {
        
        HStack(alignment: .bottom){
            
            if msg.sender != userData.user.id {
                if let user = sphereUsers.getUserById(userId: msg.sender){
                    ProfileThumbnail(image: user.photo, size: 30)
                }
            } else {
                Spacer()
            }
            if msg.hasAttachment() {
                if let attach = msg.getAttachment(){
                    AttachmentView(msg: msg, attach: attach)
                }
            } else {
                Text(msg.msg)
                    .font(.system(size: 15.5))
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(msg.sender == userData.user.id ? Color(.blue).opacity(0.4) : Color(.gray).opacity(0.15))
                        
                    )
                // .frame(maxWidth: UIScreen.main.bounds.width/2)
                // .frame(alignment: .leading)
                
            }
            if msg.sender != userData.user.id{
                Spacer()
            }
        }
        
    }
}

struct ConvoPreview: View {
    @State var convo: Conversation
    @EnvironmentObject var sphereUsers: SphereUsers
    @EnvironmentObject var userData: UserData

    var body: some View {
        if let user = sphereUsers.getUserById(userId: convo.recent.sender) {
            ZStack{
                HStack(alignment: .center){
                    
                    if userData.user.id != convo.participants[0] {
                        if let partic = sphereUsers.getUserById(userId: convo.participants[0]) {
                            ProfileThumbnail(image: partic.photo, size: 65)
                        }
                    } else{
                        if let partic = sphereUsers.getUserById(userId: convo.participants[1]) {
                            ProfileThumbnail(image: partic.photo, size: 65)
                        }
                    }
                    VStack(alignment: .leading){
                        HStack {
                            ForEach(convo.participants, id: \.self) { pid in
                                if userData.user.id != pid {
                                    if let partic = sphereUsers.getUserById(userId: pid) {
                                        Text(partic.name)
                                            .font(.system(size: 16.5))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                        
                        
                        Text(convo.recent.msg)
                            .font(.system(size: 15.5, weight: convo.recent.sender != userData.user.id && !convo.recent.wasSeen() ? .medium : .regular))
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .padding(.top, 1)
                        
                        
                    }
                    .padding(.leading, 2)
                    Spacer()
                    
                    
                    Text(convo.recent.timeSinceString())
                        .font(.system(size: 12.5))
                        .foregroundStyle(Color(.gray).opacity(0.9))
                    
                    
                }
                .padding(.vertical)
                
                HStack {
                    if convo.recent.sender != userData.user.id {
                        
                        if !convo.recent.wasSeen() {
                            Circle()
                                .frame(width: 8)
                                .foregroundColor(.blue)
                        }
                    }
                    Spacer()
                }
            }
    }
    }
}

struct AttachmentView: View {
    var msg: Message
    var attach: Attachment
    @EnvironmentObject var userData: UserData

    var body: some View {
        
        VStack {
            if msg.sender == userData.user.id {
                
                HStack {
                    Spacer()
                    if attach.getAttachmentType() == .book {
                        if let book = attach.getBook() {
                            Image(book.cover)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(4)
                                /*.background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color(.blue).opacity(0.1))
                                )*/
                        }
                        
                    }
                }
            } else {
                HStack {
                    if attach.getAttachmentType() == .book {
                        if let book = attach.getBook() {
                            Image(book.cover)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 2))
                                .padding(4)
                                .cornerRadius(10)
                                /*.background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color(.gray).opacity(0.8))
                                )*/
                        }
                        
                    }
                    Spacer()

                }
            }
        }
    }
}

