//
//  ChatListScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import SwiftUI

struct ChatListScreen: View {
    let mockChats = MockChats.chats
    
    @EnvironmentObject var router: AppCoordinatorViewModel
    @StateObject var viewModel: ChatListScreenViewModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack {
            navigationBar
            chatList
            Spacer()
        }
        .padding(Spacing.horizontalEdges)
        .fillBackgroundModifier(color: Colors.background)
    }
    
    var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                Text("Chats")
                    .largeTitleModifier()
            }
            .addRightContainer {
                profile
                    .onTapGesture {
                        router.pushToProfileScreen(user: viewModel.user)
                    }
            }
    }
    
    var profile: some View {
        Image(placeholder: Constants.CommonNames.avatarPlaceholder, data: viewModel.user.avatar)
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
    }
    
    var chatList: some View {
        ScrollView(.vertical) {
            ForEach(mockChats, id: \.id) { companion in
                ChatListRow(companion: companion)
                    .onTapGesture {
                        router.pushToChatScreen(user: viewModel.user, companion: companion)
                    }
            }
        }
    }
}

struct ChatListRow: View {
    let id = UUID()
    let companion: MockChats.ChatUser
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            HStack(spacing: Spacing.smallPadding) {
                avatar
                textContainer
            }
            Divider()
        }
        .frame(height: 80)
    }
    
    var avatar: some View {
        Image(companion.avatar)
            .resizable()
            .scaledToFill()
            .frame(width: 56, height: 56)
            .cornerRadius(16)
    }
    
    var textContainer: some View {
        VStack(alignment: .leading, spacing: Spacing.extraSmallPadding / 2) {
            nameLabel
            lastMessageLabel
        }
    }
    
    var nameLabel: some View {
        Text(companion.name)
            .foregroundColor(Colors.dark)
            .font(Fonts.roboto(weight: .medium, size: 18))
    }
    
    var lastMessageLabel: some View {
        Text(companion.messages.last ?? "No messages yet")
            .font(Fonts.roboto(weight: .regular, size: 16))
            .foregroundColor(Colors.neutral)
    }
}
