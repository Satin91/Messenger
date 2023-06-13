//
//  EnterPhoneNumberView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI
import Alamofire

struct EnterPhoneNumberView: View {
    @EnvironmentObject var viewModel: AuthentificationScreenViewModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: Spacing.largePadding) {
            navigationBar
            infoLabel
            textField
            nextButton
            Spacer()
        }
    }
    
    var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                Text("Register")
                    .largeTitleModifier()
            }
    }
    
    var infoLabel: some View {
        Text("Please enter")
            .font(Fonts.roboto(weight: .light, size: 16))
            .foregroundColor(Colors.dark)
        +
        Text(" your phone number")
            .font(Fonts.roboto(weight: .bold, size: 16))
            .foregroundColor(Colors.dark)
        +
        Text(", so we can verify you")
            .font(Fonts.roboto(weight: .light, size: 16))
            .foregroundColor(Colors.dark)
    }
    
    var textField: some View {
        PhoneNumberTextField(text: $viewModel.phoneNumberText)
    }
    
    var nextButton: some View {
        StatebleButton(title: "Next", isEnable: viewModel.isFullPhoneNumber) {
            viewModel.sendAuthCode()
        }
    }
}

struct EnterPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumberView()
    }
}
