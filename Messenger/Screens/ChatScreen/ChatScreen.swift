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
        .fillBackgroundModifier(
            content:
                Colors.chatBackground
        )
    }
    
    private var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                HStack(spacing: Layout.Padding.medium) {
                    NavigationBarButton(imageSystemName: "arrow.left") {
                        appCoordinator.back()
                    }
                    HStack(spacing: Layout.Padding.small) {
                        Image(uiImage: UIImage(data: viewModel.companion.avatar)!) // TODO: Установить аватарку
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 58, height: 58)
                        VStack(alignment: .leading, spacing: Layout.Padding.extraSmall) {
                            Text(viewModel.companion.name)
                                .smalTitleModifier()
                                .lineLimit(1)
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
                messageView(message: message)
                    .padding(.vertical, 4)
            }.rotationEffect(.degrees(180))
                .padding(Layout.Padding.horizontalEdges)
                .animation(.easeInOut, value: viewModel.messages)
        }.rotationEffect(.degrees(180))
    }
    
    private var textFieldContainer: some View {
        HStack(spacing: Layout.Padding.small) {
            TextField("Enter text", text: $text)
                .font(Fonts.museoSans(weight: .regular, size: 14))
                .focused($isKeyboardForeground, equals: .foreground)
                .padding()
                .background(Colors.dark)
                .cornerRadius(Layout.Radius.defaultRadius, antialiased: true)
            Button {
                isKeyboardForeground = nil
                guard !text.isEmpty else { return }
                viewModel.write(text: text)
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
                .cornerRadius(Layout.Radius.smallRadius)
        }
    }
    
    @ViewBuilder private func messageView(message: MessageModel) -> some View {
        if message.ownerId != String(viewModel.user.id) {
            companionMessageView(text: message.text)
        } else {
            userMessageView(text: message.text)
        }
    }
}
