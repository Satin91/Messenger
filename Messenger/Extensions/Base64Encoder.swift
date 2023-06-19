//
//  Base64Encoder.swift
//  Messenger
//
//  Created by Артур Кулик on 19.06.2023.
//

import Foundation
import UIKit

extension Data {
    var base64image: String {
        guard let image = UIImage(data: self), let imageData = image.pngData() else {
            return ""
        }
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
        return base64String
    }
}
