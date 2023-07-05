//
//  ChatViewModel.swift
//  test
//
//  Created by Ana Dzamelashvili on 5/23/23.
//

import Foundation
import UIKit

protocol ChatViewModelDelegate: AnyObject {
    func messagesLoaded()
}

class ChatViewModel {
    weak var delegate: ChatViewModelDelegate?
    private let coreDataManager = CoreDataManager()
    lazy var sentMessages = [MessageEntity]()
    
    
    func filteredMessages(currentUser: Int) -> [MessageEntity] {
        var filtered = [MessageEntity]()
        
        sentMessages.forEach { message in
            if message.userId == currentUser || !message.failedToSend {
                filtered.append(message)
            }
        }
        return filtered
    }
    
    
    //MARK: - Load messages from coreData
    func loadMessages() {
        if let messages = coreDataManager.loadObjects(with: coreDataManager.request) {
            sentMessages = messages
            delegate?.messagesLoaded()
        } else {
            print("Error fetching objects")
        }
    }
    
    //MARK: - Create new Message
    func sendMessages(with message: Message) {
        
        let newMessage = MessageEntity(context: coreDataManager.context)
        newMessage.userId = message.userId
        newMessage.text = message.text
        newMessage.failedToSend = message.failedToSend
        if NetworkManager.shared.isConnected {
            newMessage.date = message.date
        } else {
            newMessage.date = Constants.Label.errorLabel
        }
        
        sentMessages.append(newMessage)
        coreDataManager.saveItems()
        delegate?.messagesLoaded()
        print("Message sent")
    }
    
    //MARK: - Remove data from coreData (for testing)
    func removeMessages() {
        coreDataManager.removeData(entityType: MessageEntity.self)
        delegate?.messagesLoaded()
    }
    
    
    func numberOfMessages(currentUser: Int) -> Int {
        let filtered = filteredMessages(currentUser: currentUser)
        return filtered.count
    }
    
    
    //MARK: - Get a message at a specific index
    func message(at index: Int, currentUser: Int) -> MessageEntity {
        let filtered = filteredMessages(currentUser: currentUser)
        return filtered[index]
    }
    
}
