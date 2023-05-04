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
 
    
}
