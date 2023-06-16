//
//  ProfileScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import SwiftUI
import RealmSwift
import Alamofire

struct ProfileScreen: View {
    @EnvironmentObject var router: AppCoordinatorViewModel
    @StateObject var viewModel: ProfileScreenViewModel
    
    @State var isChange: Bool = false
    
    var body: some View {
        content
            .onChange(of: viewModel) { newValue in
                isChange = viewModel.compareChanges()
            }
    }
    
    var content: some View {
        VStack(spacing: Spacing.mediumPadding) {
            navigationBar
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: Spacing.mediumPadding) {
                    avatar
                    textContainer
                    saveButton
                }
                .padding(.horizontal, Spacing.horizontalEdges)
            }
        }
        .fillBackgroundModifier(color: Colors.background)
    }
    
    var navigationBar: some View {
        NavigationBar()
            .addLeftContainer {
                Button("Back") {
                    router.back()
                }
            }
            .padding(.horizontal, Spacing.horizontalEdges)
    }
    
    var avatar: some View {
        Image(viewModel.user.avatar ?? "avatarPlaceholder")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .cornerRadius(Spacing.defaultRadius * 2)
    }
    
    var textContainer: some View {
        VStack(alignment: .leading, spacing: Spacing.mediumPadding) {
            Group {
                nameTextField
                userNameLabel
                phoneNumberLabel
                zodiacSign
                cityTextField
                aboutMeTextField
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var nameTextField: some View {
        TitledTextField(title: "Имя", placeholder: "Введите имя", text: $viewModel.name)
    }
    
    var userNameLabel: some View {
        TitledTextField(title: "Имя пользователя", placeholder: "Введите имя", text: .constant(viewModel.user.username),isDisabled: true)
    }
    
    var phoneNumberLabel: some View {
        TitledTextField(title: "Номер телефона", placeholder: "", text: .constant(viewModel.user.phone),isDisabled: true)
    }
    
    var cityTextField: some View {
        TitledTextField(
            title: "Расположение",
            placeholder: "Населенный пункт не указан",
            text: $viewModel.city.bound
        )
    }
    
    var zodiacSign: some View {
        ZStack {
            TitledTextField(
                title: "Знак зодиака",
                placeholder: "Дата рождения не выбрана",
                text: .constant(viewModel.zodiacSignText.bound),
                isDisabled: true
            )
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    datePicker
                        .frame(alignment: .bottomLeading)
                }
            }

        }
    }
    
    var datePicker: some View {
        DatePicker(selection: $viewModel.birthday.bound, in: ...Date.now, displayedComponents: .date) {
        }
        .labelsHidden()
        .accentColor(Colors.primary)
        .padding(8)
    }
    
    
    var aboutMeTextField: some View {
        TitledTextField(title: "Обо мне", placeholder: "Расскажите о себе", text: $viewModel.aboutMe)
            .frame(alignment: .topLeading)
            .lineLimit(10)
    }
    
    var saveButton: some View {
        
        StatebleButton(title: "Сохранить", isEnable: isChange) {
            viewModel.updateUser()
        }
    }
}
