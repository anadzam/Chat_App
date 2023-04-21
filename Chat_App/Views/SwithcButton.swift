//
//  SwitchButton.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/20/23.
//

import Foundation
import CoreMotion
import UIKit

class SwitchButton: UIButton {
  var view = TopView()

    var status: Bool = false {
        didSet {
            self.update()
        }
    }
    var onImage = UIImage(named: "lightMode")
    var offImage = UIImage(named: "darkMode")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setStatus(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        UIView.transition(with: self, duration: 0.10, options: .transitionCrossDissolve, animations: {
            self.status ? self.setImage(self.onImage, for: .normal) : self.setImage(self.offImage, for: .normal)
        }, completion: nil)
        
       
    }
    func toggle() {
        self.status ? self.setStatus(false) : self.setStatus(true)
       
//        let status = switchButton.status
               
//                   if status == true {
//                       self.view.backgroundColor = UIColor.darkMode
//                   } else {
//                       self.view.backgroundColor = UIColor.white
//                   }
//               print("toggle tapped")
//
    }
   
    
    func setStatus(_ status: Bool) {
        self.status = status
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
