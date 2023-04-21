//
//  Extension.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/19/23.
//

import UIKit

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}

//extension UIColor {
//    static let placeholderColor = UIColor(red: 199.0, green: 199.0, blue: 199.0, alpha: 1.0)
//    static let borderColor = UIColor(red: 159.0, green: 96.0, blue: 225.0, alpha: 1.0)
//
//
//}


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    static let placeholderColor = UIColor(r: 199.0, g: 199.0, b: 199.0)
    static let borderColor = UIColor(r: 159.0, g: 96.0, b: 225.0)
    static let darkMode = UIColor(r: 22, g: 0, b: 57)
}
