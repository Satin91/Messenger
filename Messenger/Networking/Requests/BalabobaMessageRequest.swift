//
//  BalabobaMessageRequest.swift
//  Messenger
//
//  Created by Артур Кулик on 09.07.2023.
//

import Foundation
import Alamofire

struct BalabobaMessageRequest: NetworkRequestProtocol {
    
    let path = "https://yandex.ru/lab/api/yalm/text3"
    let parameters: [String: Any]
    
    var header: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Origin": "https://yandex.ru",
        "Referer": "https://yandex.ru/"
    ]

    // 0 - обычный собеседник
    // 9 - Синопсис фильмов
    // 8 - позновательно
    
    init(query: String, intro: Int) {
        self.parameters = [
            "filter": 1,
            "intro": intro,
            "query": query
        ]
    }
    
    func make() -> RequestModel {
        return RequestModel(path: path, parameters: parameters, headers: HTTPHeaders(header), method: .post)
    }
}
