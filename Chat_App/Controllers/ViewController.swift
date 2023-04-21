//
//  ViewController.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/18/23.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    var textField = TopView()
    var switchButton = SwitchButton()
    var topView = TopView()
    var topSendButton = TopView()
    
    
    
    //    init(switchButton: UIButton) {
    //            self.switchButton = switchButton
    //            super.init(nibName: nil, bundle: nil)
    //        }
    //
    //        /// This is in case the View Controller is loaded from the Storyboard
    //        required init?(coder: NSCoder) {
    //            fatalError("init(coder:) has not been implemented")
    //        }
    
    
    //    let status = switchButton.status
    //
    //    if status == true {
    //        self.view.backgroundColor = UIColor.darkMode.cgColor()
    //    } else {
    //        self.view.backgroundColor = UIColor.white.cgColor()
    //    }
    
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        switchButton.update()
        
        view.addSubview(scrollView)
        textField = TopView(frame: CGRect(x: 0, y: 0, width: 343, height: 56))
        
        textField.isUserInteractionEnabled = true
        
        self.view.addSubview(textField)
        scrollView.addSubview(topSendButton)
        
        
        
        switchButton = SwitchButton(frame: CGRect(x: self.view.frame.width/2 + 70, y: self.view.frame.height/2-380, width: 160, height: 70))
        self.view.addSubview(switchButton)
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    
    @objc func didToggleButton(_ sender: SwitchButton) {
        if sender.status == true {
            view.backgroundColor = .systemPink
        } else {
            view.backgroundColor = .white
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        
    }
    
    
}

//func textFieldDidBeginEditing(textField: UITextField!) {
//    print("clicked")
//
//}
//func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
//  textField.resignFirstResponder()
//
//    return true
//}
