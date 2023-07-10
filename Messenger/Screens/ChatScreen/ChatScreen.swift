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
    @StateObject var viewModel: ChatScreenViewModel
    
    @State var text = ""
    @FocusState var isKeyboardForeground: KeyboardForeground?
    
    var body: some View {
        content
            .dismissingKeyboard()
    }
    
    private var content: some View {
        VStack(spacing: .zero) {
            navigationBar
                .padding(Layout.Padding.horizontalEdges)
            messagesContainer
            Divider()
            textFieldContainer
        }
        .fillBackgroundModifier(color: Colors.background)
    }
    
    private var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                VStack(alignment: .leading, spacing: Layout.Padding.medium) {
                    NavigationBarButton(imageSystemName: "arrow.left") {
                        appCoordinator.back()
                    }
                    HStack(spacing: Layout.Padding.small) {
                        Image(viewModel.companion.avatar)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 58, height: 58)
                        VStack(alignment: .leading, spacing: Layout.Padding.extraSmall) {
                            Text(viewModel.companion.name)
                                .mediumTitleModifier()
                            Text("Online")
                                .font(Fonts.museoSans(weight: .regular, size: 16))
                                .foregroundColor(Colors.neutral)
                        }
                    }
                }
            }
    }
    
    private var messagesContainer: some View {
        ScrollView(.vertical) {
            ForEach(viewModel.messages, id: \.self) { message in
                messageView(text: message)
                    .padding(.vertical, 4)
            }.rotationEffect(.degrees(180))
                .padding(Layout.Padding.horizontalEdges)
                .animation(.easeInOut, value: viewModel.messages)
        }.rotationEffect(.degrees(180))
            .background(Colors.chatBackground)
    }
    
    private var textFieldContainer: some View {
        HStack(spacing: Layout.Padding.small) {
            TextField("Enter text", text: $text)
                .font(Fonts.museoSans(weight: .regular, size: 14))
                .focused($isKeyboardForeground, equals: .foreground)
                .padding()
                .background(Colors.light)
                .cornerRadius(Layout.Radius.defaultRadius, antialiased: true)
            Button {
                isKeyboardForeground = nil
                guard !text.isEmpty else { return }
                viewModel.messages.append(text)
                viewModel.send(message: text)
                text = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 26))
                    .foregroundColor(text.isEmpty ? Colors.neutral : Colors.primary)
            }
            
        }
        .padding(.vertical, Layout.Padding.small)
        .padding(.horizontal, Layout.Padding.horizontalEdges)
        .background(Colors.chatBackground)
    }
    
    private func companionMessageView(text: String) -> some View {
        HStack {
            Text(text)
                .font(Fonts.museoSans(weight: .regular, size: 14))
                .foregroundColor(Colors.dark)
                .padding()
                .background(Colors.light)
                .cornerRadius(Layout.Radius.smallRadius)
                .largeShadowModifier()
            Spacer()
        }
    }
    
    private func userMessageView(text: String) -> some View {
        HStack {
            Spacer()
            Text(text)
                .font(Fonts.museoSans(weight: .regular, size: 14))
                .foregroundColor(Colors.primary)
                .padding()
                .background(Colors.primarySecondary)
                .cornerRadius(Layout.Radius.defaultRadius)
        }
    }
    
    @ViewBuilder private func messageView(text: String) -> some View {
        if viewModel.companion.messages.contains(text) {
            companionMessageView(text: text)
        } else {
            userMessageView(text: text)
        }
    }
}
