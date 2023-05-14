//
//  TopView.swift
//  chatApp
//
//  Created by Ana Dzamelashvili on 4/19/23.
//

import Foundation
import UIKit
import CoreData

class ChatView: UIView {
    let tableView = UITableView()
    var sentMessages = [Message]()
    var typingArea = TextView()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.StackView.spacing
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    
    //MARK: - Load messages from coreData
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
    //    @objc private func sendMessage(sender: UIButton) {
    //        //        let messageText = textView.text ?? ""
    //        //        sentMessages.append(messageText)
    //        let newText = Message(context: self.context)
    //        newText.text = textView.text!
    //        self.sentMessages.append(newText)
    //        textView.text = ""
    //        saveItems()
    //        print("message sent")
    //    }
    //
    //MARK: - To remove entity data
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
    
    
    override init(frame:CGRect) {
        super.init(frame: .zero)
        //        removeCoreData()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        componentArranger()
        loadMessages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    private func componentArranger() {
        addSubview(stackView)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(typingArea)
        typingArea.translatesAutoresizingMaskIntoConstraints = false
        
        setUpConstraints()
    }
    
    //MARK: - Set up stackView and its components contraints
    func setUpConstraints() {
    
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.StackView.gap),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.StackView.gap),
            stackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            //          have to consider one more time
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
        sentMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textColor = Constants.Colors.textColor
        cell.textLabel?.textAlignment = .right
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        let message = sentMessages[indexPath.row]
        cell.textLabel?.text = message.text
        return cell
    }
    
    
}
