//
//  NavigationBarView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

final class Containers {
    var leftContainer = AnyView(EmptyView())
    var rightContainer = AnyView(EmptyView())
    var centralContainer = AnyView(EmptyView())
}

struct NavigationBar: View {
    private var containers = Containers()
    private var leadingSize: CGFloat = .zero
    private var trailingSize: CGFloat = .zero
    private var centerSize: CGFloat = .zero
    
    var body: some View {
        ZStack {
            containers.leftContainer
                .frame(maxWidth: .infinity, alignment: .leading)
            containers.rightContainer
                .frame(maxWidth: .infinity, alignment: .trailing)
            containers.centralContainer
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    func addLeftContainer(_ container: () -> any View) -> NavigationBar {
        containers.leftContainer = AnyView(container())
        return self
    }
    func addRightContainer(_ container: () -> any View) -> NavigationBar {
        containers.rightContainer = AnyView(container())
        return self
    }
    func addCentralContainer(_ container: () -> any View) -> NavigationBar {
        containers.centralContainer = AnyView(container())
        return self
    }
}
