//
//  ChatModel.swift
//  test
//
//  Created by Ana Dzamelashvili on 5/17/23.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request: NSFetchRequest<MessageEntity> = MessageEntity.fetchRequest()
    
    //    MARK: - Load messages from coreData
    func loadObjects<T: NSManagedObject>(with request: NSFetchRequest<T>) -> [T]? {
        do {
            let fetchedObjects = try context.fetch(request)
            return fetchedObjects
        } catch {
            print("Error fetching data from context: \(error)")
            return nil
        }
    }
    
    //MARK: - To remove entity data
    func removeData<T: NSManagedObject>(entityType: T.Type) {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: entityType))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - TableView Data Manipulation method
    func saveItems() {
        do {
            try context.save()
            
        } catch {
            print("Error saving context \(error)")
            
        }
        
    }
    
}
