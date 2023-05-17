//
//  TableViewCell.swift
//  test
//
//  Created by Ana Dzamelashvili on 5/11/23.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    public let label: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.textColor
        label.numberOfLines = 0
        label.font = Constants.TextView.font
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let bubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = 25
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = Constants.Colors.bubbleColor
        return bubble
    }()
    
    private let middleBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = 12
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = Constants.Colors.bubbleColor
        return bubble
    }()
    
    private let smallBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = 6
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = Constants.Colors.bubbleColor
        return bubble
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bubble.addSubview(label)
        selectionStyle = .none
        label.translatesAutoresizingMaskIntoConstraints = false
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    private func setUp() {
        backgroundColor = .clear
        setUpBubble()
        setUpDateLabel()
        setUpLayoutConstraints()
    }
    
    private func setUpBubble() {
        contentView.addSubview(bubble)
        contentView.addSubview(middleBubble)
        contentView.addSubview(smallBubble)
        bubble.translatesAutoresizingMaskIntoConstraints = false
        middleBubble.translatesAutoresizingMaskIntoConstraints = false
        smallBubble.translatesAutoresizingMaskIntoConstraints = false
    }
    
  
    private func setUpDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with text: String) {
        label.text = text
    }
    
    private func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            bubble.topAnchor.constraint(equalTo: contentView.topAnchor),
            bubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            label.topAnchor.constraint(equalTo: bubble.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: bubble.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: bubble.trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: bubble.bottomAnchor, constant: -16),
          
            
            middleBubble.leadingAnchor.constraint(equalTo: bubble.leadingAnchor, constant: -2),
            middleBubble.bottomAnchor.constraint(equalTo: bubble.bottomAnchor, constant: 5),
            middleBubble.widthAnchor.constraint(equalToConstant: 24),
            middleBubble.heightAnchor.constraint(equalToConstant: 24),
            
            smallBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            smallBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            smallBubble.widthAnchor.constraint(equalToConstant: 12),
            smallBubble.heightAnchor.constraint(equalToConstant: 12),
            
            
            dateLabel.topAnchor.constraint(equalTo: bubble.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}


