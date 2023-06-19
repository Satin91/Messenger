//
//  NavigationBarButton.swift
//  Messenger
//
//  Created by Артур Кулик on 19.06.2023.
//

import SwiftUI

struct NavigationBarButton: View {
    var body: some View {
        content
    }
    
    var action: () -> Void
    
    var content: some View {
        button
    }
    
    var button: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 5)
        }

    }
}

struct NavigationBarButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarButton(action: {})
    }
}
