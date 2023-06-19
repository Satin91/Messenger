//
//  ChatScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 14.06.2023.
//

import SwiftUI

struct ChatScreen: View {
    enum KeyboardForeground: Hashable {
        case foreground
    }
    
    @EnvironmentObject var appCoordinator: AppCoordinatorViewModel
    @State var text = ""
    @State var messages: [String] = []
    @FocusState var isKeyboardForeground: KeyboardForeground?
    
    var user: UserModel
    var companion: MockChats.ChatUser
    
    var body: some View {
        content
            .onAppear {
                messages.append(contentsOf: companion.messages)
            }
            .dismissingKeyboard()
    }
    
    private var content: some View {
        VStack(spacing: .zero) {
            navigationBar
                .padding(Spacing.horizontalEdges)
            messagesContainer
            Divider()
            textFieldContainer
        }
        .fillBackgroundModifier(color: Colors.background)
    }
    
    private var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                VStack(alignment: .leading, spacing: Spacing.mediumPadding) {
                    Button("Back") {
                        appCoordinator.back()
                    }
                    HStack(spacing: Spacing.smallPadding) {
                        Image(companion.avatar)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 58, height: 58)
                        VStack(alignment: .leading, spacing: Spacing.extraSmallPadding) {
                            Text(companion.name)
                                .mediumTitleModifier()
                            Text("Last seen 1 hour ago")
                                .font(Fonts.roboto(weight: .light, size: 16))
                                .foregroundColor(Colors.neutral)
                        }
                    }
                }
            }
    }
    
    private var messagesContainer: some View {
        ScrollView(.vertical) {
            ForEach(messages, id: \.self) { message in
                messageView(text: message)
                    .padding(.vertical, 4)
            }.rotationEffect(.degrees(180))
                .padding(Spacing.horizontalEdges)
        }.rotationEffect(.degrees(180))
            .background(Colors.chatBackground)
    }
    
    private var textFieldContainer: some View {
        HStack(spacing: Spacing.smallPadding) {
            TextField("Enter text", text: $text)
                .font(Fonts.roboto(weight: .regular, size: 14))
                .focused($isKeyboardForeground, equals: .foreground)
                .padding()
                .background(Colors.light)
                .cornerRadius(Spacing.defaultRadius, antialiased: true)
            Button {
                withAnimation {
                    isKeyboardForeground = nil
                    guard !text.isEmpty else { return }
                    messages.append(text)
                    text = ""
                }
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 26))
                    .foregroundColor(text.isEmpty ? Colors.neutral : Colors.primary)
            }
            
        }
        .padding(.vertical, Spacing.smallPadding)
        .padding(.horizontal, Spacing.horizontalEdges)
        .background(Colors.chatBackground)
    }
    
    private func companionMessageView(text: String) -> some View {
        HStack {
            Text(text)
                .font(Fonts.roboto(weight: .regular, size: 14))
                .foregroundColor(Colors.dark)
                .padding()
                .background(Colors.light)
                .cornerRadius(Spacing.smallRadius)
                .largeShadowModifier()
            Spacer()
        }
    }
    
    private func userMessageView(text: String) -> some View {
        HStack {
            Spacer()
            Text(text)
                .font(Fonts.roboto(weight: .regular, size: 14))
                .foregroundColor(Colors.primary)
                .padding()
                .background(Colors.primarySecondary)
                .cornerRadius(Spacing.smallRadius)
        }
    }
    
    @ViewBuilder private func messageView(text: String) -> some View {
        if companion.messages.contains(text) {
            companionMessageView(text: text)
        } else {
            userMessageView(text: text)
        }
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen(user: UserModel(), companion: MockChats.ChatUser(name: "Vegtables", avatar: "chatAvatar2", messages: ["Hello!"]))
    }
}
