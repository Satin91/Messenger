//
//  RegistrationScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import SwiftUI

struct RegistrationScreen: View {
    @StateObject var viewModel: RegistrationScreenViewModel
    
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
                Text("Register")
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
        .modifier(RoundedBorderModifier(color: Colors.primary))
        .padding(.top, Spacing.mediumPadding)
    }
    
    private var phoneNumberLabel: some View {
        Text(viewModel.phoneNumber)
            .font(Fonts.roboto(weight: .regular, size: 14))
            .foregroundColor(Colors.neutralSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var nameTextField: some View {
        TextField("name", text: $viewModel.name)
    }
    
    private var usernameTextField: some View {
        TextField("username", text: $viewModel.userName)
    }
    
    private var registerButton: some View {
        StatebleButton(title: "Register", isEnable: true) {
            viewModel.register()
        }
    }
}
