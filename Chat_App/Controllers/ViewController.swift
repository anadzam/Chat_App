//
//  ViewController.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/18/23.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var switchButton = SwitchButton()
    private lazy var topChatView = ChatView()
    private lazy var bottomChatView = ChatView()
    
    //MARK: - Yellow center line
    let centerLine: UIView = {
        let line = UIView()
        line.backgroundColor = Constants.Colors.centreLineColor
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(topChatView)
        view.addSubview(centerLine)
        view.addSubview(switchButton)
        view.addSubview(bottomChatView)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        topChatView.translatesAutoresizingMaskIntoConstraints = false
        bottomChatView.translatesAutoresizingMaskIntoConstraints = false
        constraintsAssigner()
       
    }
    
  
    //MARK: - change background color
    @objc private func didTapButton() {
        view.backgroundColor = switchButton.isOn ? Constants.Colors.darkMode : .white
       
    }

    
    //MARK: - set up constraints
    private func constraintsAssigner() {
        NSLayoutConstraint.activate([
            centerLine.heightAnchor.constraint(equalToConstant: Constants.CenterLine.height),
            centerLine.leftAnchor.constraint(equalTo: view.leftAnchor),
            centerLine.rightAnchor.constraint(equalTo: view.rightAnchor),
            centerLine.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                                constant: Constants.CenterLine.height)
        ])
        
        NSLayoutConstraint.activate([
            topChatView.topAnchor.constraint(equalTo: view.topAnchor,
                                             constant: Constants.TopChatView.top),
            topChatView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            topChatView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            topChatView.bottomAnchor.constraint(equalTo: centerLine.topAnchor,
                                                constant: -Constants.TopChatView.bottom)
            
        ])
        NSLayoutConstraint.activate([
            bottomChatView.topAnchor.constraint(equalTo: centerLine.bottomAnchor,
                                                constant: Constants.BottomChatView.top),
            bottomChatView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            bottomChatView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            bottomChatView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                   constant: -Constants.BottomChatView.bottom)
            
        ])
        NSLayoutConstraint.activate([
            switchButton.topAnchor.constraint(equalTo: view.topAnchor,
                                              constant: Constants.SwitchButton.top),
            switchButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                constant: -Constants.SwitchButton.right)
            
        ])
        
    }
}

