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
        VStack(spacing: Spacing.largePadding) {
            navigationBar
            textFieldContainer
            registerButton
            Spacer()
        }
        .padding(.horizontal, Spacing.horizontalEdges)
        .background(Colors.background)
    }
    
    private var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                Text("Регистрация")
                    .largeTitleModifier()
            }
    }
    
    private var textFieldContainer: some View {
        Group {
            phoneNumberLabel
            nameTextField
            usernameTextField
        }
        .primaryTextModifier()
        .padding(.leading, Spacing.smallPadding)
        .roundedBorderModifier(borderColor: Colors.primary)
        .padding(.top, Spacing.mediumPadding)
    }
    
    private var phoneNumberLabel: some View {
        Text(viewModel.phoneNumber)
            .font(Fonts.roboto(weight: .regular, size: 14))
            .foregroundColor(Colors.neutralSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var nameTextField: some View {
        TextField("Имя", text: $viewModel.name)
    }
    
    private var usernameTextField: some View {
        TextField("Никнейм", text: $viewModel.username)
    }
    
    private var registerButton: some View {
        StatebleButton(title: "Зарегистрироваться", isEnable: true) {
            viewModel.register()
        }
    }
}
