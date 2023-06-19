//
//  NavigationBarButton.swift
//  Messenger
//
//  Created by Артур Кулик on 19.06.2023.
//

import SwiftUI

struct NavigationBarButton: View {
    
    let imageSystemName: String
    let action: () -> Void
    
    var body: some View {
        content
    }
    
    var content: some View {
        button
    }
    
    var button: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageSystemName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Colors.dark)
                .padding()
                .background(
                    Colors.light
                )
                .cornerRadius(Layout.Radius.smallRadius)
                .largeShadowModifier()
        }

    }
}

struct NavigationBarButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarButton(imageSystemName: "arrow.right", action: {})
    }
}
