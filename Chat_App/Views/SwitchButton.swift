//
//  SwitchButton.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/20/23.
//

import Foundation
import UIKit

class SwitchButton: UIButton {
    var chatView = ChatView()
    
    
     var isOn: Bool = false {
        didSet {
            self.update()
        }
    }
    
    enum IsOnMode {
        static let onImage = UIImage(assetIdentifier: .lightMode)
        static let offImage = UIImage(assetIdentifier: .darkMode)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setStatus(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        UIView.transition(with: self, duration: 0.10, options: .transitionCrossDissolve, animations: {
            self.isOn ? self.setImage(IsOnMode.onImage, for: .normal) : self.setImage(IsOnMode.offImage, for: .normal)
        }, completion: nil)
        
        
    }
    private func toggle() {
        self.isOn ? self.setStatus(false) : self.setStatus(true)
    }
    
    func setStatus(_ status: Bool) {
        self.isOn = status
        //need to change with delegate
//        if let parentView = self.superview {
//            parentView.backgroundColor = self.isOn ? .white : .darkMode
//        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.sendHapticFeedback()
        self.toggle()
    }
    
    func sendHapticFeedback() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    
    
}
