//
//  SendAuthCodeResponse.swift
//  Messenger
//
//  Created by Артур Кулик on 09.06.2023.
//

import Foundation

struct SendAuthCodeResponse: Codable {
    var is_success: Bool
    
    enum CodingKeys: CodingKey {
        case is_success
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.is_success = try container.decode(Bool.self, forKey: .is_success)
    }
}
