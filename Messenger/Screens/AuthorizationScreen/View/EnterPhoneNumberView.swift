//
//  EnterPhoneNumberView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI
import Alamofire

struct EnterPhoneNumberView: View {
    @EnvironmentObject var viewModel: AuthenticationScreenViewModel
    @State var isValidPhoneNumber: Bool = false
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: Layout.Padding.large) {
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
                Text("Здравствуйте!")
                    .largeTitleModifier()
            }
    }
    
    var infoLabel: some View {
        Text("Пожалуйста, введите")
            .font(Fonts.roboto(weight: .light, size: 16))
            .foregroundColor(Colors.dark)
        +
        Text(" свой номер телефона")
            .font(Fonts.roboto(weight: .bold, size: 16))
            .foregroundColor(Colors.dark)
        +
        Text(", чтобы мы могли подтвердить Вашу личность.")
            .font(Fonts.roboto(weight: .light, size: 16))
            .foregroundColor(Colors.dark)
    }
    
    var textField: some View {
        PhoneNumberTextField(text: $viewModel.phoneNumber, isValidNumber: $isValidPhoneNumber)
    }
    
    var nextButton: some View {
        StatebleButton(title: "Отправить код", isEnable: isValidPhoneNumber) {
            viewModel.sendAuthCode()
        }
    }
}

struct EnterPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumberView()
    }
}
