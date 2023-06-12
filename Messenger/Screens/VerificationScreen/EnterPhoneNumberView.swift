//
//  EnterPhoneNumberView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct EnterPhoneNumberView: View {
    @EnvironmentObject var viewModel: VerificationScreenViewModel
    @State var text: String = ""
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: Spacing.largePadding) {
            infoLabel
            textField
            nextButton
        }
    }
    
    var infoLabel: some View {
        Text("Please enter")
            .font(Fonts.makeFont(weight: .light, size: 16))
            .foregroundColor(Colors.dark)
        +
        Text(" your phone number")
            .font(Fonts.makeFont(weight: .bold, size: 16))
            .foregroundColor(Colors.dark)
        +
        Text(", so we can verify you")
            .font(Fonts.makeFont(weight: .light, size: 16))
            .foregroundColor(Colors.dark)
    }
    
    var textField: some View {
        PhoneNumberTextFieldView(text: $text)
    }
    
    var nextButton: some View {
        StatebleButtonView(title: "Next", state:  text.count >= 12 ? .enable : .disable) {
            viewModel.checkAuthCode(phone: text)
        }
    }
}

struct EnterPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumberView()
    }
}
