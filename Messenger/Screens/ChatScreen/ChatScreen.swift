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
    
    @EnvironmentObject var router: AppCoordinatorViewModel
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
        VStack {
            navigationBar
                .padding(.horizontal, Spacing.horizontalEdges)
            messagesContainer
            textField
                .padding(.horizontal, Spacing.horizontalEdges)
            Spacer()
        }
        .background {
            Colors.background
        }
    }
    private var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                VStack(alignment: .leading, spacing: Spacing.largePadding) {
                    Button("Back") {
                        router.back()
                    }
                    Text(companion.name)
                        .largeTitleModifier()
                }
            }
    }
    
    private var messagesContainer: some View {
        ScrollView(.vertical) {
            ForEach(messages, id: \.self) { message in
                messageView(text: message)
                    .padding(.vertical, Spacing.extraSmallPadding)
            }.rotationEffect(.degrees(180))
                .padding(Spacing.horizontalEdges)
        }.rotationEffect(.degrees(180))
    }
    
    private var textField: some View {
        HStack(spacing: Spacing.smallPadding) {
            TextField("Enter text", text: $text)
                .focused($isKeyboardForeground, equals: .foreground)
                .padding()
                .background(Colors.neutralSecondary)
                .cornerRadius(8)
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
    }
    
    private func companionMessageView(text: String) -> some View {
        HStack {
            Text(text)
                .foregroundColor(Colors.dark)
                .padding()
                .background(Colors.light)
                .cornerRadius(16)
                .largeShadowModifier()
            Spacer()
        }
    }
    
    private func userMessageView(text: String) -> some View {
        HStack {
            Spacer()
            Text(text)
                .foregroundColor(Colors.primary)
                .padding()
                .background(Colors.primarySecondary)
                .cornerRadius(16)
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
