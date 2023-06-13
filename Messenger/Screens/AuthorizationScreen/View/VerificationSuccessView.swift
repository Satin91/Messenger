//
//  VerificationSuccessView.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import SwiftUI

struct VerificationSuccessView: View {
    
    var onButtonTapped: () -> Void
    
    var body: some View {
        content
    }
    
    private var content: some View {
        VStack(spacing: Spacing.largePadding) {
            doneImage
            textContainer
            getStartedButton
            Spacer()
        }
        .padding(.top, 140)
    }
    
    private var doneImage: some View {
        Images.verifySuccess
            .frame(width: 250, height: 250)
    }
    
    private var textContainer: some View {
        VStack(spacing: Spacing.smallPadding) {
            title
            subtitle
        }
    }
    
    private var title: some View {
        Text("Congrats!")
            .largeTitleModifier()
    }
    
    private var subtitle: some View {
        Text("You can start chatting")
            .font(Fonts.roboto(weight: .regular, size: 18))
            .foregroundColor(Colors.neutral)
    }
    
    private var getStartedButton: some View {
        StatebleButton(title: "Get started", isEnable: true) {
            onButtonTapped()
        }
        .frame(width: 185)
    }
}

struct VerifySuccessView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationSuccessView(onButtonTapped: {})
    }
}
