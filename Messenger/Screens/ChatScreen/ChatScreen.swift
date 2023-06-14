//
//  ChatScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 14.06.2023.
//

import SwiftUI

struct ChatScreen: View {
    @EnvironmentObject var router: AppCoordinatorViewModel
    
    var user: UserModel
    var companion: MockChats.ChatUser
    
    var body: some View {
        content
    }
    
    var content: some View {
        Text("")
    }
    var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                VStack(alignment: .leading) {
                    Button("Back") {
                        router.back()
                    }
                }
            }
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen(user: UserModel(), companion: MockChats.ChatUser(name: "Vegtables", avatar: "chatAvatar2", messages: [MockChats.Message(text: "Hello!", date: Date())]))
    }
}
