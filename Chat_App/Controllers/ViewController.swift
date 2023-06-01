//
//  ViewController.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/18/23.
//

import UIKit

class ViewController: UIViewController, SendMessageDelegate {
  
    
    //MARK: - Properties
    private let switchButton = SwitchButton()
    private lazy var topChatView = ChatView()
    private lazy var bottomChatView = ChatView()
    private let viewModel = ChatViewModel()
    private let textView = TextView()
    private lazy var currentDate = Date()
    private lazy var formattedDate = DateFormatter.formatCustomDate(currentDate)
    
    let centerLine: UIView = {
        let line = UIView()
        line.backgroundColor = Constants.Colors.centreLineColor
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        setUpLayout()
        constraintsAssigner()
        viewModel.delegate = self
        viewModel.loadMessages()
        scrollToBottom()
//        viewModel.removeMessages()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        topChatView.sendMessageDelegate = self
        bottomChatView.sendMessageDelegate = self
      
    }
    
    //MARK: - Functions
    private func setUpLayout() {
        topChatView.viewModel = viewModel
        bottomChatView.viewModel = viewModel
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        topChatView.translatesAutoresizingMaskIntoConstraints = false
        bottomChatView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topChatView)
        view.addSubview(centerLine)
        view.addSubview(switchButton)
        view.addSubview(bottomChatView)
    }
    
    
    //MARK: - Change background color
    @objc private func didTapButton() {
        view.backgroundColor = switchButton.isOn ? Constants.Colors.darkMode : .white
        let chatViews = [topChatView, bottomChatView]
        chatViews.forEach { chatView in
            chatView.changeTextColor(color: switchButton.isOn ? Constants.Colors.darkModeTextColor : Constants.Colors.textColor)
        }
        
    }
    

    func sendButton(sender: UIButton) {
        let firstTextField = topChatView.typingArea.textView
        let secondTextField = bottomChatView.typingArea.textView

        if firstTextField.isFirstResponder {
            guard let text = firstTextField.text else { return }
    
            viewModel.sendMessages(with: text, userId: 1, date: formattedDate, failedToSend: !NetworkManager.shared.isConnected)
            firstTextField.text = ""

            
        } else if secondTextField.isFirstResponder {
            guard let text = secondTextField.text else { return }
            viewModel.sendMessages(with: text, userId: 2, date: formattedDate, failedToSend: !NetworkManager.shared.isConnected)
            secondTextField.text = ""
        }
    }
    
    func scrollToBottom() {
        guard viewModel.numberOfMessages() > 1 else { return }
            let indexPath = IndexPath(item: viewModel.numberOfMessages()-1, section: 0)
            topChatView.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            bottomChatView.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
    
    
    //MARK: - Set up constraints
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

//MARK: - ChatViewModelDelegate
extension ViewController: ChatViewModelDelegate {
    func messagesLoaded() {
        topChatView.tableView.reloadData()
        bottomChatView.tableView.reloadData()
        scrollToBottom()
       
    }
}
