//
//  StatebleButtonView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct StatebleButton: View {
    enum State {
        case disable
        case enable
    }
    
    var title: String
    var state: State
    var action: () -> Void
    var body: some View {
        content
    }
    
    var content: some View {
        button
            .onTapGesture {
                if state == .enable {
                    action()
                }
            }
    }
    
    
    var button: some View {
        RoundedRectangle(cornerRadius: Spacing.smallRadius, style: .continuous)
            .foregroundColor(state == .disable ? Colors.neutral : Colors.primary)
            .frame(height: Spacing.mediumControl)
            .overlay {
                Text(title)
                    .font(Fonts.makeFont(weight: .bold, size: 18))
                    .foregroundColor(Colors.light)
            }
    }
}

struct StatebleButton_Previews: PreviewProvider {
    static var previews: some View {
        StatebleButton(title: "Text", state: .enable, action: {})
    }
}
