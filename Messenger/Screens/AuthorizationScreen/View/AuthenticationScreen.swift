//
//  VerificationScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct AuthenticationScreen: View {
    @EnvironmentObject var viewModel: AuthenticationScreenViewModel
    @EnvironmentObject var AppCoordinator: AppCoordinatorViewModel
    
    @State var isScreenChanged: Bool = false
    var body: some View {
        content
            .onChange(of: viewModel.navigatior) { changeScneen in
                isScreenChanged.toggle()
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
                EnterVerificationCodeView()
            case .onRegistrationScreen:
                RegistrationView()
            case .toChatList(let user):
                Color.clear.onAppear {
                    AppCoordinator.pushToChatListScreen(user: user)
                }
            case .onError(let text):
                Text(text)
                    .foregroundColor(Colors.dark)
                    .frame(width: 320, height: 320)
                    .background(Color.clear)
            }
        }
        .padding(.horizontal, Spacing.horizontalEdges)
        .animation(.default, value: isScreenChanged)
    }
}
