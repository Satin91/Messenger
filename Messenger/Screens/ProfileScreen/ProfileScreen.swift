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
        TitledTextField(title: "Имя", text: $viewModel.name, placeholder: "Введите имя")
    }
    
    var userNameLabel: some View {
        TitledTextField(title: "Имя пользователя", text: .constant(viewModel.user.username), placeholder: "Введите имя",isDisabled: true)
    }
    
    var phoneNumberLabel: some View {
        TitledTextField(title: "Номер телефона", text: .constant(viewModel.user.phone), placeholder: "",isDisabled: true)
    }
    
    var cityTextField: some View {
        TitledTextField(
            title: "Расположение",
            text: $viewModel.city.bound, placeholder: "Населенный пункт не указан"
        )
    }
    
    var zodiacSign: some View {
        ZStack {
            TitledTextField(
                title: "Знак зодиака",
                text: .constant(viewModel.zodiacSignText.bound), placeholder: "Дата рождения не выбрана",
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
        TitledTextField(title: "Обо мне", text: $viewModel.aboutMe, placeholder: "Расскажите о себе", axis: .vertical)
            .frame(alignment: .topLeading)
    }
    
    var saveButton: some View {
        
        StatebleButton(title: "Сохранить", isEnable: isChange) {
            viewModel.updateUser()
        }
    }
}
