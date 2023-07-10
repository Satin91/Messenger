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
        VStack {
            navigationBar
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
        .background(content: {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red.opacity(0.3),.white, .red.opacity(0.4), .red.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .blur(radius: 140)
//                AngularGradient(gradient: Gradient(colors: [.red, .mint]), center: .center, startAngle: .zero, endAngle: .degrees(360))
//                    .opacity(0.1)
            }
        })
//        .fillBackgroundModifier(color: Colors.background)
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
                .foregroundColor(Colors.primary)
                .font(.system(size: 36, weight: .semibold))
                .shadow(color: Colors.primarySecondary, radius: 4)
                .padding()
                .clipShape(Circle())
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
        VStack(alignment: .leading) {
            HStack(spacing: Layout.Padding.small) {
                avatar
                textContainer
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: Layout.Radius.defaultRadius)
                .stroke(Color.white.opacity(0.8), lineWidth: 1)
                .shadow(color: Color.white,
                        radius: 64, x: 0, y: 0)
                .clipShape(
                    RoundedRectangle(cornerRadius: Layout.Radius.defaultRadius)
                )
                .shadow(color: Color.white, radius: 8, x: 0, y: 0)
                .clipShape(
                    RoundedRectangle(cornerRadius: Layout.Radius.defaultRadius)
                )
        )
        .background(Color.white.opacity(0.2))
        .cornerRadius(20)
//        .roundedBorderModifier(borderColor: Color.clear, backgroundColor: Color.gray)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
    
    var avatar: some View {
        Image(Constants.CommonNames.avatarPlaceholder)
            .resizable()
            .scaledToFill()
            .frame(width: 56, height: 56)
            .cornerRadius(16)
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
            .font(Fonts.museoSans(weight: .regular, size: 16))
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
