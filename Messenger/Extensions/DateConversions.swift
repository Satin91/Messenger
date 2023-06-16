//
//  DateExtensions.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import Foundation


extension String {
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date
    }
}

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let string = dateFormatter.string(from: self)
        return string
    }
}
