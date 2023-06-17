//
//  ImageFromData.swift
//  Messenger
//
//  Created by Артур Кулик on 17.06.2023.
//

import SwiftUI

extension Image {
    init(placeholder: String, data: Data?) {
        guard let data = data else {
            self.init(placeholder)
            return
        }
        let uimage = UIImage(data: data)
        self.init(uiImage: uimage ?? UIImage())
    }
}

