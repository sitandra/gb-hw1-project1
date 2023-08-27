//
//  Theme.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 20.08.2023.
//

import UIKit

protocol AppTheme {
    var type: AllAppTheme { get set }
    var backgroundColor: UIColor { get }
    
}
enum AllAppTheme: String {
    case white = "white"
    case blue = "blue"
    case green = "green"
}

final class Theme {
    static var currentTheme: AppTheme = WhiteTheme()
}

final class WhiteTheme: AppTheme {
    var type: AllAppTheme = .white
    var backgroundColor: UIColor = .white
}

final class BlueTheme: AppTheme {
    var type: AllAppTheme = .blue
    var backgroundColor: UIColor = UIColor(red: 228/255, green: 231/255, blue: 1, alpha: 1)
}

final class GreenTheme: AppTheme {
    var type: AllAppTheme = .green
    var backgroundColor: UIColor = UIColor(red: 206/255, green: 1, blue: 162/255, alpha: 1)
}
