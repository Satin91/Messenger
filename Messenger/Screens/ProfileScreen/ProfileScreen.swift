//
//  ProfileScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import SwiftUI
import RealmSwift
import Alamofire
import PhotosUI

struct ProfileScreen: View {
    @EnvironmentObject var router: AppCoordinatorViewModel
    @StateObject var viewModel: ProfileScreenViewModel
    
    /// Кнопка сохранения свойств пользователя имеет состояния, этот флаг оповещает об изменениях.
    @State var isUserChanged: Bool = false
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    var body: some View {
        content
            .onChange(of: viewModel) { newValue in
                isUserChanged = viewModel.compareChanges()
            }
            .onChange(of: avatarItem) { newValue in
                newValue?.loadTransferable(type: Data.self, completionHandler: { result in
                    DispatchQueue.main.async {
                        viewModel.avatar = try? result.get()
                    }
                })
            }
    }
    
    var content: some View {
        VStack(spacing: Spacing.mediumPadding) {
            navigationBar
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: Spacing.mediumPadding) {
                    avatarContainer
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
    
    var avatarContainer: some View {
        Image(placeholder: Constants.CommonNames.avatarPlaceholder, data: viewModel.avatar)
            .resizable()
            .scaledToFill()
            .frame(width: 180, height: 180)
            .clipShape(Circle())
            .padding()
            .overlay(alignment: .topTrailing) {
                PhotosPicker(selection: $avatarItem, matching: .images) {
                    Image(systemName: "arrow.down.app.fill", variableValue: 1.00)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(Colors.primary)
                    .font(.system(size: 34, weight: .regular))
                }
            }
            .frame(maxWidth: .infinity)
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
        
        StatebleButton(title: "Сохранить", isEnable: isUserChanged) {
            viewModel.updateUser()
        }
    }
}
