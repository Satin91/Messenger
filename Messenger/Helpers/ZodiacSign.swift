//
//  ZodiacSign.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import Foundation

extension Date {
    public var zodiac: String {
        guard let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
            else { return "Данные не получены" }
        
        let dateComponents = gregorianCalendar.components([.month, .day], from: self)
        
        let month = dateComponents.month
        let day = dateComponents.day
        
        switch (month!, day!) {
        case (3, 21...31), (4, 1...19):
            return "Овен"
        case (4, 20...30), (5, 1...20):
            return "Телец"
        case (5, 21...31), (6, 1...20):
            return "Близнецы"
        case (6, 21...30), (7, 1...22):
            return "Рак"
        case (7, 23...31), (8, 1...22):
            return "Лев"
        case (8, 23...31), (9, 1...22):
            return "Дева"
        case (9, 23...30), (10, 1...22):
            return "Весы"
        case (10, 23...31), (11, 1...21):
            return "Скорпион"
        case (11, 22...30), (12, 1...21):
            return "Стрелец"
        case (12, 22...31), (1, 1...19):
            return "Козерог"
        case (1, 20...31), (2, 1...18):
            return "Водолей"
        case (2, 19...29), (3, 1...20):
            return "Рыбы"
        default:
            return "Данные не получены"
        }
    }
}
