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
    var user: UserModel
    @EnvironmentObject var router: AppCoordinatorViewModel
    @StateObject var viewModel: ProfileScreenViewModel
    @State var name: String = ""
    @State var aboutMe: String = ""
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(spacing: Spacing.mediumPadding) {
            navigationBar
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: Spacing.mediumPadding) {
                    avatar
                    textContainer
                }
                .padding(.horizontal, Spacing.horizontalEdges)
            }
        }
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
        Image(user.avatar ?? "avatarPlaceholder")
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
                aboutMeTextField
            }
            .smalTitleModifier()
            .frame(maxWidth: .infinity, alignment: .leading)
            .roundedBorderModifier(color: Colors.neutral)
        }
    }
    
    var nameTextField: some View {
        TextField("Имя", text: $name)
    }
    
    var userNameLabel: some View {
        Text(user.username)
    }
    
    var phoneNumberLabel: some View {
        Text(user.phone)
            .foregroundColor(Colors.neutral)
    }
    
    var city: some View {
        Text(user.city ?? "")
    }
    
    var zodiacSign: some View {
        Text("Водолеюшка")
    }
    
    var aboutMeTextField: some View {
        TextField("Расскажите о себе", text: $aboutMe, axis: .vertical)
            .frame(alignment: .topLeading)
            .lineLimit(10)
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        let userModel = UserModel()
        userModel.name = "Артур"
        userModel.username = "Satin"
        userModel.aboutMe = "asd"
        userModel.avatars = RealmSwift.List<String>()
        userModel.phone = "72125123532"
        return ProfileScreen(user: userModel, viewModel: ProfileScreenViewModel(remoteUserService: RemoteUserService(networkManager: NetworkManager(session: Session.default))))
    }
}
//
//Должен содержать аватарку пользователя, номер телефона, никнейм, город проживания, дату рождения, знак зодиака по дате рождения, о себе.
