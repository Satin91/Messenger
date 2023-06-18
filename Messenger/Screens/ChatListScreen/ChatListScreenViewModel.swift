//
//  ChatListViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 17.06.2023.
//

import Foundation

/* Ввиду отсутствия бизнес логики, эта вью модель, по сути, не требуется,
 но если потребуется обрабатывать реальные модели чат листа, она пригодится.
 */
final class ChatListScreenViewModel: ObservableObject {
    var user: UserModel
    
    init(user: UserModel) {
        self.user = user
    }
}
