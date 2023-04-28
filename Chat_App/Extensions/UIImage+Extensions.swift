//
//  UIImage+Extensions.swift
//  chat
//
//  Created by Ana Dzamelashvili on 4/27/23.
//

import Foundation
import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case lightMode
        case darkMode
        case sendButton
        case centerLine = "Rectangle"
        
    }
    convenience init(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)!
    }
}
