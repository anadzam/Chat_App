//
//  ViewController.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/18/23.
//

import UIKit

final class ChatViewController: UIViewController, SendMessageDelegate {
    
    //MARK: - Properties
    private let switchButton = SwitchButton()
    //    private lazy var topChatView = ChatView()
    //    private lazy var bottomChatView = ChatView()
    private let viewModel = ChatViewModel()
    private let textView = TextView()
    private lazy var currentDate = Date()
    //    private lazy var chatView = ChatView()
    private lazy var formattedDate = DateFormatter.formatCustomDate(currentDate)
    lazy var topTextView = topChatView.typingArea
    lazy var bottomTextView = bottomChatView.typingArea
    let userDefaults = UserDefaults.standard
    private var messagesArray: [MessageEntity] = []
    
    let centerLine: UIView = {
        let line = UIView()
        line.backgroundColor = Constants.Colors.centreLineColor
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    private lazy var topChatView: ChatView = {
        let topChatView = ChatView()
        topChatView.currentUser = 1
        return topChatView
    }()
    
    private lazy var bottomChatView: ChatView = {
        let bottomChatView = ChatView()
        bottomChatView.currentUser = 2
        return bottomChatView
    }()
    
    
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
        setUpLayout()
        setUpConstraints()
        checkSwithcState()
        addDelegates()
        hideKeyboard()
        //        viewModel.removeMessages()
        viewModel.loadMessages()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        topChatView.scrollToBottom()
        bottomChatView.scrollToBottom()
    }
    
    //MARK: - Functions
    private func setUpLayout() {
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        topChatView.translatesAutoresizingMaskIntoConstraints = false
        bottomChatView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topChatView)
        view.addSubview(centerLine)
        view.addSubview(switchButton)
        view.addSubview(bottomChatView)
    }
    
    private func addDelegates() {
        topChatView.sendMessageDelegate = self
        bottomChatView.sendMessageDelegate = self
        viewModel.delegate = self
    }
    
    
    //MARK: - Change background color
    @objc private func switchButtonTapped() {
        view.backgroundColor = switchButton.isOn ? Constants.Colors.darkMode : .white
        
        let chatViews = [topChatView, bottomChatView]
        chatViews.forEach { chatView in
            chatView.changeTextColor(color: switchButton.isOn ? Constants.Colors.darkModeTextColor : Constants.Colors.textColor)
        }
        
        userDefaults.set(switchButton.isOn ? true : false, forKey: "isOn")
    }
    
    
    
    func sendButton(sender: UIButton) {
        var message: Message
        if sender === topTextView.getSendButton() && !topTextView.textView.text.isEmpty {
            guard let text = topTextView.textView.text else { return }
            message = Message(text: text, userId: 1, date: formattedDate, failedToSend: !NetworkManager.shared.isConnected)
            viewModel.sendMessages(with: message)
            topTextView.textView.text = ""
        } else if sender === bottomTextView.getSendButton() && !bottomTextView.textView.text.isEmpty {
            guard let text = bottomTextView.textView.text else { return }
            message = Message(text: text, userId: 2, date: formattedDate, failedToSend: !NetworkManager.shared.isConnected)
            viewModel.sendMessages(with: message)
            bottomTextView.textView.text = ""
        }
    }
    
    
    private func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    private func checkSwithcState() {
        if userDefaults.bool(forKey: "isOn") {
            switchButton.isOn = false
            view.backgroundColor = Constants.Colors.darkMode
        } else {
            switchButton.isOn = true
            view.backgroundColor = .white
        }
    }
    
    //MARK: - Set up constraints
    private func setUpConstraints() {
        setUpCenterLineConstraints()
        setUpTopChatViewConstraints()
        setUpBottomChatViewConstraints()
        setUpSwitchButtonConstraints()
    }
    private func setUpCenterLineConstraints() {
        NSLayoutConstraint.activate([
            centerLine.heightAnchor.constraint(equalToConstant: Constants.CenterLine.height),
            centerLine.leftAnchor.constraint(equalTo: view.leftAnchor),
            centerLine.rightAnchor.constraint(equalTo: view.rightAnchor),
            centerLine.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                                constant: Constants.CenterLine.height)
        ])
    }
    private func setUpTopChatViewConstraints() {
        NSLayoutConstraint.activate([
            topChatView.topAnchor.constraint(equalTo: view.topAnchor,
                                             constant: Constants.TopChatView.top),
            topChatView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            topChatView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            topChatView.bottomAnchor.constraint(equalTo: centerLine.topAnchor,
                                                constant: -Constants.TopChatView.bottom)
        ])
    }
    private func setUpBottomChatViewConstraints() {
        NSLayoutConstraint.activate([
            bottomChatView.topAnchor.constraint(equalTo: centerLine.bottomAnchor,
                                                constant: Constants.BottomChatView.top),
            bottomChatView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            bottomChatView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            bottomChatView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                   constant: -Constants.BottomChatView.bottom)
        ])
    }
    private func setUpSwitchButtonConstraints() {
        NSLayoutConstraint.activate([
            switchButton.topAnchor.constraint(equalTo: view.topAnchor,
                                              constant: Constants.SwitchButton.top),
            switchButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                constant: -Constants.SwitchButton.right)
        ])
    }
}

//MARK: - ChatViewModelDelegate
extension ChatViewController: ChatViewModelDelegate {
    func messagesLoaded() {
        topChatView.messagesArray = viewModel.filteredMessages(currentUser: 1)
        bottomChatView.messagesArray = viewModel.filteredMessages(currentUser: 2)
        topChatView.tableView.reloadData()
        bottomChatView.tableView.reloadData()
        topChatView.scrollToBottom()
        bottomChatView.scrollToBottom()
        
    }
}


