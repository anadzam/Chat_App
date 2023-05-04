//
//  SenderBubble.swift
//  Chat_App
//
//  Created by Ana Dzamelashvili on 4/30/23.
//

import Foundation


import UIKit
 
class RightBubble: UIView {
    
    //    let date = Date()
    //    let dateFormatter = DateFormatter()
    //    dateFormatter.dateFormat = "MM-dd HH:mm:ss"
    //    let dateString = dateFormatter.string(from: date)
    
    
    override func draw(_ rect: CGRect) {
        
        let mainTextBubble = UIBezierPath(roundedRect: CGRect(x: frame.minX, y: frame.minY, width: 200, height: 100), cornerRadius: 25)
        UIColor.bubbleColor.setFill()
        mainTextBubble.fill()
        
        let firstBubble = UIBezierPath(ovalIn: CGRect(x: frame.minX + mainTextBubble.bounds.width - 10, y: frame.minY + mainTextBubble.bounds.height - 15, width: 20, height: 20))
        UIColor.bubbleColor.setFill()
        firstBubble.fill()
        
        let secondBubble = UIBezierPath(ovalIn: CGRect(x: frame.minX + mainTextBubble.bounds.width + 10, y: frame.minY + mainTextBubble.bounds.height, width: 10, height: 10))
        UIColor.bubbleColor.setFill()
        secondBubble.fill()
    }
    

   
}

