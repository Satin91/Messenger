//
//  VerificationScreenViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import Combine
import Foundation
import SwiftUI

final class VerificationScreenViewModel: ObservableObject {
    var authService: AuthentificationServiceProtocol
    var subscriber = Set<AnyCancellable>()
    
    @Published var isCodeSent: Bool = false
    
    init(authService: AuthentificationServiceProtocol) {
        self.authService = authService
    }
    
    func checkAuthCode(phone: String) {
        authService.sendAuthCode(phone: phone)
            .sink(receiveCompletion: { completion in
                let error = try? completion.error()
                print(error?.localizedDescription)
            }, receiveValue: { response in
                self.isCodeSent = response.is_success
            })
            .store(in: &subscriber)
    }
}
