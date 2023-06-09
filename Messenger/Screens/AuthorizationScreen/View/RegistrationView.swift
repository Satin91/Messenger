//
//  RegistrationView.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: AuthenticationScreenViewModel
    
    var body: some View {
        content
    }
    
    private var content: some View {
        VStack(spacing: Layout.Padding.large) {
            navigationBar
            textFieldContainer
            registerButton
            Spacer()
        }
        .background(Colors.background)
    }
    
    private var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                VStack(alignment: .leading) {
                    NavigationBarButton(imageSystemName: "arrow.left") {
                        viewModel.navigatior = .onEnterPhoneNumber
                    }
                    Text("Регистрация")
                        .largeTitleModifier()
                }
            }
    }
    
    private var textFieldContainer: some View {
        VStack {
            phoneNumberLabel
            nameTextField
            usernameTextField
        }
    }
    
    private var phoneNumberLabel: some View {
        TitledTextField(
            title: "Номер телефона",
            text: .constant(viewModel.phoneNumber),
            placeholder: "",
            isEntryDisabled: true
        )
    }
    
    private var nameTextField: some View {
        TitledTextField(
            title: "Имя",
            text: $viewModel.name,
            placeholder: ""
        )
        .textFilterModifier(text: $viewModel.name, syntax: .URIGeneric)
    }
    
    private var usernameTextField: some View {
        TitledTextField(
            title: "Имя пользователя (Минимум 5 символов)",
            text: $viewModel.username,
            placeholder: ""
        )
        .textFilterModifier(text: $viewModel.username, syntax: .URIGeneric)
    }
    
    private var registerButton: some View {
        StatebleButton(title: "Зарегистрироваться", isEnable: true) {
            viewModel.register()
        }
    }
}
