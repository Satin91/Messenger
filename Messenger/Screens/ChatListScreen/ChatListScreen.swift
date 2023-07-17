//
//  ChatListScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import SwiftUI

struct ChatListScreen: View {
    //    let mockChats = MockChats.chats
    
    @EnvironmentObject var appCoordinator: AppCoordinatorViewModel
    @StateObject var viewModel: ChatListScreenViewModel
    @State var presentPopup: Bool = false
    
    var body: some View {
        content
            .onTapGesture {
                presentPopup = false
            }
            .modifier(Popup(isPresented: presentPopup, alignment: .bottom, content: {
                selectChatTypeMenu
            }))
            .edgesIgnoringSafeArea(.bottom)
    }
    
    var content: some View {
        VStack(spacing: .zero) {
            navigationBar
                .background {
                    Colors.light.opacity(0.2)
                        .edgesIgnoringSafeArea(.all)
                }
            Divider()
            chatList
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlay {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    createChatButton
                }
            }
        }
        .fillBackgroundModifier(
            content:
                Image("bgBlur")
                .resizable()
                .scaledToFill()
                .frame(height: 900)
        )
    }
    
    var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                Text("Чаты")
                    .largeTitleModifier()
            }
            .addRightContainer {
                profile
                    .onTapGesture {
                        appCoordinator.pushToProfileScreen(user: viewModel.user)
                    }
            }
            .padding(Layout.Padding.horizontalEdges)
    }
    
    var profile: some View {
        Image(placeholder: Constants.CommonNames.avatarPlaceholder, data: viewModel.user.avatarData)
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
    }
    
    var chatList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.chats, id: \.id) { companion in
                ChatListRow(companion: companion)
                    .onTapGesture {
                        appCoordinator.pushToChatScreen(user: viewModel.user, companion: companion)
                    }
            }
            .offset(y: 8)
        }
        .frame(maxWidth: .infinity)
    }
    
    var createChatButton: some View {
        Button {
            presentPopup.toggle()
        } label: {
            Image(systemName: "plus", variableValue: 1.00)
                .foregroundColor(Colors.dark)
                .font(.system(size: 36, weight: .light))
                .shadow(color: Colors.primarySecondary, radius: 4)
                .padding()
                .clipShape(Circle())
                .glassBackground(radius: 250)
                .padding(36)
        }
        
    }
    
    var selectChatTypeMenu: some View {
        VStack(alignment: .leading, spacing: 16) {
            SelectChatTypeRow(text: "Обычный чат", imageName: "bubble.left.and.bubble.right")
                .onTapGesture {
                    viewModel.addCompanion(of: 0)
                    presentPopup.toggle()
                }
            SelectChatTypeRow(text: "Знайка", imageName: "cloud.bolt.rain")
                .onTapGesture {
                    viewModel.addCompanion(of: 8)
                    presentPopup.toggle()
                }
            SelectChatTypeRow(text: "Выдумщик", imageName: "cloud.bolt.rain")
                .onTapGesture {
                    viewModel.addCompanion(of: 9)
                    presentPopup.toggle()
                }
        }
        .padding()
        .padding(.bottom, 44)
        .frame(maxWidth: .infinity)
        .glassBackground(radius: .zero)
        .largeShadowModifier()
    }
}

struct ChatListRow: View {
    let id = UUID()
    let companion: CompanionModel
    var body: some View {
        content
    }
    
    var content: some View {
        HStack(spacing: Layout.Padding.small) {
            avatar
            textContainer
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .glassBackground(radius: Layout.Radius.defaultRadius)
        .padding(.horizontal)
        .shadow(color: Color(hex: "452A7C").opacity(0.45), radius: 30, y: 30)
    }
    
    var avatar: some View {
        Image(uiImage: UIImage(data: companion.avatar)!)
            .resizable()
            .scaledToFill()
            .frame(width: 86, height: 86)
            .glassBackground(radius: Layout.Radius.defaultRadius)
            .cornerRadius(Layout.Radius.defaultRadius)
        
    }
    
    var textContainer: some View {
        VStack(alignment: .leading, spacing: Layout.Padding.extraSmall / 2) {
            nameLabel
            lastMessageLabel
        }
    }
    
    var nameLabel: some View {
        Text(companion.name)
            .foregroundColor(Colors.dark)
            .font(.system(size: 18, weight: .semibold))
    }
    
    var lastMessageLabel: some View {
        Text(companion.messages.last?.text ?? "No messages yet")
            .lineLimit(2)
            .font(.system(size: 14, weight: .light))
            .foregroundColor(Colors.dark)
    }
}

struct SelectChatTypeRow: View {
    let text: String
    let imageName: String
    
    var body: some View {
        content
    }
    
    var content: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(Color.black)
                .font(.system(size: 16, weight: .medium))
                .blendMode(.overlay)
                .frame(width: 24, height: 24)
                .padding()
                .glassBackground(radius: 150)
            Text(text)
                .font(Fonts.museoSans(weight: .regular, size: 18))
                .foregroundColor(Colors.dark)
                .padding(Layout.Padding.small)
        }
    }
}
