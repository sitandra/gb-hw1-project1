//
//  Constants.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 09.08.2023.
//
import Foundation
import UIKit

enum Constants {
    enum Indentifiers {
        static let photoViewCell = "PhotoCell"
        static let friendViewCell = "FriendCell"
        static let groupViewCell = "GroupCell"
    }
    
    enum Views {
        enum Detector {
            static let width: CGFloat = 10
            static let offlineColor: UIColor = .systemGray
            static let onlineColor: UIColor = .systemGreen
        }
        enum Icon {
            static let width: CGFloat = 50
        }
    }
    
    enum Offset {
        
        enum TableViewCell {
            static let circleW: CGFloat = 50
        }
        enum CollectionViewCell{
            
        }
    }
}
