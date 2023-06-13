//
//  TextView.swift
//  Chat_App
//
//  Created by Ana Dzamelashvili on 5/11/23.
//

import Foundation
import UIKit

protocol ButtonActionDelegate: AnyObject {
    func buttonTapped(sender: UIButton)
}
protocol TextViewDelegate: AnyObject {
    func changeTextColor(color: UIColor)
}

class TextView: UIView {
    
    private let lineHeight: CGFloat = Constants.TextView.font.lineHeight
    private lazy var sendButton = UIButton()
    private lazy var containerView = UIView()
    lazy var textView = UITextView()
    weak var delegate: ButtonActionDelegate?
    weak var textViewDelegate: TextViewDelegate?
    
    
    private let placeholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "დაწერე შეტყობინება..."
        placeholder.font = Constants.TextView.font
        placeholder.sizeToFit()
        
        placeholder.textColor = Constants.Colors.placeholderColor
        
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        return placeholder
    }()
    
    override init(frame:CGRect) {
        super.init(frame: .zero)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSendButton() -> UIButton {
           return sendButton
       }
    private func setUpLayout() {
        addSubview(containerView)
        containerView.addSubview(textView)
        containerView.addSubview(sendButton)
        textView.addSubview(placeholder)
        setUpConstraints()
        setUpButton()
        setUpTextView()
        setUpContainerView()
    }
    
    func changeColor(_ color: UIColor) {
        textView.textColor = color
    }
   
    
    private func setUpTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = Constants.TextView.font
        textView.autocorrectionType = .no
        textView.delegate = self
        textView.clipsToBounds = true
        textView.backgroundColor = .clear
        textView.textColor = Constants.Colors.textColor
        textView.textContainerInset = UIEdgeInsets(top: Constants.TextView.topEdge,
                                                   left: Constants.TextView.leftEdge,
                                                   bottom:  Constants.TextView.topEdge,
                                                   right: Constants.TextView.leftEdge)
        
    }
    
    
    private func setUpContainerView() {
        containerView.layer.borderWidth = Constants.ContainerView.borderWidth
        containerView.layer.borderColor = Constants.Colors.borderColor
        containerView.layer.cornerRadius = Constants.ContainerView.cornerRadius
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setUpButton() {
        sendButton.setImage(UIImage(named: Constants.AssetIdentifier.sendButton.rawValue), for: .normal)
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @objc func sendMessage() {
        delegate?.buttonTapped(sender: sendButton)
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
            textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.TextView.top),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.TextView.bottom),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor)
            
        ])
        NSLayoutConstraint.activate([
            placeholder.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            placeholder.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.TextView.leftEdge)
        ])
        NSLayoutConstraint.activate([
            sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.SendButton.trailing)
        ])
        
    }
}
//MARK: - UITextViewDelegate
extension TextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholder.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholder.isHidden = false
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: .infinity))
        let newHeight = min(newSize.height, Constants.TextView.maxNumberOfLines * lineHeight)
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
