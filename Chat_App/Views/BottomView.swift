//
//  BottomView.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/19/23.
//

import Foundation
import UIKit

class BottomView: UIView {
    
    
    internal var sendButton: UIButton {
        
        let sendButton = UIButton(type: .custom)
        sendButton.setImage(UIImage(named: "sendButton"), for: .normal)
        sendButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        sendButton.frame = CGRect(x: CGFloat(22.67), y: CGFloat(309.67), width: CGFloat(11.73), height: CGFloat(10.67))
        //        sendButton.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        return sendButton
    }
    
    //    @IBAction func refresh(_ sender: Any) {
    //    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
        
    }()
    
    private let textField: UITextField = {
        
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 28
        textField.textColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.borderColor.cgColor
        
        let myTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 343, height: 56))
        
        
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "დაწერე შეტყობინება ...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        )
        
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 12,
                                                  height: 0))
        textField.leftViewMode = .always
        //emailField.backgroundColor = .white
        return textField
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.rightView = self.sendButton
        textField.rightViewMode = .always
        addSubview(textField)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = bounds
        
        scrollView.frame = bounds
        let size = scrollView.width/3
        
        
        textField.frame = CGRect(x: 16,
                                 y: 300,
                                 width: scrollView.width - 32,
                                 height: 56)
    }
    
}
