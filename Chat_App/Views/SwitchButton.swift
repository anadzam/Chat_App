//
//  SwitchButton.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/20/23.
//

import Foundation
import UIKit

class SwitchButton: UIButton {
 
    private var isOn: Bool = false {
        didSet {
            self.update()
        }
    }

    // enum name caital
    enum isOnMode {
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
            self.isOn ? self.setImage(isOnMode.onImage, for: .normal) : self.setImage(isOnMode.offImage, for: .normal)
        }, completion: nil)
        
        
    }
    private func toggle() {
        self.isOn ? self.setStatus(false) : self.setStatus(true)
    }
    
    func setStatus(_ status: Bool) {
        self.isOn = status
        //
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
