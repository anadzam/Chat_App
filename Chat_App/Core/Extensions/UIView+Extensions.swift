//
//  Extension.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/19/23.
//

import UIKit

extension UIView {
    
    private var width: CGFloat {
        return frame.size.width
    }
    
    private var height: CGFloat {
        return frame.size.height
    }
    
    private var top: CGFloat {
        return frame.origin.y
    }
    
    private var bottom: CGFloat {
        return frame.size.height + frame.origin.y
    }
    
    private var left: CGFloat {
        return frame.origin.x
    }
    
    private var right: CGFloat {
        return frame.size.width + frame.origin.x
    }
}



