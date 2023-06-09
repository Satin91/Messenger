//
//  StatebleButtonView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct StatebleButton: View {
    var title: String
    var isEnable: Bool
    var action: () -> Void
    var body: some View {
        content
    }
    
    var content: some View {
        button
            .onTapGesture {
                if isEnable {
                    action()
                }
            }
    }
    
    
    var button: some View {
        RoundedRectangle(cornerRadius: Layout.Radius.smallRadius, style: .continuous)
            .foregroundColor(isEnable ? Colors.primary : Colors.neutral)
            .frame(height: Layout.Sizes.mediumControl)
            .overlay {
                Text(title)
                    .font(Fonts.museoSans(weight: .bold, size: 18))
                    .foregroundColor(Colors.light)
            }
    }
}

struct StatebleButton_Previews: PreviewProvider {
    static var previews: some View {
        StatebleButton(title: "Text", isEnable: true, action: {})
    }
}
