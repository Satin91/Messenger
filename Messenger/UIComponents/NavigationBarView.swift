//
//  NavigationBarView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct NavigationBarView: View {
    enum NavBarType {
        case large
        case `default`
    }
    
    var title: String
    
    var type: NavBarType = .default
    
    var body: some View {
        content
            .background(Color.clear)
    }
    
    @ViewBuilder private var content: some View {
        switch type {
        case .large:
            largeNavBar
        case .default:
            defaultNavBar
        }
    }
    
    private var largeNavBar: some View {
        HStack {
            Text(title)
                .font(Fonts.makeFont(weight: .bold, size: 40))
                .foregroundColor(Colors.dark)
            Spacer()
        }
    }
    
    private var defaultNavBar: some View {
        ZStack {
            EmptyView()
        }
    }
}
