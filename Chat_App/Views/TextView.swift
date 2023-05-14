//
//  TextView.swift
//  Chat_App
//
//  Created by Ana Dzamelashvili on 5/11/23.
//

import Foundation
import UIKit


class TextView: UIView {
    
    var lineHeight: CGFloat {
        Constants.TextView.font.lineHeight
    }
    public lazy var sendButton = UIButton()
    private lazy var containerView = UIView()
    public lazy var textView = UITextView()
    
    
    override init(frame:CGRect) {
        super.init(frame: .zero)
        
        //        textViewDidBeginEditing(textView)
        //        textViewDidEndEditing(textView)
        componentArranger()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatal error message
        fatalError("")
    }
    
    private func componentArranger() {
        addSubview(containerView)
        containerView.addSubview(textView)
        containerView.addSubview(sendButton)
        setUpConstraints()
        setUpButton()
        setUpTextView()
        textView.text = Constants.TextView.placeholder
        setUpContainerView()
    }
    
    public func setUpTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = Constants.Colors.textColor
        textView.font = Constants.TextView.font
        textView.autocorrectionType = .no
        textView.delegate = self
        textView.clipsToBounds = true
        textView.backgroundColor = .clear
        textView.textColor = Constants.Colors.placeholderColor
        textView.textContainerInset = UIEdgeInsets(top: Constants.TextView.topEdge,
                                                   left: Constants.TextView.leftEdge,
                                                   bottom:  Constants.TextView.topEdge,
                                                   right: Constants.TextView.leftEdge)
        
    }
    
    
    public func setUpContainerView() {
        containerView.layer.borderWidth = Constants.ContainerView.borderWidth
        containerView.layer.borderColor = Constants.Colors.borderColor
        containerView.layer.cornerRadius = Constants.ContainerView.cornerRadius
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    public func setUpButton() {
        sendButton.setImage(UIImage(named: Constants.AssetIdentifier.sendButton.rawValue), for: .normal)
        //        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Constraints
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: Constants.TextView.height)
        ])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 2),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor)
            
        ])
        NSLayoutConstraint.activate([
            sendButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.SendButton.bottom),
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.SendButton.trailing)
        ])
        
    }
}
//MARK: - TextView delegate methods
extension TextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Constants.Colors.placeholderColor {
            textView.text = ""
            textView.textColor = Constants.Colors.textColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Constants.TextView.placeholder
            textView.textColor = Constants.Colors.placeholderColor
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        let maxNumberOfLines = 6
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: .infinity))
        let newHeight = min(newSize.height, CGFloat(maxNumberOfLines) * lineHeight)
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = newHeight
            }
        }
        containerView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = newHeight
            }
        }
    }
    
}
