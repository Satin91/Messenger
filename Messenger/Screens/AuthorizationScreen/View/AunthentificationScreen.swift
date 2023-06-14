//
//  VerificationScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct AunthentificationScreen: View {
    @EnvironmentObject var viewModel: AuthentificationScreenViewModel
    @EnvironmentObject var router: AppCoordinatorViewModel
    
    var body: some View {
        content
            .onChange(of: viewModel.registerSuccess) { isSuccess in
                if isSuccess {
                    router.pushToHomeScreen()
                }
            }
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
            case .onVerivicationSuccess:
                VerificationSuccessView {
                    router.pushToHomeScreen()
                }
            case .goToRegistrationScreen:
                RegistrationView()
            }
        }
        .padding(.horizontal, Spacing.horizontalEdges)
    }
}
