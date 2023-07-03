//
//  TopView.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/19/23.
//

import UIKit

protocol SendMessageDelegate: AnyObject {
    func sendButton(sender: UIButton)
}

class ChatView: UIView {
    
    let tableView = UITableView()
    var typingArea = TextView()
    weak var sendMessageDelegate: SendMessageDelegate?
    /// if current user value is 1 it means it it was sent from top chatview
    var currentUser = 1 {
        didSet {
            tableView.reloadData()
        }
    }
    var messagesArray: [MessageEntity] = []
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.StackView.spacing
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setUpStackView()
        setUpConstraints()
        configureTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(ReceiverCell.self, forCellReuseIdentifier: Constants.TableView.RecieverCellReuseIdentifier)
        tableView.register(SenderCell.self, forCellReuseIdentifier: Constants.TableView.SenderCellReuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setUpStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(typingArea)
        typingArea.delegate = self
    }
    
    func scrollToBottom() {
        let numberOfRows = tableView.numberOfRows(inSection: 0)
        guard numberOfRows > 1 else { return }
        let lastIndexPath = IndexPath(row: numberOfRows - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    private func setUpConstraints() {
        setUpTypingAreConstraints()
        setUpStackViewConstraints()
        setUpTableViewConstraint()
    }
    private func setUpTypingAreConstraints() {
        NSLayoutConstraint.activate([
            typingArea.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: Constants.TextView.bottom),
        ])
        typingArea.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setUpStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.StackView.gap),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.StackView.gap),
            stackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setUpTableViewConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: typingArea.topAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource
extension ChatView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messagesArray[indexPath.row]
        if message.userId == currentUser {
            let sender = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.SenderCellReuseIdentifier, for: indexPath) as! SenderCell
            sender.configure(with: message)
            return sender
        } else {
            let receiver = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.RecieverCellReuseIdentifier, for: indexPath) as! ReceiverCell
            receiver.configure(with: message)
            return receiver
        }
    }
}

//MARK: - ButtonActionDelegate
extension ChatView: ButtonActionDelegate {
    func buttonTapped(sender: UIButton) {
        sendMessageDelegate?.sendButton(sender: sender)
    }
    
    func changeTextColor(color: UIColor) {
        typingArea.changeColor(color)
    }
}


