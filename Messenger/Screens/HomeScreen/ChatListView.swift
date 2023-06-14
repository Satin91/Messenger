//
//  ChatListView.swift
//  Messenger
//
//  Created by Артур Кулик on 14.06.2023.
//

import SwiftUI

struct ChatListView: View {
    let mockChats = MockChats.chats
    var onSelectRow: (MockChats.ChatUser) -> Void
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(mockChats, id: \.id) { chat in
                ChatListRow(user: chat)
                    .onTapGesture {
                        onSelectRow(chat)
                    }
            }
        }
    }
}

struct ChatListRow: View {
    let id = UUID()
    let user: MockChats.ChatUser
    
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
        Image(user.avatar)
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
        Text(user.name)
            .foregroundColor(Colors.dark)
            .font(Fonts.roboto(weight: .medium, size: 18))
    }
    
    var lastMessageLabel: some View {
        Text(user.messages.last ?? "No messages yet")
            .font(Fonts.roboto(weight: .regular, size: 16))
            .foregroundColor(Colors.neutral)
    }
}
