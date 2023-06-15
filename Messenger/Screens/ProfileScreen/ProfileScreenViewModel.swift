//
//  ProfileScreenViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import Foundation

final class ProfileScreenViewModel: ObservableObject{
    var remoteUserService: RemoteUserServiceProtocol
    
    init(remoteUserService: RemoteUserServiceProtocol) {
        self.remoteUserService = remoteUserService
    }
    
    
}
