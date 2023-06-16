//
//  OptionalBinding.swift
//  Messenger
//
//  Created by Артур Кулик on 16.06.2023.
//

import Foundation

extension Optional where Wrapped == String {
    var _bound: String? {
        get { return self }
        set { self = newValue }
    }
    
    var bound: String {
        get {
            _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}
extension Optional where Wrapped == Date {
    var _bound: Date? {
        get { return self }
        set { self = newValue }
    }
    
    var bound: Date {
        get {
            _bound ?? Date()
        }
        set {
            _bound = newValue
        }
    }
}
