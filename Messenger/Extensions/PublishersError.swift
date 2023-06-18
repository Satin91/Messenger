//
//  PublishersError.swift
//  Messenger
//
//  Created by Артур Кулик on 18.06.2023.
//

import Combine

extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}
