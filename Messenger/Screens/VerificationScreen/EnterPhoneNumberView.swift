//
//  EnterPhoneNumberView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct EnterPhoneNumberView: View {
    @EnvironmentObject var viewModel: VerificationScreenViewModel
    @State var text: String = ""
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(spacing: Spacing.mediumPadding) {
            textField
            nextButton
        }
    }
    
    var textField: some View {
        BorderedTextField(text: $text)
    }
    
    var nextButton: some View {
        StatebleButton(title: "Next", state:  text.count >= 12 ? .enable : .disable) {
            viewModel.checkAuthCode(phone: text)
        }
    }
}

struct EnterPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumberView()
    }
}
