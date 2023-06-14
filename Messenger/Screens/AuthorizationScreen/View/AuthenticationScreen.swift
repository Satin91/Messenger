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
                EnterVerificationCodeView {
                    viewModel.checkAuthCode()
                }
            case .onRegistrationScreen:
                RegistrationView()
            case .toHomeScreen(let user):
                Color.clear.onAppear {
                    router.pushToHomeScreen(user: user)
                }
            }
        }
        .padding(.horizontal, Spacing.horizontalEdges)
    }
}
