//
//  EnterVerificationCodeView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct EnterVerificationCodeView: View {
    @EnvironmentObject var viewModel: VerificationScreenViewModel
    @State var text: String = ""
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: Spacing.largePadding) {
            navigationBar
            infoLabel
            textField
            resendCodeLabel
            Spacer()
        }
    }
    
    var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                VStack(alignment: .leading, spacing: Spacing.mediumControl) {
                    Button("Back") {
                        viewModel.goBack()
                    }
                    Text("Verify Code")
                        .largeTitleModifier()
                }
            }
    }
    
    var infoLabel: some View {
        Text("Check your sms inbox, we have sent you the code.")
            .font(Fonts.makeFont(weight: .light, size: 16))
            .foregroundColor(Colors.dark)
    }
    
    var textField: some View {
        VerificationTextField(text: $text)
    }
    
    var resendCodeLabel: some View {
        HStack(spacing: .zero) {
            Text("Didn’t Receive a code? ")
                .font(Fonts.makeFont(weight: .regular, size: 14))
                .foregroundColor(Colors.neutral)
            Button {
                viewModel.sendVerificationCode()
            } label: {
                Text("resend code")
                    .font(Fonts.makeFont(weight: .bold, size: 14))
                    .foregroundColor(Colors.primary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct EnterVerificationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterVerificationCodeView()
    }
}
