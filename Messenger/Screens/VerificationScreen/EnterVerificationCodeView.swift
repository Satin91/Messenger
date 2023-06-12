//
//  EnterVerificationCodeView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct EnterVerificationCodeView: View {
    @EnvironmentObject var viewModel: VerificationScreenViewModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: Spacing.mediumPadding) {
            navigationBar
            infoLabel
            Spacer()
        }
    }
    
    var navigationBar: some View {
        NavigationBarView()
            .addLeftContainer {
                VStack(alignment: .leading, spacing: Spacing.mediumPadding) {
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
}

struct EnterVerificationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterVerificationCodeView()
    }
}
