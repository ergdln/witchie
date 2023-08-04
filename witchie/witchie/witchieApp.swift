//
//  witchieApp.swift
//  witchie
//
//  Created by egln on 20/07/23.
//

import SwiftUI

@main
struct witchieApp: App {
    @StateObject private var dataManager = DataManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}
