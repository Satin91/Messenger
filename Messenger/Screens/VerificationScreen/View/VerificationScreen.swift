//
//  VerificationScreen.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct VerificationScreen: View {
    @EnvironmentObject var viewModel: VerificationScreenViewModel
    @EnvironmentObject var router: AppCoordinatorViewModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        container
            .background(Colors.background)
    }
    
    @ViewBuilder var container: some View {
        Group {
            if viewModel.pageIndex == 1 {
                EnterPhoneNumberView()
            } else {
                EnterVerificationCodeView {
                    router.pushToHomeScreen()
                }
            }
        }
        .padding(.horizontal, Spacing.horizontalEdges)
    }
}
//
//struct VerificationScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        VerificationScreen()
//    }
//}
