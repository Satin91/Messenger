//
//  CurrentUser.swift
//  Messenger
//
//  Created by Артур Кулик on 18.06.2023.
//

import Foundation
import RealmSwift

@objcMembers
class CurrentUserModel: Object {
    dynamic var id = 0
    dynamic var user: UserModel?
    
    convenience init(user: UserModel) {
        self.init()
        self.id = user.id
        self.user = user
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}

