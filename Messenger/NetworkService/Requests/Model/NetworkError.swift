//
//  NetworkError.swift
//  Messenger
//
//  Created by Артур Кулик on 09.06.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noNetworkConnection
    case imageDeserialization
    case httpBodySerialization
}

extension NetworkError {
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noNetworkConnection:
            return "No network connection "
        case .imageDeserialization:
            return "Failed to deserialize image"
        case .httpBodySerialization:
            return "Failed to serialize data"
        }
    }
}
