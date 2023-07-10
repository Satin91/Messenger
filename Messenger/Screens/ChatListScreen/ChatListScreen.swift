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
                ZStack {
                    LinearGradient(colors: [.blue, .purple, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .opacity(0.4)
                        .blur(radius: 40)
//                    AngularGradient(colors: [.red, .purple], center: .topLeading)
//                        .opacity(0.2)
//                        .blur(radius: 140)
                }
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
        }
        .frame(maxWidth: .infinity)
    }
    
    var createChatButton: some View {
        Button {
            //            viewModel.addCompanion()
            presentPopup.toggle()
        } label: {
            Image(systemName: "plus", variableValue: 1.00)
                .foregroundColor(Colors.dark)
                .font(.system(size: 36, weight: .light))
                .shadow(color: Colors.primarySecondary, radius: 4)
                .padding()
                .clipShape(Circle())
                .glassBackground(radius: 150)
                .largeShadowModifier()
                .padding(36)
        }
        
    }
    
    var selectChatTypeMenu: some View {
        VStack(alignment: .leading, spacing: .zero) {
            SelectChatTypeRow(text: "Обычный чат")
            SelectChatTypeRow(text: "Чат с рецептами")
            SelectChatTypeRow(text: "Чат с предсказаниями")
        }
        .padding()
        .padding(.bottom, 44)
        .frame(maxWidth: .infinity)
        .background {
            Colors.light
        }
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
            .frame(height: 100)
            .padding()
    }
    
    var avatar: some View {
        Image("chatAvatar1")
            .resizable()
            .scaledToFill()
            .frame(width: 56, height: 56)
            .cornerRadius(8)
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
            .font(Fonts.museoSans(weight: .medium, size: 18))
    }
    
    var lastMessageLabel: some View {
        Text(companion.messages.last?.text ?? "No messages yet")
            .font(Fonts.museoSans(weight: .regular, size: 14))
            .foregroundColor(Colors.neutral)
    }
}

struct SelectChatTypeRow: View {
    let text: String
    
    var body: some View {
        content
    }
    
    var content: some View {
        Text(text)
            .font(Fonts.museoSans(weight: .regular, size: 18))
            .foregroundColor(Colors.dark)
            .padding(Layout.Padding.small)
    }
}
