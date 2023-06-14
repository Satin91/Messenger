//
//  HomeScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import SwiftUI

struct HomeScreen: View {
    var user: UserModel
    @EnvironmentObject var router: AppCoordinatorViewModel
    
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
        .background {
            Colors.background
        }
    }
    
    var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                Text("Chats")
                    .largeTitleModifier()
            }
    }
    
    var chatList: some View {
        ChatListView { companion in
            router.pushToChatScreen(user: self.user, companion: companion)
        }
    }
}
