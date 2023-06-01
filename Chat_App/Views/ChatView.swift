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
    var viewModel = ChatViewModel()
    weak var sendMessageDelegate: SendMessageDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.StackView.spacing
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStackView()
        setUpConstraints()
        configureTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        typingArea.translatesAutoresizingMaskIntoConstraints = false
        typingArea.delegate = self
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.StackView.gap),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.StackView.gap),
            stackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: typingArea.topAnchor)
        ])
        NSLayoutConstraint.activate([
            typingArea.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: Constants.TextView.bottom),
        ])
    }
}

//MARK: - UITableViewDataSource
extension ChatView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMessages()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.message(at: indexPath.row)
        
        if message.userId == 1 {
            let sender = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.SenderCellReuseIdentifier, for: indexPath) as! SenderCell
            sender.configure(with: message)
            return sender
        } else if message.userId == 2 {
            let receiver = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.RecieverCellReuseIdentifier, for: indexPath) as! ReceiverCell
            receiver.configure(with: message)
            return receiver
        }
        return UITableViewCell()
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
