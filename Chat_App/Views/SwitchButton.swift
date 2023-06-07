//
//  SwitchButton.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/20/23.
//

import Foundation
import UIKit

class SwitchButton: UIButton {
    
    var isOn: Bool = false {
        didSet {
            update()
        }
    }
    
    enum IsOnMode {
        static let onImage = UIImage(assetIdentifier: .lightMode)
        static let offImage = UIImage(assetIdentifier: .darkMode)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(IsOnMode.onImage, for: .normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        UIView.transition(with: self, duration: 0.10, options: .transitionCrossDissolve, animations: {
            self.isOn ? self.setImage(IsOnMode.onImage, for: .normal) : self.setImage(IsOnMode.offImage, for: .normal)
        }, completion: nil)
        print(self.isOn)
        
    }
    private func toggle() {
        isOn.toggle()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        toggle()
    }
    
    
}
