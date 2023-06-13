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
    @State var pageIndex: Int = 0
    
    var body: some View {
        content
            .onChange(of: viewModel.pageIndex) { newValue in
                pageIndex = newValue
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
                Color.clear
                    .onAppear {
                        router.pushToRegisterScreen(phoneNumber: viewModel.phoneNumberText)
                    }
            }
        }
        .padding(.horizontal, Spacing.horizontalEdges)
    }
}
