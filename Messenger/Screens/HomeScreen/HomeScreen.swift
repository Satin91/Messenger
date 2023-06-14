//
//  HomeScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import SwiftUI

struct HomeScreen: View {
    var user: UserModel
    
    var body: some View {
        VStack {
            Text(user.name)
            Text(user.username)
            Text(user.phone)
        }
    }
}

//struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreen()
//    }
//}
