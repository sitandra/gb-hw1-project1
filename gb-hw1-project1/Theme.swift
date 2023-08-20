//
//  Theme.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 20.08.2023.
//

import UIKit

protocol AppTheme {
    var backgroundColor: UIColor { get }
}

final class Theme {
    static var currentTheme: AppTheme = WhiteTheme()
    
    static func drawDate(date: Date?) -> String {
        if date == nil { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date!)
    }
}

final class WhiteTheme: AppTheme {
    var backgroundColor: UIColor = .white
}

final class BlueTheme: AppTheme {
    var backgroundColor: UIColor = UIColor(red: 228/255, green: 231/255, blue: 1, alpha: 1)
}

final class GreenTheme: AppTheme {
    var backgroundColor: UIColor = UIColor(red: 206/255, green: 1, blue: 162/255, alpha: 1)
}
