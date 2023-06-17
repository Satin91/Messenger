//
//  ImageFromData.swift
//  Messenger
//
//  Created by Артур Кулик on 17.06.2023.
//

import SwiftUI

extension Image {
    init(placeholder: String, data: Data?) {
        print("Init Image with data INIT \(data)")
        guard let data = data, let uiimage = UIImage(data: data) else {
            self.init(placeholder)
            print("Init Image with failure")
            return
        }
        print("Init Image with Success")
        self.init(uiImage: uiimage)
    }
}

