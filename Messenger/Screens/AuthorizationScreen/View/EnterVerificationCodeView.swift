//
//  EnterVerificationCodeView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct EnterVerificationCodeView: View {
    @EnvironmentObject var viewModel: AuthenticationScreenViewModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: Layout.Padding.large) {
            navigationBar
            infoLabel
            textField
            resendCodeLabel
            verificationButton
            Spacer()
        }
    }
    
    var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                VStack(alignment: .leading, spacing: Layout.Sizes.mediumControl) {
                    Button("Назад") {
                        viewModel.navigatior = .onEnterPhoneNumber
                        viewModel.verificationCode.removeAll()
                    }
                    Text("Подтвердить код")
                        .largeTitleModifier()
                }
            }
    }
    
    var infoLabel: some View {
        Text("Мы отправили Вам код, проверьте входящие СМС.")
            .font(Fonts.roboto(weight: .light, size: 16))
            .foregroundColor(Colors.dark)
    }
    
    var textField: some View {
        VerificationTextField(text: $viewModel.verificationCode)
    }
    
    var resendCodeLabel: some View {
        HStack(spacing: .zero) {
            Text("Не получили код? ")
                .font(Fonts.roboto(weight: .regular, size: 14))
                .foregroundColor(Colors.neutral)
            Button {
                viewModel.sendVerificationCode()
            } label: {
                Text("Отправить снова")
                    .font(Fonts.roboto(weight: .bold, size: 14))
                    .foregroundColor(Colors.primary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var verificationButton: some View {
        StatebleButton(title: "Подтвердить", isEnable: viewModel.verificationCode.count == 6) {
            viewModel.checkAuthCode()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct EnterVerificationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterVerificationCodeView()
    }
}
