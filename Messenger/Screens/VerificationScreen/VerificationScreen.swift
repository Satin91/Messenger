//
//  VerificationScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct VerificationScreen: View {
    @EnvironmentObject var viewModel: VerificationScreenViewModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack {
            navigationBar
            container
            Spacer()
        }
        .padding(Spacing.horizontalEdges)
    }
    
    var navigationBar: some View {
        NavigationBarView(title: "Регистрация", type: .large)
        
    }
    
    @ViewBuilder var container: some View {
        switch viewModel.isCodeSent {
        case true:
            EnterVerificationCodeView()
        case false:
            EnterPhoneNumberView()
        }
    }
    
}

struct VerificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        VerificationScreen()
    }
}
