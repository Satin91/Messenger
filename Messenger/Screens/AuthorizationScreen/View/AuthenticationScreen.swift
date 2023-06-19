//
//  VerificationScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct AuthenticationScreen: View {
    @EnvironmentObject var viewModel: AuthenticationScreenViewModel
    @EnvironmentObject var appCoordinator: AppCoordinatorViewModel
    
    @State var showAlert: Bool = false
    
    var body: some View {
        content
            .onChange(of: viewModel.showAlert) { _ in
                self.showAlert.toggle()
            }
    }
    
    var content: some View {
        container
            .frame(maxWidth: .infinity)
            .background(Colors.background)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Ошибка"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Понятно")))
            }
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
                    appCoordinator.pushToChatListScreen(user: user)
                }
            }
        }
        .padding(.horizontal, Layout.Padding.horizontalEdges)
    }
}
