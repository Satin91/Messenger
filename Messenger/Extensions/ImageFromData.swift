//
//  ImageFromData.swift
//  Messenger
//
//  Created by Артур Кулик on 17.06.2023.
//

import SwiftUI

extension Image {
    init(placeholder: String, data: Data?) {
        guard let data = data, let uiimage = UIImage(data: data) else {
            self.init(placeholder)
            return
        }
        self.init(uiImage: uiimage)
    }
}

