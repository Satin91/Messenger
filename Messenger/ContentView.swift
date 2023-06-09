//
//  ContentView.swift
//  Messenger
//
//  Created by Артур Кулик on 08.06.2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var cancelBag = Set<AnyCancellable>()
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
        .onAppear {
            service.sendAuthCode(phone: "+79230464916")
                .sink { error in
                } receiveValue: { response in
                    print(response.is_success)
                }
                .store(in: &cancelBag)
        }
    }
    
    func sendAuthCode(phone: String) -> Future<SendAuthCodeResponse, Never> {
        let request = SendAuthCodeRequest(phone: phone).make
        
        return Future { promise in
            BaseNetworkTask.execute(model: SendAuthCodeResponse.self, request: request)
                .sink { error in
                    switch error {
                    case .failure(_):
                        print("Error")
                    default:
                        break
                    }
                } receiveValue: { response in
                    promise(.success(response))
                }
                .store(in: &self.cancelBag)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
