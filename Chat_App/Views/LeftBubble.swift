//
//  ReciverBubble.swift
//  Chat_App
//
//  Created by Ana Dzamelashvili on 4/30/23.
//

import Foundation
import UIKit

//    let date = Date()
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "MM-dd HH:mm:ss"
//    let dateString = dateFormatter.string(from: date)

class LeftBubble: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let mainTextBubble = UIBezierPath(roundedRect: CGRect(x: 32, y: frame.minY, width: 200, height: 150), cornerRadius: 25)
        Constants.Colors.bubbleColor.setFill()
        mainTextBubble.fill()
        
        let firstBubble = UIBezierPath(ovalIn: CGRect(x: mainTextBubble.bounds.minX - 5, y: mainTextBubble.bounds.maxY - 18, width: 20, height: 20))
        Constants.Colors.bubbleColor.setFill()
        firstBubble.fill()
        
        let secondBubble = UIBezierPath(ovalIn: CGRect(x: mainTextBubble.bounds.minX - 16, y: mainTextBubble.bounds.maxY - 3, width: 10, height: 10))
        Constants.Colors.bubbleColor.setFill()
        secondBubble.fill()
        
    }
    
    
}

