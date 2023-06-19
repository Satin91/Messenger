//
//  NavigationBarButton.swift
//  Messenger
//
//  Created by Артур Кулик on 19.06.2023.
//

import SwiftUI

struct NavigationBarButton: View {
    
    var action: () -> Void
    
    var body: some View {
        content
    }
    
    var imageSystemName: String
    
    var content: some View {
        button
    }
    
    var button: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageSystemName)
                .foregroundColor(Colors.dark)
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
        NavigationBarButton(action: {}, imageSystemName: "arrow.right")
    }
}
