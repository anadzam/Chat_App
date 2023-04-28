//
//  ViewController.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/18/23.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    var switchButton = SwitchButton()
    
    let chatView = ChatView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chatView)
        view.addSubview(centerLine)
        centerLineConstraints()
        //nslayout
        switchButton = SwitchButton(frame: CGRect(x: self.view.frame.width / 2 + 70,
                                                  y: self.view.frame.height / 2 - 380,
                                                  width: 160,
                                                  height: 70))
        self.view.addSubview(switchButton)
        
    }
    
    
    
    //MARK: - Yellow center line
    let centerLine: UIImageView = {
        let centerLineImage = UIImageView()
        centerLineImage.image = UIImage(assetIdentifier: .centerLine)
        centerLineImage.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
        return centerLineImage
    }()
    
    //change func name
    private func centerLineConstraints() {
        centerLine.heightAnchor.constraint(equalToConstant: 6).isActive = true
        centerLine.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        centerLine.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        centerLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerLine.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 6).isActive = true
    }
}

