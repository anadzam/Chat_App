//
//  UIImage+Extensions.swift
//  chat
//
//  Created by Ana Dzamelashvili on 4/27/23.
//

import Foundation
import UIKit

extension UIImage {
  
    convenience init(assetIdentifier: Constants.AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)!
    }
}
