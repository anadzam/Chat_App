//
//  TableViewCell+Extensions.swift

//  Created by Ana Dzamelashvili on 5/18/23.
//

import Foundation
import UIKit

extension ReceiverCell {
    
    enum Constant {
        static let labelFont: UIFont = .systemFont(ofSize: 8)
        static let placeholderColor = UIColor(hex: 0xC7C7C7)
        static let bubbleColor = UIColor(hex: 0xF1F1F1)
        static let textColor = UIColor(hex: 0x191919)
        static let failedTextColor = UIColor(hex: 0x676767)
        
    }
    enum Bubble {
        static let radius: CGFloat = 25
        static let leading: CGFloat = 14
        static let labelFont: UIFont = .systemFont(ofSize: 16)
        static let trailing: CGFloat = 14
    }
    enum Label {
        static let top: CGFloat = 16
        static let leading: CGFloat = 12
        static let trailing: CGFloat = 12
        static let bottom: CGFloat = 16
        
    }
    enum DateLabel {
        static let top: CGFloat = 10
        static let leading: CGFloat = 40
        static let trailing: CGFloat = 12
        static let bottom: CGFloat = 16
        
    }
    enum MiddleBubble {
        static let radius: CGFloat = 12
        static let leading: CGFloat = 2
        static let bottom: CGFloat = 5
        static let width: CGFloat = 24
        static let height: CGFloat = 24
    }
    enum SmallBubble {
        static let radius: CGFloat = 6
        static let bottom: CGFloat = 20
        static let width: CGFloat = 12
        static let height: CGFloat = 12
        
        
    }
}
