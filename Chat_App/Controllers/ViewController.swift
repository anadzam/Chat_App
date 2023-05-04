//
//  ViewController.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/18/23.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    var switchButton = SwitchButton()
    let topChatView = ChatView()
    let bottomChatView = ChatView()
    
    
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
    @objc func didTapButton() {
        if switchButton.isOn {
            view.backgroundColor = .darkMode
            topChatView.textView.backgroundColor = .darkMode
            bottomChatView.textView.backgroundColor = .darkMode
        } else {
            view.backgroundColor = .white
            topChatView.textView.backgroundColor = .white
            bottomChatView.textView.backgroundColor = .white
        }
    }
    
    
    //MARK: - Yellow center line
    let centerLine: UIImageView = {
        let centerLineImage = UIImageView()
        centerLineImage.image = UIImage(assetIdentifier: .centerLine)
        centerLineImage.translatesAutoresizingMaskIntoConstraints = false
        return centerLineImage
    }()
    
    //MARK: - set up constraints
    private func constraintsAssigner() {
        NSLayoutConstraint.activate([
            centerLine.heightAnchor.constraint(equalToConstant: 6),
            centerLine.leftAnchor.constraint(equalTo: view.leftAnchor),
            centerLine.rightAnchor.constraint(equalTo: view.rightAnchor),
            centerLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerLine.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            topChatView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            topChatView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            topChatView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            topChatView.bottomAnchor.constraint(equalTo: centerLine.safeAreaLayoutGuide.topAnchor, constant: -5)
            
        ])
        NSLayoutConstraint.activate([
            bottomChatView.topAnchor.constraint(equalTo: centerLine.safeAreaLayoutGuide.bottomAnchor, constant: 5),
            bottomChatView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            bottomChatView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            bottomChatView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
        ])
        NSLayoutConstraint.activate([
            switchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            switchButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12)
            
        ])
        
    }
}

