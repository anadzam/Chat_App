//
//  File.swift
//  Chat_App
//
//  Created by Ana Dzamelashvili on 5/4/23.
//

import Foundation
import UIKit

enum Constants {
    
    enum TextViewCon {
        static let trailing: CGFloat = 2
        static let height: CGFloat = 50
        static let bottom: CGFloat = 100
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 23
        static let fontSize: CGFloat = 16
        static let placeholder: String = "დაწერეთ შეტყობინება"
    }
    
    enum SendButtonCon {
        static let trailing: CGFloat = 16
        static let top: CGFloat = 8
    }
    
    enum TableView {
        static let top: CGFloat = 50
        static let height: CGFloat = 300
    }
    
    enum AssetIdentifier: String {
        case lightMode
        case darkMode
        case sendButton
        case centerLine = "rectangle"
        
    }
    
    enum Colors {
        static let placeholderColor = UIColor(r: 199.0, g: 199.0, b: 199.0)
        static let borderColor = UIColor(r: 159.0, g: 96.0, b: 225.0)
        static let darkMode = UIColor(r: 22, g: 0, b: 57)
        static let bubbleColor = UIColor(r: 218, g: 194, b: 255)
        static let textColor = UIColor(r: 25, g: 25, b: 25)
        static let centreLineColor = UIColor(r: 247, g: 206, b: 127)
    }
    
    enum CenterLine {
        static let height: CGFloat = 6
    }
    
    enum TopChatView {
        static let top: CGFloat = 75
        static let bottom: CGFloat = 5
    }
    
    enum BottomChatView {
        static let top: CGFloat = 5
        static let bottom: CGFloat = 10
    }
    
    enum SwitchButton {
        static let top: CGFloat = 50
        static let right: CGFloat = 12
    }
    enum StackView {
        static let spacing: CGFloat = 12
        static let gap: CGFloat = 20
    }
    
    
}
