//
//  DataManager.swift
//  witchie
//
//  Created by jpbol on 03/08/2023.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
    let container = NSPersistentContainer(name: "User")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully. WUHU!!!")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addUser(context: NSManagedObjectContext) {
        let user = User(context: context)
        user.currentLevel = Int16(0)
        user.isSoundOn = true
        save(context: context)
    }
    
    func editUser(user: User, currentLevel: Int16, isSoundOn: Bool, context: NSManagedObjectContext) {
        user.currentLevel = currentLevel
        user.isSoundOn = isSoundOn
        save(context: context)
    }
    
}
