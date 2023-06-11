//
//  ContentView.swift
//  Messenger
//
//  Created by Артур Кулик on 08.06.2023.
//

import SwiftUI
import Combine

struct MainScreenView: View {
    let service = NetworkService()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .font(Fonts.makeFont(weight: .bold, size: 40))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
