//
//  SessionInfo.swift
//  Messenger
//
//  Created by Артур Кулик on 18.06.2023.
//

import Foundation

class SessionInfo {
    static let shared = SessionInfo()
    
    var userID: Int?
    var accessToken: String?
    var refreshToken: String?
}
