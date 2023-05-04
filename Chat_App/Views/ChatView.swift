//
//  TopView.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/19/23.
//

import Foundation
import UIKit
import CoreData

class ChatView: UIView, UITextViewDelegate {
    let tableView = UITableView()
    let leftBubble = LeftBubble()
    let rightBubble = RightBubble()
    var sentMessages = [Message]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    public var textView: UITextView = {
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
    
    //MARK: - load messages from coreData
    func loadMessages(with request: NSFetchRequest<Message> = Message.fetchRequest()) {
        //        commented since we have that argument inside the function
        //        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            sentMessages = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    //in progress
    @objc private func sendMessage(sender: UIButton) {
        //        let messageText = textView.text ?? ""
        //        sentMessages.append(messageText)
        let newText = Message(context: self.context)
        newText.text = textView.text!
        self.sentMessages.append(newText)
        textView.text = ""
        saveItems()
        print("message sent")
    }
    
    //MARK: - to remove entity data
    //need for testing
    //    func removeCoreData() {
    //
    //        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Message")
    //        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    //
    //        do {
    //            try context.execute(deleteRequest)
    //        } catch let error as NSError {
    //            print(error.localizedDescription)
    //        }
    //    }
    
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
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        //        removeCoreData()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        textViewDidBeginEditing(textView)
        textViewDidEndEditing(textView)
        textView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        componentArranger()
        loadMessages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
    private func componentArranger() {
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
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: stackGap),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -stackGap),
            stackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            //          have to consider one more time
            
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
    
    
}

//MARK: - tableView datasource methods as an extension

extension ChatView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sentMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        cell.textLabel?.textColor = .textColor
        cell.textLabel?.textAlignment = .right
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        //        cell.contentView.addSubview(rightBubble)
        let message = sentMessages[indexPath.row]
        cell.textLabel?.text = message.text
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return UITableView.automaticDimension
//        } else {
//            return 40
//        }
//    }
//
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }
    
    
}

