//
//  NetworkService.swift
//  Messenger
//
//  Created by Артур Кулик on 08.06.2023.
//

import Foundation
import Combine

class NetworkService {
    
    func sendAuthCode() {
        let request = try! SendAuthCodeRequest(phone: "+79230464916").make().get()
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                return
            }
            let json =  try! JSONSerialization.jsonObject(with: data)
            print("Debug: Data \(json)")
        }.resume()
    }
}

