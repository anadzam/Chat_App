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
    private var sentMessages = [MessageEntity]()
   
     
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
    func sendMessages(with text: String, userId: Int32, date: String, failedToSend: Bool) {
        let newMessage = MessageEntity(context: coreDataManager.context)
        newMessage.userId = userId
        newMessage.text = text
        newMessage.failedToSend = failedToSend
        
        if NetworkManager.shared.isConnected {
            newMessage.date = date
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
    
    
    func numberOfMessages() -> Int {
        return sentMessages.count
    }
    
    //MARK: - Get a message at a specific index
    func message(at index: Int) -> MessageEntity {
        return sentMessages[index]
    }
    
    
}

