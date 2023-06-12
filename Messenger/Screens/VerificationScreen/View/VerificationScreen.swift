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
        container
            .background(Colors.background)
        
    }
    
    var container: some View {
        TabView(selection: $viewModel.pageIndex) {
            Group {
                EnterPhoneNumberView()
                    .tag(0)
                EnterVerificationCodeView()
                    .tag(1)
            }
            .padding(Spacing.horizontalEdges)
        }
        .tabViewStyle(.page)
    }
}

struct VerificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        VerificationScreen()
    }
}
