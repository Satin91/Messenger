//
//  PublishersError.swift
//  Messenger
//
//  Created by Артур Кулик on 18.06.2023.
//

import Combine

/// Расширение позволяет получить доступ к ошибке без вызова оператора switch в медоте .sink
extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}
