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
    
}
