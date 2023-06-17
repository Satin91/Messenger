//
//  VerificationScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct AuthenticationScreen: View {
    @EnvironmentObject var viewModel: AuthenticationScreenViewModel
    @EnvironmentObject var router: AppCoordinatorViewModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        container
            .frame(maxWidth: .infinity)
            .background(Colors.background)
    }
    
    @ViewBuilder var container: some View {
        Group {
            switch viewModel.navigatior {
            case .onEnterPhoneNumber:
                EnterPhoneNumberView()
            case .onEnterVerificationCode:
                EnterVerificationCodeView()
            case .onRegistrationScreen:
                RegistrationView()
            case .toChatList(let user):
                Color.clear.onAppear {
                    router.pushToChatList(user: user)
                }
            case .onError(let text):
                Text(text)
                    .foregroundColor(Colors.lightGray)
                    .frame(width: 320, height: 320)
            }
        }
        .padding(.horizontal, Spacing.horizontalEdges)
    }
}
