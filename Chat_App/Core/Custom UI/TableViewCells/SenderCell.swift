//
//  SenderCell.swift
//  Chat_App
//
//  Created by Ana Dzamelashvili on 5/29/23.
//

import Foundation
import UIKit

class SenderCell: UITableViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        //        label.textColor = Constant.textColor
        label.numberOfLines = .zero
        label.font = Constants.TextView.font
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constant.labelFont
        label.textColor = Constants.Colors.placeholderColor
        return label
    }()
    
    private let bigBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = Bubble.radius
        bubble.backgroundColor = Constant.bubbleColor
        return bubble
    }()
    
    private let mediumBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = MiddleBubble.radius
        bubble.backgroundColor = Constant.bubbleColor
        return bubble
    }()
    
    private let smallBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = SmallBubble.radius
        bubble.backgroundColor = Constant.bubbleColor
        return bubble
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bigBubble.addSubview(label)
        selectionStyle = .none
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUp() {
        backgroundColor = .clear
        setUpBubble()
        setUpLayoutConstraints()
    }
    
    private func setUpBubble() {
        contentView.addSubview(bigBubble)
        contentView.addSubview(mediumBubble)
        contentView.addSubview(smallBubble)
        contentView.addSubview(dateLabel)
    }
    
    func configure(with message: MessageEntity) {
        label.text = message.text
        dateLabel.text = message.date
        label.textColor = message.failedToSend ? Constant.failedTextColor : Constant.textColor
        dateLabel.textColor = message.failedToSend ? .red : Constants.Colors.placeholderColor
        
    }
    
    private func setUpLayoutConstraints() {
        setUpBigBubbleConstraints()
        setUpLabelConstraints()
        setUpMediumBubbleConstraints()
        setUpSmallBubbleConstraints()
        setUpDateLabelConstraints()
    }
    
    private func setUpBigBubbleConstraints() {
        bigBubble.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bigBubble.topAnchor.constraint(equalTo: contentView.topAnchor),
            bigBubble.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor,
                                                constant: -Bubble.leading)
        ])
    }
    
    private func setUpLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: bigBubble.topAnchor,
                                       constant: Label.top),
            label.leadingAnchor.constraint(equalTo: bigBubble.leadingAnchor,
                                           constant: Label.leading),
            label.trailingAnchor.constraint(equalTo: bigBubble.trailingAnchor,
                                            constant: -Label.trailing),
            label.bottomAnchor.constraint(equalTo: bigBubble.bottomAnchor,
                                          constant: -Label.bottom)
        ])
    }
    
    private func setUpMediumBubbleConstraints() {
        mediumBubble.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mediumBubble.trailingAnchor.constraint(equalTo: bigBubble.trailingAnchor,
                                                   constant: MiddleBubble.leading),
            mediumBubble.bottomAnchor.constraint(equalTo: bigBubble.bottomAnchor,
                                                 constant: MiddleBubble.bottom),
            mediumBubble.widthAnchor.constraint(equalToConstant: MiddleBubble.width),
            mediumBubble.heightAnchor.constraint(equalToConstant: MiddleBubble.height)
        ])
    }
    
    private func setUpSmallBubbleConstraints() {
        smallBubble.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            smallBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                  constant: .zero),
            smallBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                constant: -SmallBubble.bottom),
            smallBubble.widthAnchor.constraint(equalToConstant: SmallBubble.width),
            smallBubble.heightAnchor.constraint(equalToConstant: SmallBubble.height),
        ])
    }
    
    private func setUpDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: bigBubble.bottomAnchor,
                                           constant: DateLabel.top),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -DateLabel.leading),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -DateLabel.bottom)
        ])
    }
    
}
