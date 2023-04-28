//
//  TopView.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/19/23.
//

import Foundation
import UIKit

class ChatView: UIView, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    var sentMessages = [String]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var textView: UITextView = {
        let text = UITextView()
        text.layer.borderWidth = 1.0
        text.layer.borderColor = UIColor.borderColor.cgColor
        text.layer.cornerRadius = 23
        text.clipsToBounds = true
        text.font = UIFont.systemFont(ofSize: 16)
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        text.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 70)
        
        return text
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(assetIdentifier: .sendButton)
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //in progress
    @objc private func sendMessage(sender: UIButton) {
        let messageText = textView.text ?? ""
        sentMessages.append(messageText)
        textView.text = ""
        saveItems()
        print("message sent")
        print(sentMessages.count)
    }
    
    //MARK: - TableView Data Manipulation method
    func saveItems() {
        do {
            try context.save()
            
        } catch {
            print("Error saving context \(error)")
            
        }
        tableView.reloadData()
    }
    
    //MARK: - textView custom placeholder
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderColor {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "დაწერეთ შეტყობინება"
            textView.textColor = UIColor.placeholderColor
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.separatorStyle = .none
        textViewDidBeginEditing(textView)
        textViewDidEndEditing(textView)
        textView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        layoutUI()
        //custom logic goes here
    }
    
    private func layoutUI() {
        addSubview(stackView)
        addSubview(sendButton)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(textView)
        setUpConstraints()
    }
    
    //MARK: - set up stackView and its components contraints
    func setUpConstraints() {
        let stackGap: CGFloat = 20
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: stackGap + 30),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: stackGap),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -stackGap),
            stackView.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            //          have to consider one more time
            //          tableView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 2),
            //          tableView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 2),
            tableView.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 2),
            textView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 2),
            textView.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: 100),
            textView.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor,constant: -16),
            sendButton.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            sendButton.widthAnchor.constraint(equalToConstant: 32),
            sendButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    //MARK: - tableView datasource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sentMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textAlignment = .right
        cell.textLabel?.text = sentMessages[indexPath.row]
        return cell
        
    }
    
}

