//
//  UIColor+Extensions.swift
//  Chat_App
//
//  Created by Ana Dzamelashvili on 4/23/23.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    static let placeholderColor = UIColor(r: 199.0, g: 199.0, b: 199.0)
    static let borderColor = UIColor(r: 159.0, g: 96.0, b: 225.0)
    static let darkMode = UIColor(r: 22, g: 0, b: 57)
    
}
